import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definición de colores
    Color customColor = const Color(0xFF5BDA57);
    Color customTextColor = const Color(0xFF417123);

    // Obtención de dimensiones de la pantalla
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Configuración de la barra de aplicación
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Fondo de la página
          Image.asset(
            'assets/cascada.jpg',
            fit: BoxFit.cover,
          ),
          // Contenido principal
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    // Texto de bienvenida
                    Text(
                      'BIENVENIDOS',
                      style: TextStyle(
                        fontSize: screenHeight * 0.051,
                        color: customTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Logo de la aplicación
                    SizedBox(
                      width: screenWidth * 0.32,
                      height: screenWidth * 0.32,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Nombre de la aplicación
                    Text(
                      'PaliGOO',
                      style: TextStyle(
                        fontSize: screenHeight * 0.043,
                        color: Colors.white,
                        fontWeight: FontWeight.bold, // Añadido para negrita
                      ),
                    ),

                    SizedBox(
                      height: screenHeight * 0.015,
                    ),
                  ],
                ),
              ),
              // Espaciado adicional
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // Área de botones y texto
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenWidth * 0.05),
                color: Colors.black.withOpacity(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Botón de inicio de sesión
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginpage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customColor,
                        minimumSize: Size(screenWidth * 0.79, screenHeight * 0.09),
                      ),
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontSize: screenHeight * 0.032,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Espaciado adicional
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    // Texto y enlace para registrarse
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '¿No tienes cuenta aún? ',
                          style: TextStyle(
                            fontSize: screenHeight * 0.019,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/registropage');
                          },
                          child: Text(
                            'Regístrate',
                            style: TextStyle(
                              fontSize: screenHeight * 0.019,
                              color: customColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Espaciado adicional
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}