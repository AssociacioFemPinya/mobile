class UserModel {
  final int castellerActiveId;
  final String castellerActiveAlias;
  final List<LinkedCasteller> linkedCastellers;
  final bool boardsEnabled;

  UserModel({
    required this.castellerActiveId,
    required this.castellerActiveAlias,
    required this.linkedCastellers,
    required this.boardsEnabled,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'castellerActiveId': castellerActiveId,
      'castellerActiveAlias': castellerActiveAlias,
      'linkedCastellers':
          linkedCastellers.map((casteller) => casteller.toJson()).toList(),
      'boardsEnabled': boardsEnabled,
    };
  }

  // Factory constructor for JSON deserialization
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      castellerActiveId: data['castellerActiveId'] as int,
      castellerActiveAlias: data['castellerActiveAlias'] as String,
      linkedCastellers: (data['linkedCastellers'] as List?)
              ?.map((castellerData) {
                // Ensure castellerData is a Map
                if (castellerData is Map<String, dynamic>) {
                  return LinkedCasteller.fromJson(castellerData);
                }
                // Handle the case where castellerData is not a Map
                return null;
              })
              .whereType<LinkedCasteller>() // Filter out any null values
              .toList() ??
          [],
      boardsEnabled: data['boardsEnabled'] as bool,
    );
  }
}

class LinkedCasteller {
  final int idCastellerApiUser;
  final int apiUserId;
  final int castellerId;


  LinkedCasteller({
    required this.idCastellerApiUser,
    required this.apiUserId,
    required this.castellerId,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'idCastellerApiUser': idCastellerApiUser,
      'apiUserId': apiUserId,
      'castellerId': castellerId,
    };
  }

  // Factory constructor for JSON deserialization
factory LinkedCasteller.fromJson(Map<String, dynamic> data) {
    return LinkedCasteller(
      idCastellerApiUser: data['idCastellerApiUser'] as int? ?? 0,
      apiUserId: data['apiUserId'] as int? ?? 0,
      castellerId: data['castellerId'] as int? ?? 0,
    );
  }
}
