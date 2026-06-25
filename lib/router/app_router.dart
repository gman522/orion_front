import 'package:go_router/go_router.dart';
import '../screens/alerta_success_screen.dart';
import '../screens/subcategoria_screen.dart';
import '../screens/seguimiento_screen.dart';
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
      builder: (context, state) => HomeScreen(),
    ),

    GoRoute(
        path: '/subcategoria/:id',
        builder: (context, state){
            final id = int.parse(state.pathParameters['id']!);

            return SubcategoriaScreen(
                categoriaId: id,
            );
        },
    ),

    GoRoute(
      path: '/alerta-success',
      builder: (context, state){
        final data = state.extra as Map<String, dynamic>;

        return AlertaSuccessScreen(
          categoria: data["categoria"],
          subcategoria: data["subcategoria"],
          ubicacion: data["ubicacion"],
          fecha: data["fecha"],
          hora: data["hora"],
        );
      },
    ),

    GoRoute(
      path: '/seguimiento',
      builder: (context, state) =>const SeguimientoScreen(),
    ),
  ],
);