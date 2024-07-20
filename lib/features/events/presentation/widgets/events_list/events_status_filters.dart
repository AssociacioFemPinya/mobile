import 'package:fempinya3_flutter_app/features/events/presentation/bloc/events_list/events_filters/events_filters_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsStatusFiltersWidget extends StatelessWidget {
  const EventsStatusFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var translate = AppLocalizations.of(context)!;

    return BlocBuilder<EventsFiltersBloc, EventsFiltersState>(
      builder: (context, state) {
        return Container(
          width: double.infinity, // Hace que el contenedor ocupe todo el ancho
          child: Row(
            children: [
              Expanded(
                child: buildEventStatusFilterButton(
                  state.showUndefined,
                  translate.eventPageStatusFilterPending,
                  context,
                  (value) {
                    context
                        .read<EventsFiltersBloc>()
                        .add(EventsStatusFilterUndefined(value));
                  },
                ),
              ),
              Expanded(
                child: buildEventStatusFilterButton(
                  state.showAnswered,
                  translate.eventPageStatusFilterAnswered,
                  context,
                  (value) {
                    context
                        .read<EventsFiltersBloc>()
                        .add(EventsStatusFilterAnswered(value));
                  },
                ),
              ),
              Expanded(
                child: buildEventStatusFilterButton(
                  state.showWarning,
                  translate.eventPageStatusFilterWarning,
                  context,
                  (value) {
                    context
                        .read<EventsFiltersBloc>()
                        .add(EventsStatusFilterWarning(value));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildEventStatusFilterButton(
      bool selected, String label, BuildContext context, ValueChanged<bool> onSelected) {
    return Container(
      margin: EdgeInsets.zero, // Elimina márgenes
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: selected
              ? Theme.of(context).colorScheme.primaryFixedDim
              : Theme.of(context).colorScheme.primaryFixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide.none, // Elimina el borde
          ),
          padding: EdgeInsets.zero, // Elimina el padding interno
          minimumSize: Size(double.infinity, 48), // Ajusta el tamaño mínimo
        ),
        onPressed: () => onSelected(!selected),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido
          children: [
            if (selected) ...[
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
              SizedBox(width: 8), // Espacio entre el icono y el texto
            ],
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.black, // Texto negro cuando no está seleccionado
              ),
            ),
          ],
        ),
      ),
    );
  }
}
