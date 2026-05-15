import pool from "../../config/db.js";
import { buildShiftWindow } from "./attendance.utils.js";

export const checkInService = async (userId) => {
  const client = await pool.connect();

  try {
    await client.query("BEGIN");
    const shiftQuery = `
      SELECT sa.shift_id, s.*
      FROM shift_assignments sa
      JOIN shifts s ON s.id = sa.shift_id
      WHERE sa.user_id = $1
      ORDER BY sa.effective_from DESC
      LIMIT 1
    `;
    const shiftResult = await client.query(shiftQuery, [userId]);
    if (shiftResult.rows.length === 0) {
      throw new Error("No shift assigned");
    }
    const shift = shiftResult.rows[0];
    const existingAttendance = await client.query(
      `
      SELECT * FROM attendance
      WHERE user_id = $1
      AND check_out IS NULL
      `,
      [userId]
    );
    if (existingAttendance.rows.length > 0) {
      throw new Error("Already checked in");
    }
    const now = new Date();
    const { shiftStart } = buildShiftWindow(shift, now);
    const shiftDate = shiftStart.toISOString().split("T")[0];
    const attendanceInsert = `
      INSERT INTO attendance (
        user_id,
        shift_id,
        shift_date,
        check_in
      )
      VALUES ($1, $2, $3, NOW())
      RETURNING *
    `;
    const attendanceResult = await client.query(attendanceInsert, [
      userId,
      shift.shift_id,
      shiftDate,
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
      FROM attendance
      WHERE user_id = $1
      AND check_out IS NULL
      ORDER BY check_in DESC
      LIMIT 1
    `;
    const attendanceResult = await client.query(attendanceQuery, [
      userId,
    ]);
    if (attendanceResult.rows.length === 0) {
      throw new Error("No active attendance session found");
    }
    const attendance = attendanceResult.rows[0];
    const updateQuery = `
      UPDATE attendance
      SET check_out = NOW(),
          updated_at = NOW()
      WHERE id = $1
      RETURNING *
    `;
    const updatedAttendance = await client.query(updateQuery, [
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