import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import 'package:fempinya3_flutter_app/core/service_locator.dart';
import 'package:fempinya3_flutter_app/features/user_profile/user_profile.dart'
    hide sl;

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class GetUserProfileParamsMock extends GetUserProfileParams {}

class MockDio extends Mock implements Dio {}

class MockLogger extends Mock implements Logger {}

class MockUserProfileRepository extends Mock implements UserProfileRepository {}

class MockUserProfileService extends Mock implements UserProfileService {}

class ResponseFake extends Fake implements Response<dynamic> {}

void main() {
  Dio? _dio;
  Logger? _logger;
  UserProfileRepository? _userProfileRepository;
  UserProfileService? _userProfileService;

  setUpAll(() {
    registerFallbackValue(ResponseFake());
    setupCommonServiceLocator();
    setupUserProfileServiceLocator();
    _dio = sl<Dio>();
    _logger = sl<Logger>();
    _userProfileRepository = sl<UserProfileRepository>();
    _userProfileService = sl<UserProfileService>();
    _dio!.interceptors.clear();
    _dio!.interceptors.add(UserProfileDioMockInterceptor());
  });

  group('Mocks', () {
    group('UserProfileDioMockInterceptor', () {
      late UserProfileDioMockInterceptor interceptor;
      late RequestOptions options;
      late MockRequestInterceptorHandler handler;

      setUp(() {
        interceptor = UserProfileDioMockInterceptor();
        options = RequestOptions(path: UserProfileApiEndpoints.getUserProfile);
        handler = MockRequestInterceptorHandler();
      });

      test('should generate a user profile', () {
        Map<String, dynamic> profile = interceptor.generateUserProfile();
        expect(profile, isNotNull);
        expect(profile['id_casteller'], 3942);
        expect(profile['name'], 'John');
      });

      test('should handle GET request for user profile', () async {
        options.method = 'GET';
        await interceptor.onRequest(options, handler);

        final captured = verify(() => handler.resolve(captureAny())).captured;
        final response = captured.first as Response;

        expect(response.statusCode, 200);
        expect(response.data, interceptor.userProfile);
      });
      test('should introduce random failures', () async {
        interceptor.percentageOfRandomFailures = 100;
        options.method = 'GET';
        await interceptor.onRequest(options, handler);

        final captured = verify(() => handler.resolve(captureAny())).captured;
        final response = captured.first as Response;

        expect(response.statusCode, 500);
      });

      test('should forward request if not mocking', () async {
        options.path = '/unknown';
        await interceptor.onRequest(options, handler);
        verify(() => handler.next(options)).called(1);
      });
    });
  });

  group('UserProfileModel', () {
    test('should create a UserProfileModel instance from JSON', () {
      final Map<String, dynamic> json = {
        'id_casteller': 3942,
        'id_casteller_external': 3678,
        'colla_id': 29,
        'num_soci': '12345',
        'nationality': 'Spanish',
        'national_id_number': 'X1234567Y',
        'national_id_type': 'DNI',
        'name': 'John',
        'last_name': 'Doe',
        'family': 'Doe Family',
        'family_head': 'Jane Doe',
        'alias': 'AIRUN',
        'gender': 1,
        'birthdate': '1990-01-15T00:00:00.000Z',
        'subscription_date': '2022-01-01T00:00:00.000Z',
        'email': 'john.doe@example.com',
        'email2': 'john.backup@example.com',
        'phone': '+34 123456789',
        'mobile_phone': '+34 987654321',
        'emergency_phone': '+34 112233445',
        'address': '123 Main Street',
        'postal_code': '08001',
        'city': 'Barcelona',
        'comarca': 'Barcelonès',
        'province': 'Barcelona',
        'country': 'Spain',
        'comments': 'No comments available.',
        'photo': 'path/to/dummy/photo.jpg',
        'height': 175,
        'weight': 70,
        'shoulder_height': 140,
        'status': 1,
        'language': 'Catalan',
        'interaction_type': 1,
        'created_at': '2023-06-20T21:05:41.000000Z',
        'updated_at': '2023-09-15T19:39:52.000000Z',
      };

      final userProfile = UserProfileModel.fromJson(json);

      expect(userProfile.idCasteller, 3942);
      expect(userProfile.idCastellerExternal, 3678);
      expect(userProfile.collaId, 29);
      expect(userProfile.numSoci, '12345');
      expect(userProfile.nationality, 'Spanish');
      expect(userProfile.nationalIdNumber, 'X1234567Y');
      expect(userProfile.nationalIdType, 'DNI');
      expect(userProfile.name, 'John');
      expect(userProfile.lastName, 'Doe');
      expect(userProfile.family, 'Doe Family');
      expect(userProfile.familyHead, 'Jane Doe');
      expect(userProfile.alias, 'AIRUN');
      expect(userProfile.gender, 1);
      expect(userProfile.birthdate, '1990-01-15T00:00:00.000Z');
      expect(userProfile.subscriptionDate, '2022-01-01T00:00:00.000Z');
      expect(userProfile.email, 'john.doe@example.com');
      expect(userProfile.email2, 'john.backup@example.com');
      expect(userProfile.phone, '+34 123456789');
      expect(userProfile.mobilePhone, '+34 987654321');
      expect(userProfile.emergencyPhone, '+34 112233445');
      expect(userProfile.address, '123 Main Street');
      expect(userProfile.postalCode, '08001');
      expect(userProfile.city, 'Barcelona');
      expect(userProfile.comarca, 'Barcelonès');
      expect(userProfile.province, 'Barcelona');
      expect(userProfile.country, 'Spain');
      expect(userProfile.comments, 'No comments available.');
      expect(userProfile.photo, 'path/to/dummy/photo.jpg');
      expect(userProfile.height, 175);
      expect(userProfile.weight, 70);
      expect(userProfile.shoulderHeight, 140);
      expect(userProfile.status, 1);
      expect(userProfile.language, 'Catalan');
      expect(userProfile.interactionType, 1);
      expect(userProfile.createdAt, '2023-06-20T21:05:41.000000Z');
      expect(userProfile.updatedAt, '2023-09-15T19:39:52.000000Z');
    });

    test('should convert a UserProfileModel instance to JSON', () {
      final userProfile = UserProfileModel(
        idCasteller: 3942,
        idCastellerExternal: 3678,
        collaId: 29,
        numSoci: '12345',
        nationality: 'Spanish',
        nationalIdNumber: 'X1234567Y',
        nationalIdType: 'DNI',
        name: 'John',
        lastName: 'Doe',
        family: 'Doe Family',
        familyHead: 'Jane Doe',
        alias: 'AIRUN',
        gender: 1,
        birthdate: '1990-01-15T00:00:00.000Z',
        subscriptionDate: '2022-01-01T00:00:00.000Z',
        email: 'john.doe@example.com',
        email2: 'john.backup@example.com',
        phone: '+34 123456789',
        mobilePhone: '+34 987654321',
        emergencyPhone: '+34 112233445',
        address: '123 Main Street',
        postalCode: '08001',
        city: 'Barcelona',
        comarca: 'Barcelonès',
        province: 'Barcelona',
        country: 'Spain',
        comments: 'No comments available.',
        photo: 'path/to/dummy/photo.jpg',
        height: 175,
        weight: 70,
        shoulderHeight: 140,
        status: 1,
        language: 'Catalan',
        interactionType: 1,
        createdAt: '2023-06-20T21:05:41.000000Z',
        updatedAt: '2023-09-15T19:39:52.000000Z',
      );

      final json = userProfile.toJson();

      expect(json['id_casteller'], 3942);
      expect(json['id_casteller_external'], 3678);
      expect(json['colla_id'], 29);
      expect(json['num_soci'], '12345');
      expect(json['nationality'], 'Spanish');
      expect(json['national_id_number'], 'X1234567Y');
      expect(json['national_id_type'], 'DNI');
      expect(json['name'], 'John');
      expect(json['last_name'], 'Doe');
      expect(json['family'], 'Doe Family');
      expect(json['family_head'], 'Jane Doe');
      expect(json['alias'], 'AIRUN');
      expect(json['gender'], 1);
      expect(json['birthdate'], '1990-01-15T00:00:00.000Z');
      expect(json['subscription_date'], '2022-01-01T00:00:00.000Z');
      expect(json['email'], 'john.doe@example.com');
      expect(json['email2'], 'john.backup@example.com');
      expect(json['phone'], '+34 123456789');
      expect(json['mobile_phone'], '+34 987654321');
      expect(json['emergency_phone'], '+34 112233445');
      expect(json['address'], '123 Main Street');
      expect(json['postal_code'], '08001');
      expect(json['city'], 'Barcelona');
      expect(json['comarca'], 'Barcelonès');
      expect(json['province'], 'Barcelona');
      expect(json['country'], 'Spain');
      expect(json['comments'], 'No comments available.');
      expect(json['photo'], 'path/to/dummy/photo.jpg');
      expect(json['height'], 175);
      expect(json['weight'], 70);
      expect(json['shoulder_height'], 140);
      expect(json['status'], 1);
      expect(json['language'], 'Catalan');
      expect(json['interaction_type'], 1);
      expect(json['created_at'], '2023-06-20T21:05:41.000000Z');
      expect(json['updated_at'], '2023-09-15T19:39:52.000000Z');
    });
  });

  group('UserProfileEntity', () {
    test('should create a UserProfileEntity instance', () {
      final userProfileEntity = UserProfileEntity(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        nationality: 'Spanish',
        nationalIdNumber: 'X1234567Y',
        nationalIdType: 'DNI',
        name: 'John',
        lastName: 'Doe',
        family: 'Doe Family',
        familyHead: 'Jane Doe',
        alias: 'TestUser',
        gender: 1,
        birthdate: '1990-01-15T00:00:00.000Z',
        subscriptionDate: '2022-01-01T00:00:00.000Z',
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        mobilePhone: '987654321',
        emergencyPhone: '112233445',
        address: '123 Main Street',
        postalCode: '08001',
        city: 'Barcelona',
        comarca: 'Barcelonès',
        province: 'Barcelona',
        country: 'Spain',
        comments: 'No comments available.',
        photo: 'path/to/photo.jpg',
        height: 175,
        weight: 70,
        shoulderHeight: 140,
        status: 1,
        language: 'Catalan',
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      expect(userProfileEntity.idCasteller, 1);
      expect(userProfileEntity.idCastellerExternal, 1234);
      expect(userProfileEntity.collaId, 1);
      expect(userProfileEntity.numSoci, 'S001');
      expect(userProfileEntity.nationality, 'Spanish');
      expect(userProfileEntity.nationalIdNumber, 'X1234567Y');
      expect(userProfileEntity.nationalIdType, 'DNI');
      expect(userProfileEntity.name, 'John');
      expect(userProfileEntity.lastName, 'Doe');
      expect(userProfileEntity.family, 'Doe Family');
      expect(userProfileEntity.familyHead, 'Jane Doe');
      expect(userProfileEntity.alias, 'TestUser');
      expect(userProfileEntity.gender, 1);
      expect(userProfileEntity.birthdate, '1990-01-15T00:00:00.000Z');
      expect(userProfileEntity.subscriptionDate, '2022-01-01T00:00:00.000Z');
      expect(userProfileEntity.email, 'test@example.com');
      expect(userProfileEntity.email2, 'test2@example.com');
      expect(userProfileEntity.phone, '123456789');
      expect(userProfileEntity.mobilePhone, '987654321');
      expect(userProfileEntity.emergencyPhone, '112233445');
      expect(userProfileEntity.address, '123 Main Street');
      expect(userProfileEntity.postalCode, '08001');
      expect(userProfileEntity.city, 'Barcelona');
      expect(userProfileEntity.comarca, 'Barcelonès');
      expect(userProfileEntity.province, 'Barcelona');
      expect(userProfileEntity.country, 'Spain');
      expect(userProfileEntity.comments, 'No comments available.');
      expect(userProfileEntity.photo, 'path/to/photo.jpg');
      expect(userProfileEntity.height, 175);
      expect(userProfileEntity.weight, 70);
      expect(userProfileEntity.shoulderHeight, 140);
      expect(userProfileEntity.status, 1);
      expect(userProfileEntity.language, 'Catalan');
      expect(userProfileEntity.interactionType, 1);
      expect(userProfileEntity.createdAt, '2023-01-01T00:00:00.000Z');
      expect(userProfileEntity.updatedAt, '2023-01-01T00:00:00.000Z');
    });

    test('should support value equality', () {
      final userProfileEntity1 = UserProfileEntity(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        nationality: 'Spanish',
        nationalIdNumber: 'X1234567Y',
        nationalIdType: 'DNI',
        name: 'John',
        lastName: 'Doe',
        family: 'Doe Family',
        familyHead: 'Jane Doe',
        alias: 'TestUser',
        gender: 1,
        birthdate: '1990-01-15T00:00:00.000Z',
        subscriptionDate: '2022-01-01T00:00:00.000Z',
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        mobilePhone: '987654321',
        emergencyPhone: '112233445',
        address: '123 Main Street',
        postalCode: '08001',
        city: 'Barcelona',
        comarca: 'Barcelonès',
        province: 'Barcelona',
        country: 'Spain',
        comments: 'No comments available.',
        photo: 'path/to/photo.jpg',
        height: 175,
        weight: 70,
        shoulderHeight: 140,
        status: 1,
        language: 'Catalan',
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      final userProfileEntity2 = UserProfileEntity(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        nationality: 'Spanish',
        nationalIdNumber: 'X1234567Y',
        nationalIdType: 'DNI',
        name: 'John',
        lastName: 'Doe',
        family: 'Doe Family',
        familyHead: 'Jane Doe',
        alias: 'TestUser',
        gender: 1,
        birthdate: '1990-01-15T00:00:00.000Z',
        subscriptionDate: '2022-01-01T00:00:00.000Z',
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        mobilePhone: '987654321',
        emergencyPhone: '112233445',
        address: '123 Main Street',
        postalCode: '08001',
        city: 'Barcelona',
        comarca: 'Barcelonès',
        province: 'Barcelona',
        country: 'Spain',
        comments: 'No comments available.',
        photo: 'path/to/photo.jpg',
        height: 175,
        weight: 70,
        shoulderHeight: 140,
        status: 1,
        language: 'Catalan',
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      expect(userProfileEntity1, equals(userProfileEntity2));
    });

    test('should create a new instance with copyWith for all fields', () {
      final userProfileEntity = UserProfileEntity(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        nationality: 'Spanish',
        nationalIdNumber: 'X1234567Y',
        nationalIdType: 'DNI',
        name: 'John',
        lastName: 'Doe',
        family: 'Doe Family',
        familyHead: 'Jane Doe',
        alias: 'TestUser',
        gender: 1,
        birthdate: '1990-01-15T00:00:00.000Z',
        subscriptionDate: '2022-01-01T00:00:00.000Z',
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        mobilePhone: '987654321',
        emergencyPhone: '112233445',
        address: '123 Main Street',
        postalCode: '08001',
        city: 'Barcelona',
        comarca: 'Barcelonès',
        province: 'Barcelona',
        country: 'Spain',
        comments: 'No comments available.',
        photo: 'path/to/photo.jpg',
        height: 175,
        weight: 70,
        shoulderHeight: 140,
        status: 1,
        language: 'Catalan',
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      final newUserProfileEntity = userProfileEntity.copyWith(
        alias: 'NewUser',
        email: 'new@example.com',
      );

      expect(newUserProfileEntity.alias, 'NewUser');
      expect(newUserProfileEntity.email, 'new@example.com');
      expect(newUserProfileEntity.idCasteller, userProfileEntity.idCasteller);
      expect(newUserProfileEntity.idCastellerExternal,
          userProfileEntity.idCastellerExternal);
      expect(newUserProfileEntity.collaId, userProfileEntity.collaId);
      expect(newUserProfileEntity.numSoci, userProfileEntity.numSoci);
      expect(newUserProfileEntity.nationality, userProfileEntity.nationality);
      expect(newUserProfileEntity.nationalIdNumber,
          userProfileEntity.nationalIdNumber);
      expect(newUserProfileEntity.nationalIdType,
          userProfileEntity.nationalIdType);
      expect(newUserProfileEntity.name, userProfileEntity.name);
      expect(newUserProfileEntity.lastName, userProfileEntity.lastName);
      expect(newUserProfileEntity.family, userProfileEntity.family);
      expect(newUserProfileEntity.familyHead, userProfileEntity.familyHead);
      expect(newUserProfileEntity.gender, userProfileEntity.gender);
      expect(newUserProfileEntity.birthdate, userProfileEntity.birthdate);
      expect(newUserProfileEntity.subscriptionDate,
          userProfileEntity.subscriptionDate);
      expect(newUserProfileEntity.email2, userProfileEntity.email2);
      expect(newUserProfileEntity.phone, userProfileEntity.phone);
      expect(newUserProfileEntity.mobilePhone, userProfileEntity.mobilePhone);
      expect(newUserProfileEntity.emergencyPhone,
          userProfileEntity.emergencyPhone);
      expect(newUserProfileEntity.address, userProfileEntity.address);
      expect(newUserProfileEntity.postalCode, userProfileEntity.postalCode);
      expect(newUserProfileEntity.city, userProfileEntity.city);
      expect(newUserProfileEntity.comarca, userProfileEntity.comarca);
      expect(newUserProfileEntity.province, userProfileEntity.province);
      expect(newUserProfileEntity.country, userProfileEntity.country);
      expect(newUserProfileEntity.comments, userProfileEntity.comments);
      expect(newUserProfileEntity.photo, userProfileEntity.photo);
      expect(newUserProfileEntity.height, userProfileEntity.height);
      expect(newUserProfileEntity.weight, userProfileEntity.weight);
      expect(newUserProfileEntity.shoulderHeight,
          userProfileEntity.shoulderHeight);
      expect(newUserProfileEntity.status, userProfileEntity.status);
      expect(newUserProfileEntity.language, userProfileEntity.language);
      expect(newUserProfileEntity.interactionType,
          userProfileEntity.interactionType);
      expect(newUserProfileEntity.createdAt, userProfileEntity.createdAt);
      expect(newUserProfileEntity.updatedAt, userProfileEntity.updatedAt);

      final newUserProfileEntity2 = userProfileEntity.copyWith(
        shoulderHeight: 100,
      );

      expect(newUserProfileEntity2.alias, userProfileEntity.alias);
      expect(newUserProfileEntity2.email, userProfileEntity.email);
      expect(newUserProfileEntity2.shoulderHeight, 100);
    });

    test('should convert from UserProfileModel to UserProfileEntity', () {
      final userProfileModel = UserProfileModel(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        nationality: 'Spanish',
        nationalIdNumber: 'X1234567Y',
        nationalIdType: 'DNI',
        name: 'John',
        lastName: 'Doe',
        family: 'Doe Family',
        familyHead: 'Jane Doe',
        alias: 'TestUser',
        gender: 1,
        birthdate: '1990-01-15T00:00:00.000Z',
        subscriptionDate: '2022-01-01T00:00:00.000Z',
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        mobilePhone: '987654321',
        emergencyPhone: '112233445',
        address: '123 Main Street',
        postalCode: '08001',
        city: 'Barcelona',
        comarca: 'Barcelonès',
        province: 'Barcelona',
        country: 'Spain',
        comments: 'No comments available.',
        photo: 'path/to/photo.jpg',
        height: 175,
        weight: 70,
        shoulderHeight: 140,
        status: 1,
        language: 'Catalan',
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      final userProfileEntity = UserProfileEntity.fromModel(userProfileModel);

      expect(userProfileEntity.idCasteller, 1);
      expect(userProfileEntity.idCastellerExternal, 1234);
      expect(userProfileEntity.collaId, 1);
      expect(userProfileEntity.numSoci, 'S001');
      expect(userProfileEntity.nationality, 'Spanish');
      expect(userProfileEntity.nationalIdNumber, 'X1234567Y');
      expect(userProfileEntity.nationalIdType, 'DNI');
      expect(userProfileEntity.name, 'John');
      expect(userProfileEntity.lastName, 'Doe');
      expect(userProfileEntity.family, 'Doe Family');
      expect(userProfileEntity.familyHead, 'Jane Doe');
      expect(userProfileEntity.alias, 'TestUser');
      expect(userProfileEntity.gender, 1);
      expect(userProfileEntity.birthdate, '1990-01-15T00:00:00.000Z');
      expect(userProfileEntity.subscriptionDate, '2022-01-01T00:00:00.000Z');
      expect(userProfileEntity.email, 'test@example.com');
      expect(userProfileEntity.email2, 'test2@example.com');
      expect(userProfileEntity.phone, '123456789');
      expect(userProfileEntity.mobilePhone, '987654321');
      expect(userProfileEntity.emergencyPhone, '112233445');
      expect(userProfileEntity.address, '123 Main Street');
      expect(userProfileEntity.postalCode, '08001');
      expect(userProfileEntity.city, 'Barcelona');
      expect(userProfileEntity.comarca, 'Barcelonès');
      expect(userProfileEntity.province, 'Barcelona');
      expect(userProfileEntity.country, 'Spain');
      expect(userProfileEntity.comments, 'No comments available.');
      expect(userProfileEntity.photo, 'path/to/photo.jpg');
      expect(userProfileEntity.height, 175);
      expect(userProfileEntity.weight, 70);
      expect(userProfileEntity.shoulderHeight, 140);
      expect(userProfileEntity.status, 1);
      expect(userProfileEntity.language, 'Catalan');
      expect(userProfileEntity.interactionType, 1);
      expect(userProfileEntity.createdAt, '2023-01-01T00:00:00.000Z');
      expect(userProfileEntity.updatedAt, '2023-01-01T00:00:00.000Z');
    });

    test('should convert from UserEntity to UserModel', () {
      final userProfileEntity = UserProfileEntity(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        nationality: 'Spanish',
        nationalIdNumber: 'X1234567Y',
        nationalIdType: 'DNI',
        name: 'John',
        lastName: 'Doe',
        family: 'Doe Family',
        familyHead: 'Jane Doe',
        alias: 'TestUser',
        gender: 1,
        birthdate: '1990-01-15T00:00:00.000Z',
        subscriptionDate: '2022-01-01T00:00:00.000Z',
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        mobilePhone: '987654321',
        emergencyPhone: '112233445',
        address: '123 Main Street',
        postalCode: '08001',
        city: 'Barcelona',
        comarca: 'Barcelonès',
        province: 'Barcelona',
        country: 'Spain',
        comments: 'No comments available.',
        photo: 'path/to/photo.jpg',
        height: 175,
        weight: 70,
        shoulderHeight: 140,
        status: 1,
        language: 'Catalan',
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      final userProfileModel = userProfileEntity.toModel();

      expect(userProfileModel.idCasteller, 1);
      expect(userProfileModel.idCastellerExternal, 1234);
      expect(userProfileModel.collaId, 1);
      expect(userProfileModel.numSoci, 'S001');
      expect(userProfileModel.nationality, 'Spanish');
      expect(userProfileModel.nationalIdNumber, 'X1234567Y');
      expect(userProfileModel.nationalIdType, 'DNI');
      expect(userProfileModel.name, 'John');
      expect(userProfileModel.lastName, 'Doe');
      expect(userProfileModel.family, 'Doe Family');
      expect(userProfileModel.familyHead, 'Jane Doe');
      expect(userProfileModel.alias, 'TestUser');
      expect(userProfileModel.gender, 1);
      expect(userProfileModel.birthdate, '1990-01-15T00:00:00.000Z');
      expect(userProfileModel.subscriptionDate, '2022-01-01T00:00:00.000Z');
      expect(userProfileModel.email, 'test@example.com');
      expect(userProfileModel.email2, 'test2@example.com');
      expect(userProfileModel.phone, '123456789');
      expect(userProfileModel.mobilePhone, '987654321');
      expect(userProfileModel.emergencyPhone, '112233445');
      expect(userProfileModel.address, '123 Main Street');
      expect(userProfileModel.postalCode, '08001');
      expect(userProfileModel.city, 'Barcelona');
      expect(userProfileModel.comarca, 'Barcelonès');
      expect(userProfileModel.province, 'Barcelona');
      expect(userProfileModel.country, 'Spain');
      expect(userProfileModel.comments, 'No comments available.');
      expect(userProfileModel.photo, 'path/to/photo.jpg');
      expect(userProfileModel.height, 175);
      expect(userProfileModel.weight, 70);
      expect(userProfileModel.shoulderHeight, 140);
      expect(userProfileModel.status, 1);
      expect(userProfileModel.language, 'Catalan');
      expect(userProfileModel.interactionType, 1);
      expect(userProfileModel.createdAt, '2023-01-01T00:00:00.000Z');
      expect(userProfileModel.updatedAt, '2023-01-01T00:00:00.000Z');
    });
  });

  group('UserProfileRepositoryImpl', () {
    late MockDio mockDio;
    late MockLogger mockLogger;
    late MockUserProfileService mockUserProfileService;
    late UserProfileRepositoryImpl userProfileRepository;

    setUp(() {
      registerFallbackValue(GetUserProfileParamsMock());
      // Unregister the existing Dio instance
      sl.unregister<Dio>();
      // Unregister the existing Logger instance
      sl.unregister<Logger>();
      // Unregister the existing UserProfileService instance
      sl.unregister<UserProfileService>();

      // Register the mock Dio instance
      mockDio = MockDio();
      sl.registerSingleton<Dio>(mockDio);
      // Register the mock Logger instance
      mockLogger = MockLogger();
      sl.registerSingleton<Logger>(mockLogger);
      // Register the mock UserProfileService instance
      mockUserProfileService = MockUserProfileService();
      sl.registerSingleton<UserProfileService>(mockUserProfileService);

      userProfileRepository = UserProfileRepositoryImpl();
    });

    tearDown(() {
      // Unregister the mock instances after the test
      sl.unregister<Dio>();
      sl.unregister<Logger>();
      sl.unregister<UserProfileService>();
      // Register real instances to continue the tests
      sl.registerSingleton<Dio>(_dio!);
      sl.registerSingleton<Logger>(_logger!);
      sl.registerSingleton<UserProfileService>(_userProfileService!);
      // Reset mocks
      reset(mockDio);
      reset(mockLogger);
      reset(mockUserProfileService);
    });

    test('should return a UserEntity when the service call is successful',
        () async {
      final userProfileEntity = UserProfileEntity(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        alias: 'TestUser',
        gender: 1,
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        height: 170,
        weight: 70,
        status: 1,
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      when(() => mockUserProfileService.getUserProfile(any()))
          .thenAnswer((_) async => Right(userProfileEntity));

      final result =
          await userProfileRepository.getUserProfile(GetUserProfileParams());

      expect(result.isRight(), isTrue);
      result.fold((l) => null, (r) {
        expect(r, equals(userProfileEntity));
      });

      verify(() => mockUserProfileService.getUserProfile(any())).called(1);
    });

    test('should return a Left when the service call fails', () async {
      when(() => mockUserProfileService.getUserProfile(any()))
          .thenAnswer((_) async => const Left('Error fetching user profile'));

      final result =
          await userProfileRepository.getUserProfile(GetUserProfileParams());

      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, equals('Error fetching user profile'));
      }, (r) => null);

      verify(() => mockUserProfileService.getUserProfile(any())).called(1);
    });
  });

  group('GetUserProfileCase', () {
    late GetUserProfile getUserProfile;
    late MockUserProfileRepository mockUserProfileRepository;

    late MockDio mockDio;
    late MockLogger mockLogger;

    setUp(() {
      registerFallbackValue(GetUserProfileParamsMock());
      // Unregister the existing Dio instance
      sl.unregister<Dio>();
      // Unregister the existing Logger instance
      sl.unregister<Logger>();
      // Unregister the existing UserProfileRepository instance
      sl.unregister<UserProfileRepository>();

      // Register the mock Dio instance
      mockDio = MockDio();
      sl.registerSingleton<Dio>(mockDio);

      // Register the mock Logger instance
      mockLogger = MockLogger();
      sl.registerSingleton<Logger>(mockLogger);

      // Register the mock Repository instance
      mockUserProfileRepository = MockUserProfileRepository();
      sl.registerSingleton<UserProfileRepository>(mockUserProfileRepository);

      // Initialize UserProfileServiceImpl with the mocked dependencies
      getUserProfile = GetUserProfile();
    });

    tearDown(() {
      // Unregister the mock instances after the test
      sl.unregister<Dio>();
      sl.unregister<Logger>();
      sl.unregister<UserProfileRepository>();

      // Register real instances to continue the tests
      sl.registerSingleton<Dio>(_dio!);
      sl.registerSingleton<Logger>(_logger!);
      sl.registerSingleton<UserProfileRepository>(_userProfileRepository!);
      // Reset mocks
      reset(mockDio);
      reset(mockLogger);
    });

    test('should get a UserEntity for valid params', () async {
      final userProfileEntity = UserProfileEntity(
        idCasteller: 1,
        idCastellerExternal: 1234,
        collaId: 1,
        numSoci: 'S001',
        alias: 'TestUser',
        gender: 1,
        email: 'test@example.com',
        email2: 'test2@example.com',
        phone: '123456789',
        height: 170,
        weight: 70,
        status: 1,
        interactionType: 1,
        createdAt: '2023-01-01T00:00:00.000Z',
        updatedAt: '2023-01-01T00:00:00.000Z',
      );

      when(() => mockUserProfileRepository.getUserProfile(any()))
          .thenAnswer((_) async => Right(userProfileEntity));

      final result = await getUserProfile(params: GetUserProfileParams());

      expect(result.isRight(), isTrue);
      result.fold((l) => null, (r) {
        expect(r, equals(userProfileEntity));
      });

      verify(() => mockUserProfileRepository.getUserProfile(any())).called(1);
    });

    test('should return a failure message for an invalid request', () async {
      when(() => mockUserProfileRepository.getUserProfile(any()))
          .thenAnswer((_) async => const Left('User not found'));

      final result = await getUserProfile(params: GetUserProfileParams());

      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, equals('User not found'));
      }, (r) => null);

      verify(() => mockUserProfileRepository.getUserProfile(any())).called(1);
    });
  });

  group('UserProfileServiceImpl', () {
    late UserProfileServiceImpl userProfileService;
    late MockDio mockDio;
    late MockLogger mockLogger;

    setUp(() {
      // Unregister the existing Dio instance
      sl.unregister<Dio>();
      // Unregister the existing Logger instance
      sl.unregister<Logger>();

      // Register the mock Dio instance
      mockDio = MockDio();
      sl.registerSingleton<Dio>(mockDio);

      // Register the mock Logger instance
      mockLogger = MockLogger();
      sl.registerSingleton<Logger>(mockLogger);

      // Initialize UserProfileServiceImpl with the mocked dependencies
      userProfileService = UserProfileServiceImpl();
    });

    tearDown(() {
      // Unregister the mock instances after the test
      sl.unregister<Dio>();
      sl.unregister<Logger>();
      // Register real instances to continue the tests
      sl.registerSingleton<Dio>(_dio!);
      sl.registerSingleton<Logger>(_logger!);
      // Reset mocks
      reset(mockDio);
      reset(mockLogger);
    });

    test('getUserProfile should return a UserProfileEntity on success',
        () async {
      final response = Response(
        data: {
          'castellerInfo': jsonEncode({
            'id_casteller': 1,
            'id_casteller_external': 1234,
            'colla_id': 1,
            'num_soci': 'S001',
            'alias': 'TestUser',
            'gender': 1,
            'email': 'test@example.com',
            'email2': 'test2@example.com',
            'phone': '123456789',
            'height': 170,
            'weight': 70,
            'status': 1,
            'interaction_type': 1,
            'created_at': '2023-01-01T00:00:00.000Z',
            'updated_at': '2023-01-01T00:00:00.000Z',
          })
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(() => mockDio.get(any())).thenAnswer((_) async => response);

      final result =
          await userProfileService.getUserProfile(GetUserProfileParamsMock());

      expect(result.isRight(), isTrue);
      result.fold((l) => null, (r) {
        expect(r.idCasteller, 1);
        expect(r.alias, 'TestUser');
        expect(r.email, 'test@example.com');
      });
    });

    test('getUserProfile should return a Left on unexpected response format',
        () async {
      final response = Response(
        data: 'Unexpected data',
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(() => mockDio.get(any())).thenAnswer((_) async => response);

      final result =
          await userProfileService.getUserProfile(GetUserProfileParamsMock());

      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, 'Unexpected response format');
      }, (r) => null);
    });

    test('getUserProfile should return a Left on error', () async {
      when(() => mockDio.get(any()))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      final result =
          await userProfileService.getUserProfile(GetUserProfileParamsMock());

      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, contains('Error when calling'));
      }, (r) => null);
    });
  });
}
