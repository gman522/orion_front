import 'package:go_router/go_router.dart';
import '../screens/subcategoria_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
        path: '/subcategoria/:categoria',
        builder: (context, state){
            final categoria = state.pathParameters['categoria']!;

            return SubcategoriaScreen(
                categoria: categoria,
            );
        },
    ),
  ],
);