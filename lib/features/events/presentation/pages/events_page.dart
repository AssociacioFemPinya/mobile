import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_calendar/events_calendar_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_repository/events_repository_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_view_mode/events_view_mode_bloc.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_calendar.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_filters_button.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_filters_input_chips.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_list.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_status_filters.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/events_view_mode.dart';
import 'package:fempinya3_flutter_app/features/menu/presentation/widgets/menu_widget.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_filters/events_filters_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

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
        BlocProvider<EventsRepositoryBloc>(
          create: (context) => EventsRepositoryBloc()..add(LoadEventsList()),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              eventsWithAlertBanner(translate, context),
              const EventsViewModeWidget(),
              const Row(children: [
                EventsFiltersButton(),
                EventsFiltersInputChipsWidget()
              ]),
              const Divider(),
              const EventsStatusFiltersWidget(),
              const Divider(),
              const EventsCalendar(),
              const Expanded(child: EventsListWidget()),
            ],
          ),
        ),
      ),
    );
  }

Container eventsWithAlertBanner(
    AppLocalizations translate, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromRGBO(247, 112, 82, 1), // Color de fondo
      borderRadius: BorderRadius.circular(5.0), // Ajusta el radio aquí
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 4.0,
          offset: Offset(0, 2), // Sombra debajo
        ),
      ],
    ),
    margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 8.0), // Espacio entre el ícono y el texto
          Expanded(
            child: Text(
              translate.eventsPageEventsWithAlertBanner,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white, // Color del texto
              ),
              textAlign: TextAlign.left, // Alinea el texto a la izquierda
            ),
          ),
          // Alineación a la derecha
          InkWell(
            onTap: () {
              _onFilterClicked(context);
            },
            child: const Text(
              'Filtrar',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white, // Color del texto
                decoration: TextDecoration.underline, // Estilo de hipervínculo
              ),
              textAlign: TextAlign.right, // Alinea el texto a la derecha
            ),
          ),
        ],
      ),
    ),
  );
}

// Método para manejar el clic en el hipervínculo
void _onFilterClicked(BuildContext context) {
  // Implementa aquí la lógica para manejar el clic
  // Por ejemplo, puedes mostrar un diálogo, navegar a otra pantalla, etc.
  print("Filtrar clickeado");
}

}
