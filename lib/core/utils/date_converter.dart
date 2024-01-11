import 'package:floor/floor.dart';
import 'package:intl/intl.dart';

// ignore: avoid_classes_with_only_static_members
class DateConverter {
  /// change dt to our dateFormat ---Jun 23--- for Example
  // ignore: type_annotate_public_apis
  static String changeDtToDateTime(int? dt) {
    final formatter = DateFormat.MMMd();
    final result = formatter.format(
      DateTime.fromMillisecondsSinceEpoch(dt! * 1000, isUtc: true),
    );
    return result;
  }

  /// change dt to our dateFormat ---5:55 AM/PM--- for Example
  // ignore: type_annotate_public_apis
  static String changeDtToDateTimeHour(int? dt, int? timeZone) {
    final formatter = DateFormat.jm();
    return formatter.format(
      DateTime.fromMillisecondsSinceEpoch(
        (dt! * 1000) + timeZone! * 1000,
        isUtc: true,
      ),
    );
  }
}

class TimeStampConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}
