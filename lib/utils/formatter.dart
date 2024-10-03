import 'package:intl/intl.dart';

class Formatter {
  static
// 날짜 포맷팅 함수
      String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd – HH:mm').format(dateTime);
  }
}
