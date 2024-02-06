import 'package:flutter/material.dart';

class Reserva3 extends StatelessWidget {
  const Reserva3({super.key});

  // Método de construcción del widget
  @override
  Widget build(BuildContext context) {
    // Obtener dimensiones de la pantalla
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Definir colores y estilos personalizados
    Color customColor = const Color(0xFF5BDA57);
    Color colorBoton1 = const Color(0xFF417123);
    Color customColor3 = const Color(0xFFF2F5F0);
    double radius = 45.5;
    double iconsize = screenHeight * 0.032;

    // Estructura del widget: Scaffold con AppBar, cuerpo, y barra de navegación inferior
    return Scaffold(
      appBar: AppBar(
        // AppBar personalizada con título y acciones
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
          'GASTRONOMIA',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: screenHeight * 0.04,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
        ],
        toolbarHeight: screenHeight * 0.1,
      ),
      body: Stack(
        children: [
          // Posicionamiento de elementos en la pantalla usando el widget Stack
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.02,
            child: Center(
              child: Text(
                'TU RESERVACION',
                style: TextStyle(
                  color: colorBoton1,
                  fontSize: screenHeight * 0.029,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.09,
            child: Center(
              child: Container(
                // Contenedor central de la pantalla con detalles de la reserva
                width: screenWidth * 15,
                height: screenHeight * 0.63,
                decoration: BoxDecoration(
                  color: customColor3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 1),
                    Center(
                      child: Text(
                        'ID: 716001',
                        style: TextStyle(
                          color: colorBoton1,
                          fontSize: screenHeight * 0.029,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: customColor,
                        radius: 30.0,
                        child: Icon(
                          Icons.check,
                          size: screenHeight * 0.063,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '¡Su reservacion esta confirmada!',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: customColor,
                          fontSize: screenHeight * 0.022,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        'Su depósito para la Reserva 716001\n es de 200.000 VND. Si no realiza el\n depósito en 30 minutos, su reserva\n se cancelará automáticamente.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorBoton1,
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: Text(
                        '¿Quieres pagar ahora?',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: colorBoton1,
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: colorBoton1,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: colorBoton1),
                            ),
                            minimumSize: const Size(20, 45),
                          ),
                          child: Text(
                            'AHORA NO',
                            style: TextStyle(
                              color: colorBoton1,
                              fontSize: screenHeight * 0.02,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: const Size(20, 45),
                          ),
                          child: Text(
                            'PAGAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.02,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        'Nota: Si el cliente cancela la reserva por motivos subjetivos, el restaurante no se hará responsable de la devolución del depósito.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: colorBoton1,
                          fontSize: screenHeight * 0.018,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Barra de navegación inferior con íconos y rutas
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: screenHeight * 0.015), // Ajustar según necesidad
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
              // Íconos de la barra inferior con rutas correspondientes
              IconButton(
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/actividades');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.restaurant,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/gastronomia');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/mapa');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: iconsize,
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
