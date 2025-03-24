import 'package:fempinya3_flutter_app/features/notifications/data/models/notification_model.dart';

final List<NotificationModel> notificationsMock = [
  NotificationModel(
    id: '1',
    title: 'Nou esdeveniment: Actuació a Plaça Catalunya',
    body: "S'ha programat una nova actuació per dissabte que ve. No oblidis confirmar la teva assistència!",
    date: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  NotificationModel(
    id: '2',
    title: 'Recordatori: Assaig General',
    body: "Demà tenim assaig general a les 19:00h. És important l'assistència de tothom.",
    date: DateTime.now().subtract(const Duration(hours: 2)),
    isRead: true,
  ),
  NotificationModel(
    id: '3',
    title: "Canvi d'horari",
    body: "L'assaig de dijous s'ha mogut a les 20:00h per problemes de disponibilitat.",
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  NotificationModel(
    id: '4',
    title: 'Nova informació disponible',
    body: "S'ha actualitzat la informació de l'esdeveniment del cap de setmana. Revisa els detalls.",
    date: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
  ),
]; 