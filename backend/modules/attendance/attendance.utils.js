export const buildShiftWindow = (shift, referenceDate = new Date()) => {
    const shiftStart = new Date(referenceDate);
    const shiftEnd = new Date(referenceDate);

    const [startHour, startMinute] = shift.shift_start
        .split(":")
        .map(Number);
    const [endHour, endMinute] = shift.shift_end
        .split(":")
        .map(Number);
    shiftStart.setHours(startHour, startMinute, 0, 0);
    shiftEnd.setHours(endHour, endMinute, 0, 0);
    if (shiftEnd <= shiftStart) {
        shiftEnd.setDate(shiftEnd.getDate() + 1);
    }
    console.log("successfully built shift window == ", {
        shiftStart,
        shiftEnd,
        isOvernight: shiftEnd.getDate() !== shiftStart.getDate(),
    });
    return {
        shiftStart,
        shiftEnd,
        isOvernight: shiftEnd.getDate() !== shiftStart.getDate(),
    };
};