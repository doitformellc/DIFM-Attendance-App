import {
  checkInService,
  checkOutService
} from "./attendance.service.js";

export const checkInController = async (
  req,
  res
) => {
  try {

    const userId =
      req.user.userId;

    const {
      latitude,
      longitude,
      location,
      faceVerified
    } = req.body;

    console.log(
      "CHECKIN DATA:",
      req.body
    );

    const attendance =
      await checkInService({
        userId,
        latitude,
        longitude,
        location,
        faceVerified
      });

    return res.status(201).json({
      success:true,
      message:
        "Check-in successful",
      data:attendance
    });

  } catch(error){

    return res.status(400).json({
      success:false,
      message:error.message
    });
  }
};


export const checkOutController =
async(req,res)=>{

  try{

    const userId=
      req.user.userId;

    const {
      latitude,
      longitude,
      location
    }=req.body;

    const attendance=
      await checkOutService({

        userId,
        latitude,
        longitude,
        location
      });

    return res.status(200).json({
      success:true,
      message:
      "Check-out successful",
      data:attendance
    });

  }catch(error){

    return res.status(400).json({
      success:false,
      message:error.message
    });
  }
};