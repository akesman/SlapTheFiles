import 'package:intl/intl.dart';

class Tools {
  static String getLocalString(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}
