import dotenv from "dotenv";
dotenv.config();
import express from "express";
import authRouter from "./modules/auth/auth.routes.js";
import logger from "./utils/logger.js";
import db from "./config/db.js";
import bcrypt from 'bcryptjs'
import cookieParser from 'cookie-parser'
import cors from "cors";
import shiftrouter from "./modules/shifts/shifts.router.js";
import attendanceRouter from "./modules/attendance/attendance.route.js";
const app = express();

async function testDbConnection() {
    try {
        const client = await db.connect();
        console.log("Database connected successfully");
        client.release();
    } catch (error) {
        console.error("Database connection failed");
        console.error(error);
        process.exit(1);
    }
}
app.use(
    cors({
        origin: true,
        credentials: true,
        methods: [
            "GET",
            "POST",
            "PUT",
            "PATCH",
            "DELETE",
            "OPTIONS"
        ],
        allowedHeaders: [
            "Content-Type",
            "Authorization"
        ]
    })
);
app.use(cookieParser());
app.use(express.json());

app.get("/", (req, res) => {
    res.json({
        message: "Attendance Backend Running",
    });
});
app.use("/auth", authRouter);
app.use("/shifts",shiftrouter);
app.use("/attendance",attendanceRouter)
async function startServer() {
    await testDbConnection();
    logger.info("Server is starting");
    app.listen(3000, () => {
        console.log("Server is running on port 3000");
    });
}

startServer();