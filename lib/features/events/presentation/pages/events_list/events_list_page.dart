import 'package:fempinya3_flutter_app/features/events/domain/enums/events_status.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_calendar/events_calendar_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_list/events_list_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_view_mode/events_view_mode_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list/events_calendar.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list/events_filters_button.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list/events_filters_input_chips.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list/events_list.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list/events_status_filters.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list/events_with_alert_banner.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_filters/events_filters_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsListPage extends StatelessWidget {
  const EventsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;

    EventsFiltersBloc eventsFiltersBloc = EventsFiltersBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsFiltersBloc>(
          create: (context) => eventsFiltersBloc,
        ),
        BlocProvider<EventsViewModeBloc>(
          create: (context) => EventsViewModeBloc(),
        ),
        BlocProvider<EventsListBloc>(
          create: (context) =>
              EventsListBloc()..add(LoadEventsList(eventsFiltersBloc.state)),
        ),
        BlocProvider<EventsCalendarBloc>(
          create: (context) => EventsCalendarBloc(),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text(translate.eventsPageTitle),
          ),
          drawer: const MenuWidget(),
          body: MultiBlocListener(
            listeners: [
              BlocListener<EventsFiltersBloc, EventsFiltersState>(
                // Whenever the filters are changed, we need to refresh the events list
                listener: (context, state) {
                  context.read<EventsListBloc>().add(LoadEventsList(state));
                },
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  EventsWithAlertBannerWidget(),
                  EventsViewModeWidget(),
                  SizedBox(
                    height: 5,
                  ),
                  EventsStatusFiltersWidget(),
                  Row(children: [
                    EventsFiltersButton(),
                    EventsFiltersInputChipsWidget()
                  ]),
                  Divider(),
                  EventsCalendar(),
                  // StatusCard(), //zan new event extract
                  //  StatusCard(),
                  //   StatusCard(),
                  Visibility(
                    child: Expanded(child: EventsListWidget())),
                ],
              ),
            ),
          )),
    );
  }
}

class StatusCard extends StatefulWidget {
  const StatusCard({super.key});

  @override
  _StatusCardState createState() => _StatusCardState();
}


class _StatusCardState extends State<StatusCard> {
  int selectedButton = -1; // Estado inicial sin selección

  final List<Color> statusColors = [
    Colors.white, // Estado neutro
    Colors.redAccent.withValues(alpha:0.4), // Rechazado
    Colors.orangeAccent.withValues(alpha:0.4), // Pendiente
    const Color.fromARGB(255, 1, 164, 85).withValues(alpha:0.4), // Aprobado
  ];

  final List<IconData> statusIcons = [
    Icons.circle_outlined, // Neutro
    Icons.cancel, // Rechazado
    Icons.error_outline, // Pendiente
    Icons.check, // Aprobado
  ];

  void toggleStatus(int index) {
    setState(() {
      selectedButton = (selectedButton == index) ? -1 : index; // Permite desactivar
    });
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = statusColors[selectedButton == -1 ? 0 : selectedButton];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            color: Colors.blueAccent, // Barra superior
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: double.infinity,
            color: cardColor,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: 
            
            ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
         /* leading: CircleAvatar(
            backgroundColor: cardColor,
            child: Icon(_getStatusIcon(EventStatusEnum.accepted),
                color: _getStatusColor(EventStatusEnum.accepted), 
                size: 35), 
          ),*/
          title: Text("Tabalers", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("La Fontana"),
          /*trailing:
              Icon(_getStatusIcon(EventStatusEnum.accepted),
                color: _getStatusColor(EventStatusEnum.accepted), 
                size: 35),*/
        )
            
            
            
        
          ),
          Divider(height: 1),
          Row(
            children: List.generate(3, (index) {
              bool isActive = selectedButton == index + 1;
              return Expanded(
                child: GestureDetector(
                  onTap: () => toggleStatus(index + 1),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: isActive ? cardColor : Colors.grey[200],
                    child: Icon(
                      statusIcons[index + 1],
                      color: isActive
                          ? (cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white)
                          : Colors.grey[700],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

  IconData _getStatusIcon(EventStatusEnum status) =>
      const {
        EventStatusEnum.accepted: Icons.check,
        EventStatusEnum.declined: Icons.close,
        EventStatusEnum.unknown: Icons.help_outline,
        EventStatusEnum.undefined: Icons.remove,
        EventStatusEnum.warning: Icons.warning,
      }[status] ??
      Icons.help_outline;

  Color _getStatusColor(EventStatusEnum status) =>
      const {
        EventStatusEnum.accepted: Colors.green,
        EventStatusEnum.declined: Colors.red,
        EventStatusEnum.unknown: Colors.orange,
        EventStatusEnum.undefined: Colors.grey,
        EventStatusEnum.warning: Colors.orange,
      }[status] ??
      Colors.grey;