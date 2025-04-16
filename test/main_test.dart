import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:fempinya3_flutter_app/main.dart';
import 'package:fempinya3_flutter_app/features/login/login.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockGoRouter extends Mock implements GoRouter {}

class MockNotificationSettings extends Mock implements NotificationSettings {
  final AuthorizationStatus authorizationStatus;

  MockNotificationSettings({required this.authorizationStatus});
}

void main() {
  test('whenRequestNotificationPermissions_thenFirebaseRequestPermissionCalled',
      () async {
    // Arrange
    // Set up the mock for FirebaseMessaging
    final mockFirebaseMessaging = MockFirebaseMessaging();
    when(() => mockFirebaseMessaging.requestPermission(
            alert: any(named: 'alert'),
            announcement: any(named: 'announcement'),
            badge: any(named: 'badge'),
            carPlay: any(named: 'carPlay'),
            criticalAlert: any(named: 'criticalAlert'),
            provisional: any(named: 'provisional'),
            sound: any(named: 'sound'),
            providesAppNotificationSettings:
                any(named: 'providesAppNotificationSettings')))
        .thenAnswer((_) async {
      return MockNotificationSettings(
          authorizationStatus: AuthorizationStatus.authorized);
    });

    // Act
    // Call main function
    await requestNotificationPermissions(mockFirebaseMessaging);

    // Assert
    // Verify main function called requestPermission
    verify(mockFirebaseMessaging.requestPermission).called(1);
  });

  test('whenEasyLoadingConfigured_thenEasyLoadingConfiguredAsExpected', () {
    // Arrange
    // Configure easy loading
    configLoading();

    // Act
    // Instance easyLoading singleton
    final easyLoading = EasyLoading.instance;

    // Assert
    // Verify easyLoading is set up as expected
    expect(easyLoading.loadingStyle, EasyLoadingStyle.custom);
    expect(easyLoading.indicatorType, EasyLoadingIndicatorType.threeBounce);
    expect(easyLoading.indicatorColor, Colors.indigo);
    expect(easyLoading.backgroundColor, Colors.transparent);
    expect(easyLoading.textColor, Colors.transparent);
    expect(easyLoading.maskType, EasyLoadingMaskType.none);
    expect(easyLoading.maskColor, Colors.transparent);
    expect(easyLoading.indicatorSize, 30.0);
    expect(easyLoading.radius, 10.0);
    expect(easyLoading.userInteractions, false);
    expect(easyLoading.boxShadow, <BoxShadow>[]);
    expect(easyLoading.dismissOnTap, false);
  });

  testWidgets(
      'whenAppBuilt_thenInitAuthenticationRepositoryInitializesRepositoryAndBlocAndRouter',
      (WidgetTester tester) async {
    // Arrange
    // Set up the mock for SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // Act
    // Build the App widget to access its state
    await tester.pumpWidget(const App());
    // Access the state of the App widget
    final appState = tester.state<State<App>>(find.byType(App));
    // Call the method to be tested
    final result = await (appState as dynamic).initAuthenticationRepository();

    // Assert
    expect(result.authenticationRepository, isA<AuthenticationRepository>());
    expect(result.authenticationBloc, isA<AuthenticationBloc>());
    expect(GetIt.instance.isRegistered<GoRouter>(), isTrue);
  });
}
