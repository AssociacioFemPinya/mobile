import 'dart:js_interop';

import 'package:fempinya3_flutter_app/features/notifications/domain/entities/notification.dart';
import 'package:fempinya3_flutter_app/features/notifications/domain/useCases/get_notification.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'notification_view_events.dart';
part 'notification_view_state.dart';

class NotificationViewBloc extends Bloc<NotificationViewEvents, NotificationViewState>{
  final getNotification = GetIt.instance<GetNotification>();

  NotificationViewBloc(): super(NotificationViewInitial(notification: null)){
    on<LoadNotification>(_onLoadNotification);
  }

  Future<void> _onLoadNotification(
    LoadNotification notificationID,
    Emitter<NotificationViewState> emit
  ) async {

    try{
    final result = await getNotification(params: GetNotificationParams(id: notificationID.value));

      result.fold((failure) {
        add(NotificationLoadFailure(failure));
      }, (data) {
        add(NotificationLoadSuccess(data));
      });

    } catch (e){
    }

  }
  
}