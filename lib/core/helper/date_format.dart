import 'package:intl/intl.dart';


String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

String formatStringDate(String isoDate) {
  try {
    // Parse the given ISO8601 date string
    final dateTime = DateTime.parse(isoDate);

    // Format into dd/MM/yyyy
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  } catch (e) {
    return "Invalid Date"; // fallback in case parsing fails
  }
}
