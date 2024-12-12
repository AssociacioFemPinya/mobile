import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String mail;
  final String password;

  const UserEntity(
      {required this.id,
      required this.name,
      required this.mail,
      required this.password});

  @override
  List<Object?> get props {
    return [id, name, mail];
  }

  // Factory constructor to create an EventEntity from EventModel
  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      mail: model.mail,
      password: model.password,
    );
  }

  // Convert the entity to EventModel
  UserModel toModel() {
    return UserModel(
      id: id,
      name: name,
      mail: mail,
      password: password,
    );
  }

  UserEntity copyWith({bool? isEnabled}) {
    return UserEntity(
      id: id,
      name: name,
      mail: mail,
      password: password,
    );
  }

  static const empty = UserEntity(id: 0, name: '-', mail: '-', password: '-');
}
