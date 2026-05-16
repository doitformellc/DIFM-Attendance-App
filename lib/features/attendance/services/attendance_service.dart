import '../../../core/constants/api_constants.dart';
import '../../../core/services/api_service.dart';

class AttendanceService {

static Future<dynamic> checkIn() async {

return await ApiService.post(
url:
'${ApiConstants.baseUrl}/attendance/check-in',
body:{},
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

static Future<dynamic> checkout() async {

return await ApiService.post(
url:
'${ApiConstants.baseUrl}/attendance/check-out',
body:{},
);

}

static Future<dynamic> getHistory() async {

return await ApiService.get(
url:
'${ApiConstants.baseUrl}/attendance/history',
);

}

static Future<dynamic> getMonthlySummary() async {

return await ApiService.get(
url:
'${ApiConstants.baseUrl}/attendance/monthly-summary',
);

}
}