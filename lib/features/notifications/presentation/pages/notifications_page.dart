import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      drawer: MenuWidget(),
      body: Center(
        child: Text('This is the notifications page'),
      ),
    );
  }
}
