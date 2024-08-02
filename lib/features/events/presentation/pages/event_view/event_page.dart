import 'package:customizable_counter/customizable_counter.dart';
import 'package:fempinya3_flutter_app/core/configs/assets/app_icons.dart';
import 'package:fempinya3_flutter_app/core/utils/datetime_utils.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/event_view/views/event_member_comments_screen.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/pages/event_view/views/event_schedule_screen.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/event_view/custom_modal_bottom_sheet.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/widgets/event_view/event_info_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventPage extends StatelessWidget {
  final EventEntity event;

  const EventPage({super.key, required this.event});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(event.title)),
        //drawer: const MenuWidget(),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
                child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Card(
                    // Define the shape of the card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // Define how the card's content should be clipped
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // Define the child widget of the card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Add padding around the row widget
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //TODO
                              /* // Add an image widget to display an image
                          Image.asset(
                            "foto",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),*/
                              SvgPicture.asset(
                                AppIcons.activityIcon,
                                width: 100, // Ajusta el ancho del ícono
                                height: 100, // Ajusta la altura del ícono
                              ),
                              // Add some spacing between the image and the text
                              Container(width: 20),
                              // Add an expanded widget to take up the remaining horizontal space
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.calendar_month_outlined,
                                            size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          DateTimeUtils
                                              .formatDateToHumanLanguage(
                                                  event.startDate,
                                                  Localizations.localeOf(
                                                          context)
                                                      .toString()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ],
                                    ),
                                    Container(height: 5),
                                    Row(
                                      children: [
                                        const Icon(Icons.watch_later, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          event.dateHour,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.place, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          event.address,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      event.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                EventInfoTile(
                    svgSrc: AppIcons.scheduleHours,
                    title: "Horaris", // todo zan traducciones
                    press: () {
                      customModalBottomSheet(context,
                          height: MediaQuery.of(context).size.height - 100,
                          child: EventScheduleScreen(event: event));
                    }),

                EventInfoTile(
                    svgSrc: AppIcons.scheduleHours,
                    title: "Afegir comentaris", // todo zan traducciones
                    isShowBottomTop: false,
                    press: () {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height - 100,
                        child: EventMemberCommentsScreen(event: event),
                      );
                    }),
                //SELECTOR DE ASISTENCIA (lleváselo todo TOOODO)

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Vindràs al event tap de suru?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context)
                            .size
                            .width, // Ajusta al ancho de la pantalla
                        child: const AssistanceSelector(),
                      ),
                    ],
                  ),
                ),

                // SELECTOR ASISTENTES
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Row(children: [
                      Text(
                        "Algun acompanyant?",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ]),
                    CustomizableCounter(
                        borderColor: Colors.white,
                        borderWidth: 0,
                        borderRadius: 100,
                        backgroundColor: Colors.lightBlueAccent,
                        buttonText: "Afegir acompanyats",
                        textColor: Colors.white,
                        textSize: 15,
                        count: 0,
                        step: 1,
                        minCount: 0,
                        incrementIcon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        decrementIcon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                        onCountChange: (count) {}),
                  ],
                )),

                //SELECTOR DE INFORMACIÓN ADICIONAL
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    Row(children: [
                      Text(
                        "Informació adicional",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ]),
                    SizedBox(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Ajusta al ancho de la pantalla
                      child: AdditionalInfoChips(),
                    )
                  ],
                )),
              ],
            ))));
  }
}

//TODO
enum Calendar { yes, no, unknown }

class AssistanceSelector extends StatefulWidget {
  const AssistanceSelector({super.key});

  @override
  State<AssistanceSelector> createState() => _AssistanceSelectorState();
}

class _AssistanceSelectorState extends State<AssistanceSelector> {
  Calendar? calendarView;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
          value: Calendar.yes,
          label: Text('Sí'),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.no,
          label: Text('No'),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.unknown,
          label: Text('No ho sé'),
        ),
      ],
      selected: calendarView != null ? <Calendar>{calendarView!} : {},
      emptySelectionAllowed: true, // Pass an empty set if null
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}

class AdditionalInfoChips extends StatelessWidget {
  AdditionalInfoChips({super.key});

  final Map<String, bool> eventTags = {
    'Vegano': true,
    'Arribarè tard': false,
    'Celiac': true,
    'Celiacw': true,
    'Celiac5': true,
    'Celia5c': true
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: <Widget>[
          for (var item in eventTags.entries)
            FilterChip(
              onSelected: (selection) {},
              selected: item.value,
              label: Text(item.key),
              selectedColor: Theme.of(context).colorScheme.primaryFixedDim,
              checkmarkColor: Theme.of(context).colorScheme.onPrimaryFixed,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(style: BorderStyle.none)),
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .primaryFixedDim
                  .withOpacity(0.3),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            )
        ],
      ),
    );
  }
}
