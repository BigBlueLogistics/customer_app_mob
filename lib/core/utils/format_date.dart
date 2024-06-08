import 'package:intl/intl.dart';
import 'package:customer_app_mob/extensions/validation.dart';

String formatDate(String date, [String? patternDate = 'MM/dd/y']) {
  if (date.isNotEmpty && date.isValidDateString) {
    DateTime formattedDate = DateTime.parse(date).toLocal();

    return DateFormat(patternDate).format(formattedDate);
  }
  return '';
}
