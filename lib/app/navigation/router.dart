import 'package:go_router/go_router.dart';
import 'package:tcp_penguin/app/navigation/transition_page.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen.dart';
import 'package:tcp_penguin/presentation/screen/saved_scans/saved_scans_screen.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: "/saved_scans",
      pageBuilder: (context, state) =>
          TransitionPage(key: state.pageKey, child: SavedScansScreen()),
    ),
  ],
);
