import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Agrega cualquier lógica que necesites al cargar la pantalla de Splash
    // Por ejemplo, aquí puedes cargar datos, realizar autenticación, etc.

    // Espera unos segundos y luego navega a la pantalla principal
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo de la imagen
          Image.asset(
            'assets/splash.jpg', // Reemplaza con la ruta de tu imagen
            fit: BoxFit.cover,
          ),
          // Contenido del centro
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stack para posicionar elementos en capas
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Imagen pequeña
                    Image.asset(
                      'assets/logo.png', // Ruta de la imagen pequeña
                      width: 150, // Ancho de la imagen pequeña
                      height: 150, // Alto de la imagen pequeña
                      fit: BoxFit.cover,
                    ),
                    // GIF detrás de la imagen pequeña
                    Positioned(
                      child: Image.asset(
                        'assets/spinner.gif', // Ruta del GIF
                        width: 205, // Ancho del GIF
                        height: 205, // Alto del GIF
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
