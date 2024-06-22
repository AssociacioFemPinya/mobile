import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Inici'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(homeRoute);
            },
          ),
          ListTile(
            title: Text('Events'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(eventsRoute);
            },
          ),
          ListTile(
            title: Text('Notificacions'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(notificationsRoute);
            },
          ),
        ],
      ),
    );
  }
}
