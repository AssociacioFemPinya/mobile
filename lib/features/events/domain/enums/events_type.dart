import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum EventTypeEnum {
  training,
  performance,
  activity,
}

extension EventTypeEnumExtension on EventTypeEnum {
  static EventTypeEnum fromString(String type) {
    return EventTypeEnum.values.firstWhere(
      (e) => e.toString().split('.').last == type,
      orElse: () => throw ArgumentError('Invalid EventTypeEnum value'),
    );
  }

  String toLocalizedString(BuildContext context) {
    switch (this) {
      case EventTypeEnum.training:
        return AppLocalizations.of(context)!.eventsPageTypeChipTraining;
      case EventTypeEnum.performance:
        return AppLocalizations.of(context)!.eventsPageTypeChipPerformance;
      case EventTypeEnum.activity:
        return AppLocalizations.of(context)!.eventsPageTypeChipActivity;
      default:
        return '';
    }
  }
}
