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
    var translate = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsFiltersBloc>(
          create: (context) => EventsFiltersBloc(),
        ),
        BlocProvider<EventsViewModeBloc>(
          create: (context) => EventsViewModeBloc(),
        ),
        BlocProvider<EventsListBloc>(
          create: (context) => EventsListBloc()..add(LoadEventsList()),
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
        body: const Padding(
          padding:  EdgeInsets.all(8.0),
          child:  Column(
            children: [
               EventsWithAlertBannerWidget(),
               EventsViewModeWidget(),
                SizedBox(height: 5,),
               EventsStatusFiltersWidget(),
               Row(children: [
                EventsFiltersButton(),
                EventsFiltersInputChipsWidget()
              ]),
               Divider(),
               EventsCalendar(),
               Expanded(child: EventsListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}


