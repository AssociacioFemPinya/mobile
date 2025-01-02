import 'package:fempinya3_flutter_app/features/notifications/data/models/notification_model.dart';

final List<NotificationModel> notificationsMock = [
  NotificationModel(
    id: '1',
    title: 'Nuevo evento: Actuación en Plaza Catalunya',
    message: 'Se ha programado una nueva actuación para el próximo sábado. ¡No olvides confirmar tu asistencia!',
    createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  NotificationModel(
    id: '2',
    title: 'Recordatorio: Ensayo General',
    message: 'Mañana tenemos ensayo general a las 19:00h. Es importante la asistencia de todos.',
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    isRead: true,
  ),
  NotificationModel(
    id: '3',
    title: 'Cambio de horario',
    message: 'El ensayo del jueves se ha movido a las 20:00h debido a problemas de disponibilidad.',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  NotificationModel(
    id: '4',
    title: 'Nueva información disponible',
    message: 'Se ha actualizado la información del evento del fin de semana. Revisa los detalles.',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
  ),
]; 