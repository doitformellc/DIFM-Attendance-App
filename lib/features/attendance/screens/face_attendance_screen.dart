import 'package:camera/camera.dart';
import 'package:face_detection_tflite/face_detection_tflite.dart' as facelite;
import 'package:flutter/material.dart';

enum FaceAttendanceAction { checkIn, checkOut }

class FaceAttendanceScreen extends StatefulWidget {
  final FaceAttendanceAction action;

  const FaceAttendanceScreen({super.key, required this.action});

  @override
  State<FaceAttendanceScreen> createState() => _FaceAttendanceScreenState();
}

class _FaceAttendanceScreenState extends State<FaceAttendanceScreen> {
  CameraController? cameraController;
  CameraDescription? camera;
  facelite.FaceDetector? faceDetector;
  bool isInitializing = true;
  bool isDetecting = false;
  bool isVerified = false;
  String? errorMessage;
  int detectedFrameCount = 0;

  String get actionLabel =>
      widget.action == FaceAttendanceAction.checkIn ? 'Check In' : 'Check Out';

  Color get actionColor => widget.action == FaceAttendanceAction.checkIn
      ? Colors.green
      : Colors.redAccent;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final detector = await facelite.FaceDetector.create(
        model: facelite.FaceDetectionModel.frontCamera,
      );
      final cameras = await availableCameras();
      camera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        camera!,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await controller.initialize();
      await controller.startImageStream(processCameraImage);

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        cameraController = controller;
        faceDetector = detector;
        isInitializing = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString();
        isInitializing = false;
      });
    }
  }

  Future<void> processCameraImage(CameraImage image) async {
    if (isDetecting || isVerified) return;

    final detector = faceDetector;
    if (detector == null) return;

    isDetecting = true;

    try {
      final faces = await detector.detectFacesFromCameraImage(
        image,
        mode: facelite.FaceDetectionMode.fast,
        maxDim: 640,
      );

      if (!mounted) return;

      final hasFace = faces.isNotEmpty;
      detectedFrameCount = hasFace ? detectedFrameCount + 1 : 0;

      if (detectedFrameCount >= 3) {
        await cameraController?.stopImageStream();
        setState(() {
          isVerified = true;
          errorMessage = null;
        });
      } else if (mounted) {
        setState(() {});
      }
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString();
      });
    } finally {
      isDetecting = false;
    }
  }

  void completeAction() {
    Navigator.pop(context, true);
  }

  Future<void> retryDetection() async {
    setState(() {
      isVerified = false;
      errorMessage = null;
      detectedFrameCount = 0;
    });

    await cameraController?.startImageStream(processCameraImage);
  }

  @override
  void dispose() {
    cameraController?.dispose();
    faceDetector?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = cameraController;

    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Face $actionLabel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: isInitializing
                      ? const Center(child: CircularProgressIndicator())
                      : controller == null || !controller.value.isInitialized
                      ? _StatusPanel(
                          icon: Icons.videocam_off,
                          title: 'Camera unavailable',
                          subtitle: errorMessage ?? 'Unable to open camera',
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: [
                            CameraPreview(controller),
                            Center(
                              child: Container(
                                width: 230,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(120),
                                  border: Border.all(
                                    color: isVerified
                                        ? Colors.green
                                        : Colors.white,
                                    width: 4,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 18,
                              right: 18,
                              bottom: 18,
                              child: _StatusPanel(
                                icon: isVerified
                                    ? Icons.verified_user
                                    : Icons.face_retouching_natural,
                                title: isVerified
                                    ? 'Face detected'
                                    : 'Place your face in the frame',
                                subtitle: isVerified
                                    ? 'You can now continue with $actionLabel.'
                                    : 'Keep your face steady for verification.',
                                compact: true,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 14),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ],
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: isVerified
                    ? completeAction
                    : isInitializing
                    ? null
                    : retryDetection,
                icon: Icon(isVerified ? Icons.login_rounded : Icons.refresh),
                label: Text(isVerified ? actionLabel : 'Detect Face Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isVerified
                      ? actionColor
                      : const Color(0xff2563eb),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool compact;

  const _StatusPanel({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(compact ? 14 : 22),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.58),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: compact ? 28 : 48),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: compact ? 16 : 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
