import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => MapaState();
}

class MapaState extends State<Mapa> {
  // Colores para la interfaz
  Color selectedColor = const Color(0xFF417123);
  Color defaultColor = Colors.white;

  // Índice seleccionado para los iconos de la barra inferior
  int selectedIndex = 2;

  // Controlador para el mapa de Google
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // Posiciones predefinidas del mapa
  static const CameraPosition _zamoraPosition = CameraPosition(
    target: LatLng(-4.0692, -78.9567),
    zoom: 16.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-3.529406768532852, -78.95063772684468),
      tilt: 59.440717697143555,
      zoom: 15.451926040649414);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    Color customColor = const Color(0xFF5BDA57);

    double radius = 45.5;

    return Scaffold(
      // Barra de aplicación
      appBar: AppBar(
        backgroundColor: customColor,
        elevation: 0,
        leading: GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.028),
            child: Image.asset(
              'assets/logo.png',
              width: screenWidth * 0.093,
              height: screenHeight * 0.093,
            ),
          ),
        ),
        title: Text(
          'MI UBICACION',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu,
                color: Colors.white, size: screenHeight * 0.04),
            onPressed: () {
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
        ],
        toolbarHeight: screenHeight * 0.1,
      ),
      // Cuerpo de la pantalla
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _zamoraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: screenHeight * 0.015), // Ajusta según tu necesidad
        padding: EdgeInsets.only(
            left: screenWidth * 0.07, right: screenWidth * 0.07),
        child: Container(
          height: screenHeight * 0.09,
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildIconButton(Icons.image, 0),
              buildIconButton(Icons.restaurant, 1),
              buildIconButton(Icons.location_on_outlined, 2),
              buildIconButton(Icons.qr_code, 3),
            ],
          ),
        ),
      ),
      // Botón flotante de acción
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text(
          'Recomendado',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.016,
          ),
        ),
        icon: Icon(Icons.location_on_outlined,
            color: Colors.white, size: screenHeight * 0.026),
        backgroundColor: customColor,
      ),
      // Posición del botón flotante
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  // Método para construir un icono de la barra inferior
  IconButton buildIconButton(IconData icon, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double iconsize = screenHeight * 0.032;
    return IconButton(
      icon: Icon(
        icon,
        color: selectedIndex == index ? selectedColor : defaultColor,
        size: iconsize,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });

        // Navegación a las diferentes pantallas según el ícono seleccionado
        if (index == 1) {
          Navigator.pushNamed(context, '/gastronomia');
        }
        if (index == 0) {
          Navigator.pushNamed(context, '/actividades');
        }
        if (index == 3) {
          Navigator.pushNamed(context, '/qrscan');
        }
      },
    );
  }

  // Método para ir a la posición predefinida en el mapa
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
