import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';

import 'package:flutter/material.dart';


class EventPage extends StatelessWidget {
  final EventEntity event;

  const EventPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(event.title),
        ),
        drawer: const MenuWidget(),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [],
          ),
        ),
    );
  }
}
