import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'pages/screens.dart';

/// Este es el punto de entrada principal para la aplicación Flutter.
/// Configura el widget [MyApp] como la raíz del árbol de widgets.
/// El widget [MyApp] es responsable de configurar el tema y definir las rutas para la aplicación.
/// Utiliza el paquete [Get] para la gestión de rutas.
/// La página [SplashPage] se establece como la página inicial de la aplicación.
/// Los objetos [GetPage] definen las rutas y las páginas correspondientes para la aplicación.
/// Cada página está asociada con un nombre único y un widget que representa la página.
/// La propiedad [Transition] especifica la animación de transición al navegar entre páginas.
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue[900]),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      home: const SplashPage(),
      getPages: [
        GetPage(
          name: '/home',
          page: () => const InicioPage(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/registropage',
          page: () => const RegistroPage(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/loginpage',
          page: () => const LoginPage(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/logingoogle',
          page: () => const LoginGoogle(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/loginfacebook',
          page: () => const LoginFacebook(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/actividades',
          page: () => const Actividades(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/configuracion',
          page: () => const Configuracion(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/reservaciones',
          page: () => const Reservaciones(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/actividades2',
          page: () => const Actividades2(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/actividadesComentario',
          page: () => const ActividadesComentario(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/actividades3',
          page: () => const Actividades3(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/gastronomia',
          page: () => const Gastronomia(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/gastronomia2',
          page: () => const Gastronomia2(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/reserva2',
          page: () => const Reserva2(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/reserva3',
          page: () => const Reserva3(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/reserva',
          page: () => const Reserva(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/mapa',
          page: () => const Mapa(),
          transition: Transition.native,
        ),
        GetPage(
          name: '/qrscan',
          page: () => const QrScan(),
          transition: Transition.native,
        ),
      ],
    );
  }
}
