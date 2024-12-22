import 'package:fempinya3_flutter_app/core/navigation/route_names.dart';
import 'package:go_router/go_router.dart';

import 'presentation.dart';

final List<GoRoute> rondesRoutes = [
  GoRoute(
    name: rondesRoute,
    path: rondesRoute,
    builder: (context, state) => const RondesListPage(),
  ),
  GoRoute(
    name: rondaRoute,
    path: '$rondaRoute/:rondaID',
    builder: (context, state) {
      final rondaID = int.parse(state.pathParameters['rondaID']!);
      return RondaPage(rondaID: rondaID);
    },
  ),
];
