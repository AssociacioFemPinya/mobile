import 'package:fempinya3_flutter_app/features/login/login.dart';

import 'package:dio/dio.dart';

abstract class GetUserHandler {
  static void handle(
    UsersDioMockInterceptor mock,
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    Response<dynamic> response;

    final userEntity = mock.user;

    final responseData = {
      "castellerActiveId": userEntity.castellerActiveId,
      "castellerActiveAlias": userEntity.castellerActiveAlias,
      "linkedCastellers": userEntity.linkedCastellers.map((casteller) {
        return {
          "idCastellerApiUser": casteller.idCastellerApiUser,
          "apiUserId": casteller.apiUserId,
          "castellerId": casteller.castellerId,
        };
      }).toList(),
      "boardsEnabled": userEntity.boardsEnabled,
    };

    response = Response(
      requestOptions: options,
      data: responseData,
      statusCode: 200,
    );
    handler.resolve(response);
    return;
  }
}
