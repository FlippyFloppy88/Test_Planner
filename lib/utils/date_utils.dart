// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('MMM d, yyyy');
final _dateTimeFormat = DateFormat('MMM d, yyyy h:mm a');

extension DateTimeFormatting on DateTime {
  String toDisplayDate() => _dateFormat.format(this);
  String toDisplayDateTime() => _dateTimeFormat.format(this);
}
