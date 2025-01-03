import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';

class RondaEntity extends Equatable {
  final int id;
  final String publicUrl;
  final int ronda;
  final String eventName;

  const RondaEntity({
    required this.id,
    required this.publicUrl,
    required this.ronda,
    required this.eventName,
  });

  @override
  List<Object?> get props {
    return [id, publicUrl, ronda, eventName];
  }

  // Factory constructor to create an RondaEntity from RondaModel
  factory RondaEntity.fromModel(RondaModel model) {
    return RondaEntity(
      id: model.id ?? 0,
      publicUrl: model.publicUrl ?? '',
      ronda: model.ronda ?? 0,
      eventName: model.eventName ?? '',
    );
  }

  // Convert the entity to RondaModel
  RondaModel toModel() {
    return RondaModel(
      id: id,
      publicUrl: publicUrl,
      ronda: ronda,
      eventName: eventName,
    );
  }

  RondaEntity copyWith() {
    return RondaEntity(
      id: id,
      publicUrl: publicUrl,
      ronda: ronda,
      eventName: eventName,
    );
  }
}
