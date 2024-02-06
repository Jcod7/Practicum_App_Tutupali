import 'package:flutter/material.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definición de colores y dimensiones
    Color customTextColor = const Color(0xFF417123);
    Color customColor = const Color(0xFF5BDA57);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double radius = screenHeight * 0.057; // Radio del contorno inferior
    double iconSize = screenHeight * 0.032; // Tamaño de los iconos inferiores

    double borderRadius = screenHeight * 0.037; // Radio de los botones
    double width = screenWidth * 0.68; // Ancho de los botones
    double height = screenHeight * 0.062; // Alto de los botones
    double separador = screenHeight * 0.013; // Espacio entre los botones

    return Scaffold(
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
          'CONFIGURACION',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: screenHeight * 0.046,
          ),
        ],
        toolbarHeight: screenHeight * 0.1,
      ),
      body: Stack(
        children: [
          // Contenido de la pantalla
          Center(
            child: Column(children: [
              SizedBox(height: screenHeight * 0.01),
              // Icono de perfil
              Icon(
                Icons.person,
                size: screenHeight * 0.22,
                color: customTextColor,
              ),
              SizedBox(height: screenHeight * 0.01),
              // Botones de configuración
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: Size(width, height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Text(
                  'Detalles de Cuenta',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: separador),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: Size(width, height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Text(
                  'Idioma de la Aplicacion',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: separador),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: Size(width, height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: separador),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reservaciones');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: Size(width, height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Text(
                  'Reservaciones',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: separador),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: Size(width, height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Text(
                  'Ayuda',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: separador),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColor,
                  minimumSize: Size(width, height),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: screenHeight * 0.015), // Ajusta según tu necesidad
        padding: EdgeInsets.only(
            left: screenWidth * 0.07, right: screenWidth * 0.07),
        child: Container(
          height: screenHeight * 0.09,
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Iconos de la barra de navegación
              IconButton(
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                  size: iconSize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/actividades');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.restaurant,
                  color: Colors.white,
                  size: iconSize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/gastronomia');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: iconSize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/mapa');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: iconSize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/qrscan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
