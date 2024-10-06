enum EventStatusEnum {
  accepted,
  declined,
  unknown,
  undefined,
  warning,
}

extension EventStatusEnumExtension on EventStatusEnum {
  static EventStatusEnum fromString(String type) {
    return EventStatusEnum.values.firstWhere(
      (e) => e.toString().split('.').last == type,
      orElse: () => throw ArgumentError('Invalid EventTypeEnum value'),
    );
  }
}
