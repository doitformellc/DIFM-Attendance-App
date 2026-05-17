import '../../../core/constants/api_constants.dart';
import '../../../core/services/api_service.dart';

class AttendanceService {

  static Future<dynamic> checkIn({
    required double latitude,
    required double longitude,
    required String address,
  }) async {

    return await ApiService.post(
      url:
      '${ApiConstants.baseUrl}/attendance/check-in',

      body: {
        "latitude": latitude,
        "longitude": longitude,
        "location": address,
        "faceVerified": true
      },
    );
  }

  static Future<dynamic> checkout({
    required double latitude,
    required double longitude,
    required String address,
  }) async {

    return await ApiService.post(
      url:
      '${ApiConstants.baseUrl}/attendance/check-out',

      body: {
        "latitude": latitude,
        "longitude": longitude,
        "location": address
      },
    );
  }

  static Future<dynamic> startBreak() async {
    return await ApiService.post(
      url:
      '${ApiConstants.baseUrl}/attendance/break/start',
      body:{},
    );
  }

  static Future<dynamic> endBreak() async {
    return await ApiService.post(
      url:
      '${ApiConstants.baseUrl}/attendance/break/end',
      body:{},
    );
  }

  static Future<dynamic> getHistory() async {
    return await ApiService.get(
      url:
      '${ApiConstants.baseUrl}/attendance/history',
    );
  }
}