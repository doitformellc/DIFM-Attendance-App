import pool from "../../config/db.js";
import { buildShiftWindow } from "./attendance.utils.js";


export const checkInService = async (userId) => {
  const client = await pool.connect();
  const today = new Date()
    .toISOString()
    .split("T")[0];
  console.log("USER ID =", userId);
  console.log("TODAY =", today);
  try {
    await client.query("BEGIN");

    const shiftQuery = `
  SELECT
    sa.id AS shift_assignment_id,
    sa.user_id,
    sa.effective_date,

    s.id AS shift_id,
    s.name,
    s.shift_type,
    s.start_time,
    s.end_time,
    s.duration_hours,
    s.grace_period_min,
    s.is_night_shift

  FROM shift_assignments sa

  INNER JOIN shifts s
  ON s.id = sa.shift_id

  WHERE sa.user_id = $1
  AND sa.effective_date <= $2

  ORDER BY sa.effective_date DESC

  LIMIT 1
`;

    const shiftResult =
      await client.query(
        shiftQuery,
        [userId, today]
      );
    console.log("Shift query result == ", shiftResult.rows)
    if (shiftResult.rows.length === 0) {
      throw new Error("No shift assigned");
    }

    const shift = shiftResult.rows[0];
    const existingAttendance = await client.query(
      `
      SELECT *
      FROM attendance_records
      WHERE user_id = $1
      AND checkout_ts IS NULL
      `,
      [userId]
    );

    if (existingAttendance.rows.length > 0) {
      throw new Error("Already checked in");
    }
    const now = new Date();
    const { shiftStart } = buildShiftWindow(shift, now);
    const shiftDate = shiftStart.toISOString().split("T")[0];
    const currentTimestamp = Date.now();
    const insertQuery = `
      INSERT INTO attendance_records (
        user_id,
        shift_assignment_id,
        shift_date,
        checkin_ts,
        status
      )
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
    `;
    const attendanceResult = await client.query(insertQuery, [
      userId,
      shift.shift_assignment_id,
      shiftDate,
      currentTimestamp,
      "PRESENT",
    ]);
    await client.query("COMMIT");
    return attendanceResult.rows[0];
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};

export const checkOutService = async (userId) => {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    const attendanceQuery = `
      SELECT *
      FROM attendance_records
      WHERE user_id = $1
      AND checkout_ts IS NULL
      ORDER BY checkin_ts DESC
      LIMIT 1
    `;
    const attendanceResult = await client.query(
      attendanceQuery,
      [userId]
    );
    if (attendanceResult.rows.length === 0) {
      throw new Error("No active attendance found");
    }

    const attendance = attendanceResult.rows[0];
    const checkoutTimestamp = Date.now();
    const grossHours =
      (checkoutTimestamp - attendance.checkin_ts) /
      (1000 * 60 * 60);
    const updateQuery = `
      UPDATE attendance_records
      SET
        checkout_ts = $1,
        gross_hours = $2,
        updated_at = NOW()
      WHERE id = $3
      RETURNING *
    `;
    const updatedAttendance = await client.query(updateQuery, [
      checkoutTimestamp,
      grossHours,
      attendance.id,
    ]);
    await client.query("COMMIT");
    return updatedAttendance.rows[0];
  } catch (error) {
    await client.query("ROLLBACK");
    throw error;
  } finally {
    client.release();
  }
};