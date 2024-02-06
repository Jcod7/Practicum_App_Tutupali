import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screens.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Definición de colores y dimensiones
  Color customTextColor = const Color(0xFF417123);
  Color customColor = const Color(0xFF5BDA57);
  double borderRadius = 0.05;
  double widthText = 0.55;
  double heightText = 0.055;
  double widthB = 0.2;
  double heightB = 0.060;
  double widthC = 0.2;

  // Controladores para los campos de correo electrónico y contraseña
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicialización de controladores
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  // Método para mostrar un cuadro de diálogo de alerta
  void showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          content: Text(
            content,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Método para construir el botón de inicio de sesión
  ElevatedButton buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Obtención de correo electrónico y contraseña desde los controladores
        String userEmail = emailController.text;
        String userPassword = passwordController.text;

        String mailC = emailController.text;

        try {
          // Envío de solicitud HTTP para autenticación
          final response = await http.post(
            Uri.parse(API.login),
            body: {
              'user_email': userEmail,
              'user_password': userPassword,
            },
          );

          if (response.statusCode == 200) {
            final Map<String, dynamic> responseData =
                json.decode(response.body);

            if (responseData['success']) {
              // Navegación a la pantalla de actividades con argumentos
              Navigator.pushNamed(context, '/actividades',
                  arguments: {'mailC': mailC});
            } else {
              // Mostrar cuadro de diálogo en caso de error de autenticación
              showAlertDialog(context, 'Error de autenticación',
                  'Usuario o contraseña incorrectos');
            }
          } else {
            // Mostrar cuadro de diálogo en caso de error HTTP
            showAlertDialog(context, 'Error HTTP',
                'Error en la solicitud HTTP (${response.statusCode})');
          }
        } catch (e) {
          // Mostrar cuadro de diálogo en caso de error inesperado
          showAlertDialog(context, 'Error', 'Error inesperado: $e');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width * widthC,
            MediaQuery.of(context).size.height * heightB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width * borderRadius),
        ),
      ),
      child: Text(
        'Iniciar Sesión',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.020,
          color: customTextColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: customTextColor,
            size: MediaQuery.of(context).size.height * 0.05,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Iniciar Sesión',
          style: TextStyle(
            color: customTextColor,
            fontSize: MediaQuery.of(context).size.height * 0.039,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Contenedor con diseño de tarjeta para los campos y botones
          Positioned(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: customColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  // Campo de entrada para el correo electrónico
                  SizedBox(
                    width: MediaQuery.of(context).size.width * widthText,
                    height: MediaQuery.of(context).size.height * heightText,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * borderRadius),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ingrese su Correo',
                          hintStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.020,
                              color: customTextColor),
                        ),
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            color: customTextColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Campo de entrada para la contraseña
                  SizedBox(
                    width: MediaQuery.of(context).size.width * widthText,
                    height: MediaQuery.of(context).size.height * heightText,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * borderRadius),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText:
                            true, // Configura el obscureText a true para ocultar la contraseña
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Ingrese su Contraseña',
                          hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.020,
                            color: customTextColor,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: customTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botón de inicio de sesión
                  buildLoginButton(context),
                  const SizedBox(height: 10),
                  Text(
                    'o',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.022,
                        color: customTextColor),
                  ),
                  const SizedBox(height: 10),
                  // Botón para iniciar sesión con Facebook
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginfacebook');
                    },
                    icon: Icon(
                      Icons.facebook,
                      size: MediaQuery.of(context).size.height * 0.030,
                      color: customColor,
                    ),
                    label: Text(
                      'Ingresa con Facebook',
                      style: TextStyle(
                        color: customTextColor,
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * widthB,
                          MediaQuery.of(context).size.height * heightB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * borderRadius),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botón para iniciar sesión con Google
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/logingoogle');
                    },
                    icon: Icon(
                      Icons.mail,
                      size: MediaQuery.of(context).size.height * 0.030,
                      color: customColor,
                    ),
                    label: Text(
                      'Ingresa con Google',
                      style: TextStyle(
                        color: customTextColor,
                        fontSize: MediaQuery.of(context).size.height * 0.0199,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * widthB,
                          MediaQuery.of(context).size.height * heightB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * borderRadius),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Elementos centrados en la pantalla
          Center(
            child: Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  // Imagen del logo
                  Image.asset(
                    'assets/logo.png',
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: MediaQuery.of(context).size.width * 0.33,
                  ),
                  const SizedBox(height: 15),
                  // Texto de bienvenida
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      color: customTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}