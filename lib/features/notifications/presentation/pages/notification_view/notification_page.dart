import 'package:fempinya3_flutter_app/features/notifications/presentation/bloc/notification_view/notification_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NotificationPage extends StatelessWidget{
  final int notificationID;

  const NotificationPage({super.key, required this.notificationID});

 @override   
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<NotificationViewBloc>(
        create: (context) => NotificationViewBloc()..add(LoadNotification(notificationID)),
      ),
    ], child: notificationView(context));
  }


  BlocBuilder notificationView(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    return BlocBuilder<NotificationViewBloc, NotificationViewState>(
        builder: (context, state) {
      if (state is NotificationViewInitial) {
        return Container();
      }
      return Scaffold(
          appBar: AppBar(title: Text(state.notification!.title)),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                  child: CustomScrollView(
                slivers: [
    
                ],
              ))));
    });
  }
}