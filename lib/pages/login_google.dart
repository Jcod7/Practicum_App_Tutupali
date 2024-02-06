import 'package:flutter/material.dart';

class LoginGoogle extends StatelessWidget {
  const LoginGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definición de colores y dimensiones
    Color customTextColor = const Color(0xFF417123);
    Color customColor = const Color(0xFF5BDA57);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double borderRadius = screenWidth * 0.04;
    double widthText = screenWidth * 0.65;
    double heightText = screenHeight * 0.065;
    double widthButton = screenWidth * 0.5;
    double heightButton = screenHeight * 0.062;
    double bottom = screenHeight * 0.08;
    double iconSize = screenWidth * 0.12;
    double fontSize = screenHeight * 0.020;
    double spacing = screenHeight * 0.075;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                // Separador superior
                SizedBox(height: spacing),
                // Encabezado del inicio de sesión con Google
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Iniciar Sesión con\n',
                        style: TextStyle(
                          fontSize: screenHeight * 0.042,
                          color: customTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Google',
                        style: TextStyle(
                          fontSize: screenHeight * 0.042,
                          color: customTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Separador entre encabezado y campos de texto
                SizedBox(height: screenHeight * 0.069),
                // Cuadro de texto para ingresar el correo electrónico
                Container(
                  width: widthText,
                  height: heightText,
                  decoration: BoxDecoration(
                    color: customColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: Colors.white),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ingrese su Correo',
                      hintStyle: TextStyle(
                          fontSize: screenHeight * 0.020, color: Colors.white),
                    ),
                    style: TextStyle(
                        fontSize: screenHeight * 0.020, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Separador entre campos de texto
                SizedBox(height: screenHeight * 0.035),
                // Cuadro de texto para ingresar la contraseña
                Container(
                  width: widthText,
                  height: heightText,
                  decoration: BoxDecoration(
                    color: customColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(color: Colors.white),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ingrese su Contraseña',
                      hintStyle: TextStyle(
                          fontSize: screenHeight * 0.020, color: Colors.white),
                    ),
                    style: TextStyle(
                        fontSize: screenHeight * 0.020, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Separador entre campos de texto y mensaje de información
                SizedBox(height: screenHeight * 0.085),
                // Mensaje de información sobre los datos compartidos con Google
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Para continuar, Google compartirá tu\n',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: customTextColor,
                        ),
                      ),
                      TextSpan(
                        text: 'nombre, tu dirección de correo\n',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: customTextColor,
                        ),
                      ),
                      TextSpan(
                        text: 'electrónico, tu preferencia de idioma\n',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: customTextColor,
                        ),
                      ),
                      TextSpan(
                        text: 'y tu foto de perfil con openai.com.\n',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: customTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Botón para regresar a la pantalla anterior
          Positioned(
            bottom: bottom,
            left: screenWidth * 0.05,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: customTextColor,
              ),
              iconSize: iconSize,
            ),
          ),
          // Botón para iniciar sesión con Google (sin funcionalidad definida)
          Positioned(
            bottom: bottom,
            right: screenWidth * 0.05,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: customColor,
                minimumSize: Size(widthButton, heightButton),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: screenHeight * 0.020,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
