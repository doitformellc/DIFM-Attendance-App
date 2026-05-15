import { checkInService,checkOutService } from "./attendance.service.js";

export const checkInController = async (req, res) => {
  try {
    const userId = req.user.userId;
    console.log("User ID in check-in controller == ", userId);
    const attendance = await checkInService(userId);
    return res.status(201).json({
      success: true,
      message: "Check-in successful",
      data: attendance,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

export const checkOutController = async (req, res) => {
  try {
    const userId = req.user.id;

    const attendance = await checkOutService(userId);

    return res.status(200).json({
      success: true,
      message: "Check-out successful",
      data: attendance,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};