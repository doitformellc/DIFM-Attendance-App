import 'package:difm_attendance_app/core/constants/policy_constants.dart';
import 'package:difm_attendance_app/core/services/storage_service.dart';
import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() =>
      _PolicyScreenState();
}

class _PolicyScreenState
    extends State<PolicyScreen> {
  final ScrollController
      _scrollController =
      ScrollController();

  bool _reachedBottom = false;

  // CHANGE TO false IN PRODUCTION
  final bool testingMode = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_reachedBottom) return;

      final position =
          _scrollController.position;

      if (position.pixels >=
          position.maxScrollExtent - 50) {
        setState(() {
          _reachedBottom = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _acceptPolicy() async {
    await StorageService
        .savePolicyVersion(
      PolicyConstants
          .currentPolicyVersion,
    );

    if (!mounted) return;

    final args =
        ModalRoute.of(context)
            ?.settings
            .arguments;

    final role =
        args is Map
            ? args['role']
            : null;

    switch (role) {
      case 'hr':
        Navigator.pushReplacementNamed(
          context,
          '/hr-dashboard',
        );
        break;

      case 'admin':
        Navigator.pushReplacementNamed(
          context,
          '/admin-dashboard',
        );
        break;

      case 'intern':
      default:
        Navigator.pushReplacementNamed(
          context,
          '/intern-dashboard',
        );
    }
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xff0f172a),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,
        elevation: 0,
        title: const Text(
          'Attendance Policy',
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        actions: [
          if (testingMode)
            Container(
              margin:
                  const EdgeInsets.only(
                right: 16,
                top: 10,
                bottom: 10,
              ),
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration:
                  BoxDecoration(
                color:
                    Colors.orange,
                borderRadius:
                    BorderRadius
                        .circular(
                  20,
                ),
              ),
              child: const Center(
                child: Text(
                  "TEST",
                  style: TextStyle(
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            )
        ],
      ),

      body: Container(
        decoration:
            const BoxDecoration(
          gradient:
              LinearGradient(
            colors: [
              Color(0xff0f172a),
              Color(0xff111827),
              Color(0xff1e293b),
            ],
            begin:
                Alignment.topLeft,
            end: Alignment
                .bottomRight,
          ),
        ),

        child: Padding(
          padding:
              const EdgeInsets.all(
            20,
          ),

          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets
                          .all(
                    20,
                  ),

                  decoration:
                      BoxDecoration(
                    color: Colors
                        .white
                        .withOpacity(
                      .08,
                    ),

                    borderRadius:
                        BorderRadius
                            .circular(
                      24,
                    ),
                  ),

                  child:
                      SingleChildScrollView(
                    controller:
                        _scrollController,

                    child:
                        const Text(
                      PolicyConstants
                          .attendancePolicyText,

                      style:
                          TextStyle(
                        color:
                            Colors
                                .white,
                        fontSize:
                            16,
                        height:
                            1.7,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              Text(
                testingMode
                    ? 'Testing mode: accept enabled'
                    : _reachedBottom
                        ? 'Policy read successfully'
                        : 'Scroll to bottom to enable accept',

                style: TextStyle(
                  color:
                      testingMode
                          ? Colors
                              .orange
                          : _reachedBottom
                              ? Colors.green
                              : Colors.orange,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width:
                    double.infinity,
                height: 58,

                child:
                    ElevatedButton(
                  style:
                      ElevatedButton
                          .styleFrom(
                    backgroundColor:
                        const Color(
                      0xff3b82f6,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed:
                      testingMode ||
                              _reachedBottom
                          ? _acceptPolicy
                          : null,

                  child:
                      const Text(
                    'ACCEPT POLICY',
                    style:
                        TextStyle(
                      color:
                          Colors.white,
                      fontSize:
                          16,
                      fontWeight:
                          FontWeight
                              .bold,
                      letterSpacing:
                          1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}