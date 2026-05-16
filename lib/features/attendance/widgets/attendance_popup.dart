import 'package:flutter/material.dart';

class AttendancePopup {

  static void show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {

    showGeneralDialog(
      context: context,

      barrierDismissible: true,

      barrierLabel: "",

      transitionDuration:
          const Duration(
        milliseconds: 450,
      ),

      pageBuilder:
          (_, __, ___) {

        return Center(

          child: Container(
            margin:
                const EdgeInsets.all(
              30,
            ),

            padding:
                const EdgeInsets.all(
              24,
            ),

            decoration:
                BoxDecoration(

              borderRadius:
                  BorderRadius.circular(
                28,
              ),

              gradient:
                  const LinearGradient(
                colors: [
                  Color(
                      0xff111827),
                  Color(
                      0xff1e293b),
                ],
              ),

              boxShadow: [

                BoxShadow(
                  color:
                      color.withOpacity(
                    .35,
                  ),

                  blurRadius: 30,
                  spreadRadius: 3,
                )
              ],
            ),

            child: Material(
              color:
                  Colors.transparent,

              child: Column(
                mainAxisSize:
                    MainAxisSize.min,

                children: [

                  TweenAnimationBuilder(
                    tween:
                        Tween(
                      begin: .5,
                      end: 1.0,
                    ),

                    duration:
                        const Duration(
                      milliseconds:
                          500,
                    ),

                    builder:
                        (
                      context,
                      value,
                      child,
                    ) {

                      return Transform.scale(
                        scale:
                            value,

                        child:
                            child,
                      );
                    },

                    child:
                        Container(
                      width:
                          90,
                      height:
                          90,

                      decoration:
                          BoxDecoration(
                        shape:
                            BoxShape
                                .circle,

                        color: color
                            .withOpacity(
                          .15,
                        ),
                      ),

                      child:
                          Icon(
                        icon,
                        color:
                            color,
                        size:
                            50,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height:
                          24),

                  Text(
                    title,

                    style:
                        const TextStyle(
                      color:
                          Colors.white,

                      fontSize:
                          24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height:
                          10),

                  Text(
                    subtitle,

                    textAlign:
                        TextAlign.center,

                    style:
                        TextStyle(
                      color:
                          Colors.grey.shade300,

                      height:
                          1.5,
                    ),
                  ),

                  const SizedBox(
                      height:
                          30),

                  SizedBox(
                    width:
                        double.infinity,

                    child:
                        ElevatedButton(

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            color,

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),

                      onPressed:
                          () {
                        Navigator.pop(
                            context);
                      },

                      child:
                          const Text(
                        "DONE",

                        style:
                            TextStyle(
                          color:
                              Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },

      transitionBuilder:
          (
        context,
        animation,
        _,
        child,
      ) {

        return FadeTransition(

          opacity:
              animation,

          child:
              ScaleTransition(
            scale:
                animation,
            child:
                child,
          ),
        );
      },
    );
  }
}