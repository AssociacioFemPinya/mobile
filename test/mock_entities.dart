import 'package:fempinya3_flutter_app/features/login/login.dart';
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart';
import 'package:fempinya3_flutter_app/features/login/presentation/bloc/authentication_bloc.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:webview_flutter/webview_flutter.dart' hide ProgressCallback;
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart'
    hide ProgressCallback;

class MockRondesListBloc extends RondesListBloc {
  RondesListState state = RondesListInitial();

  void emit(RondesListState newState) {
    state = newState;
  }
}

class MockRondaViewBloc extends RondaViewBloc {
  RondaViewState state = RondaViewInitial();

  void emit(RondaViewState newState) {
    state = newState;
  }
}

class MockPublicDisplayUrlViewBloc extends PublicDisplayUrlViewBloc {
  PublicDisplayUrlViewState state = PublicDisplayUrlViewInitial();

  void emit(PublicDisplayUrlViewState newState) {
    state = newState;
  }

  MockPublicDisplayUrlViewBloc() : super();
}

class MockAuthenticationBloc extends AuthenticationBloc {
  final UserEntity _userEntity = UserEntity(
    castellerActiveId: 1,
    castellerActiveAlias: "Josep Maria",
    linkedCastellers: [
      LinkedCastellerEntity(
        idCastellerApiUser: 1,
        apiUserId: 1,
        castellerId: 1,
      ),
    ],
    boardsEnabled: true,
  );

  MockAuthenticationBloc({required super.authenticationRepository});

  @override
  AuthenticationState get state =>
      AuthenticationState.authenticated(_userEntity);

  UserEntity get userEntity => _userEntity;
}

class MockUnauthenticatedBloc extends AuthenticationBloc {
  MockUnauthenticatedBloc({required super.authenticationRepository});

  @override
  AuthenticationState get state => AuthenticationState.unauthenticated();
}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class FakeWebViewPlatform extends WebViewPlatform {
  @override
  PlatformWebViewController createPlatformWebViewController(
    PlatformWebViewControllerCreationParams params,
  ) {
    return FakeWebViewController(params);
  }

  @override
  PlatformWebViewWidget createPlatformWebViewWidget(
    PlatformWebViewWidgetCreationParams params,
  ) {
    return FakeWebViewWidget(params);
  }

  @override
  PlatformWebViewCookieManager createPlatformCookieManager(
    PlatformWebViewCookieManagerCreationParams params,
  ) {
    return FakeCookieManager(params);
  }

  @override
  PlatformNavigationDelegate createPlatformNavigationDelegate(
    PlatformNavigationDelegateCreationParams params,
  ) {
    return FakeNavigationDelegate(params);
  }
}

class FakeWebViewController extends PlatformWebViewController {
  FakeWebViewController(super.params) : super.implementation();

  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) async {}

  @override
  Future<void> setBackgroundColor(Color color) async {}

  @override
  Future<void> setPlatformNavigationDelegate(
    PlatformNavigationDelegate handler,
  ) async {}

  @override
  Future<void> addJavaScriptChannel(
      JavaScriptChannelParams javaScriptChannelParams) async {}

  @override
  Future<void> loadRequest(LoadRequestParams params) async {}

  @override
  Future<String?> currentUrl() async {
    return 'https://www.google.com';
  }
}

class FakeCookieManager extends PlatformWebViewCookieManager {
  FakeCookieManager(super.params) : super.implementation();
}

class FakeWebViewWidget extends PlatformWebViewWidget {
  FakeWebViewWidget(super.params) : super.implementation();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FakeNavigationDelegate extends PlatformNavigationDelegate {
  FakeNavigationDelegate(super.params) : super.implementation();

  @override
  Future<void> setOnNavigationRequest(
    NavigationRequestCallback onNavigationRequest,
  ) async {}

  @override
  Future<void> setOnPageFinished(PageEventCallback onPageFinished) async {}

  @override
  Future<void> setOnPageStarted(PageEventCallback onPageStarted) async {}

  @override
  Future<void> setOnProgress(void Function(int) onProgress) async {}

  @override
  Future<void> setOnWebResourceError(
    WebResourceErrorCallback onWebResourceError,
  ) async {}
}
