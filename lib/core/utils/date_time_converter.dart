import 'package:drift/drift.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal();

  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}

class DateTimeTypeConverter implements TypeConverter<String, DateTime> {
  @override
  String fromSql(DateTime fromDb) => fromDb.toUtc().toIso8601String();

  @override
  DateTime toSql(String value) => DateTime.parse(value).toLocal();
}
