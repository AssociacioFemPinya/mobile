import 'package:fempinya3_flutter_app/core/configs/assets/app_icons.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/eventView/views/event_schedule_screen.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/custom_modal_bottom_sheet.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/event_info_tile.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            EventInfoTile(
                svgSrc: AppIcons.scheduleHours,
                title: "Horaris", // todo zan traducciones
                press: () {
                  customModalBottomSheet(context,
                      height: MediaQuery.of(context).size.height * 92,
                      child: EventScheduleScreen(event: event));
                })
          ],
        )));
  }
}
