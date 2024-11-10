import '/helpers/utils.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<String?> getMethod(String url) async {
    try {
      final request = http.Request('GET', Uri.parse(url));

      request.headers.addAll({
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNTBiNzAzZDM4ZDkzNTUzZjZkOTE2ODJmMGVkMDk3OSIsIm5iZiI6MTczMTIzOTU2OS42ODk0NSwic3ViIjoiNjczMDlkN2ExMWI2Y2MwNTcxZjY1NjE1Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.P505qELUEocRudzQjm7krmwe2cbmT9CtgDoc7PYy6TA',
      });

      http.StreamedResponse response = await request.send();
      final result = await response.stream.bytesToString();

      if (response.statusCode == 401) {
        logger.e(response.reasonPhrase);
        return null;
      } else if (response.statusCode == 200) {
        return result;
      } else {
        if (kDebugMode) logger.e("${response.statusCode}>>>${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      if (kDebugMode) logger.e('Error occurred: $e');
      return null;
    }
  }
}
