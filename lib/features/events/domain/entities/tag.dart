import 'package:equatable/equatable.dart';
import 'package:fempinya3_flutter_app/features/events/data/models/tag.dart';

class TagEntity extends Equatable {
  final int id;
  final String name;
  final bool isEnabled;

  const TagEntity({required this.id, required this.name, required this.isEnabled});  

  @override
  List<Object?> get props {
    return [id, name, isEnabled];
  }

  // Factory constructor to create an EventEntity from EventModel
  factory TagEntity.fromModel(TagModel model) {
    return TagEntity(
      id: model.id,
      name: model.name,
      isEnabled: model.isEnabled,
    );
  }

  // Convert the entity to EventModel
  TagModel toModel() {
    return TagModel(
      id: id,
      name: name,
      isEnabled: isEnabled,
    );
  }
}
