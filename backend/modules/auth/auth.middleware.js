import dotenv from "dotenv";
dotenv.config();

import jwt from "jsonwebtoken";
import pool from "../../config/db.js"

export const authenticate =
  async (req, res, next) => {
    try {
      const authHeader = req.headers.authorization;
      if (
        !authHeader ||
        !authHeader.startsWith(
          "Bearer "
        )
      ) {
        return res.status(401).json({
          success: false,
          message:
            "Access token missing",
        });
      }
      const token = authHeader.split(" ")[1];
      const decoded = jwt.verify(
        token,
        process.env.JWT_ACCESS_SECRET
      );
      const result = await pool.query(
        `
        SELECT
          id,
          email,
          role,
          is_active,
          policy_accepted_at
        FROM users
        WHERE id = $1
        LIMIT 1
        `,
        [decoded.userId]
      );
      const user =
        result.rows[0];
      if (!user) {
        return res.status(401).json({
          success: false,
          message:
            "User not found",
        });
      }
      if (!user.is_active) {
        return res.status(403).json({
          success: false,
          message:
            "Account disabled",
        });
      }
      req.user = {
        userId: user.id,
        email: user.email,
        role: user.role,
        policyAcceptedAt:
          user.policy_accepted_at,
      };
      next();
    } catch (error) {
      return res.status(401).json({
        success: false,

        message:
          "Unauthorized",
      });
    }
  };
export const authorizeRoles =
  (...roles) => {
    return (
      req,
      res,
      next
    ) => {

      if (
        !roles.includes(
          req.user.role
        )
      ) {
        return res.status(403).json({
          success: false,

          message:
            "Forbidden",
        });
      }

      next();
    };
  };
export const policyAccepted =
  (
    req,
    res,
    next
  ) => {
    if (
      !req.user.policyAcceptedAt
    ) {
      return res.status(403).json({
        success: false,

        message:
          "Attendance policy not accepted",
      });
    }
    next();
  };