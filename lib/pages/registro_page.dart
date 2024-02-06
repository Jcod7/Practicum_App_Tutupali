import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../service/api_login_sign_up.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  // Color personalizado para el texto
  Color customTextColor = const Color(0xFF417123);

  // Controladores de texto para los campos de nombre, correo y contraseña
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Función para validar el formato del correo electrónico
  bool validateEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Nueva función para mostrar el AlertDialog de éxito
  void showSuccessAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Registro exitoso',
            style: TextStyle(color: Colors.white), // Establecer color del texto
          ),
          content: Text(
            message,
            style: const TextStyle(
                color: Colors.white), // Establecer color del texto
          ),
          backgroundColor: Colors.green, // Personalizar color de fondo
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    color: Colors.white), // Establecer color del texto
              ),
            ),
          ],
        );
      },
    );
  }

  // Botón elevado personalizado para crear una cuenta
  ElevatedButton buildCreateAccountButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String userName = nameController.text;
        String userEmail = emailController.text;
        String userPassword = passwordController.text;

        // Validar el formato del correo electrónico
        if (!validateEmail(userEmail)) {
          showAlertDialog(
              context, 'Error de registro', 'Correo electrónico no válido.');
          return;
        }

        try {
          // Verificar si el correo electrónico ya existe
          bool emailExists = await API.checkEmailExists(userEmail);

          if (emailExists) {
            showAlertDialog(context, 'Error de registro',
                'El correo electrónico ya está registrado.');
            return;
          }

          // Realizar la solicitud HTTP para el registro
          final response = await http.post(
            Uri.parse(API.signUp),
            body: {
              'user_name': userName,
              'user_email': userEmail,
              'user_password': userPassword,
            },
          );

          if (response.statusCode == 200) {
            final Map<String, dynamic> responseData =
                json.decode(response.body);

            if (responseData['success']) {
              // Registro exitoso, mostrar AlertDialog de éxito
              showSuccessAlertDialog(
                  context, '¡Cuenta creada exitosamente!');
            } else {
              showAlertDialog(
                  context, 'Error de registro', responseData['message']);
            }
          } else {
            showAlertDialog(context, 'Error HTTP',
                'Error en la solicitud HTTP (${response.statusCode})');
          }
        } catch (e) {
          showAlertDialog(context, 'Error', 'Error inesperado: $e');
        }
      },
      // Estilo del botón
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.3,
            MediaQuery.of(context).size.height * 0.060),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.05),
        ),
      ),
      child: Text(
        'Crear Cuenta',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.02,
          color: customTextColor,
        ),
      ),
    );
  }

  // Widget para construir un campo de texto personalizado
  Widget buildTextField(
      TextEditingController controller, String hintText, Color textColor,
      {bool isPassword = false}) {
    // Ajustar estos valores según tus preferencias
    double textFieldWidth = MediaQuery.of(context).size.width * 0.55;
    double textFieldHeight = MediaQuery.of(context).size.height * 0.055;
    double fontSize = MediaQuery.of(context).size.height * 0.02;

    return Container(
      width: textFieldWidth,
      height: textFieldHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.05), // Ajustar el radio del borde
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: fontSize, color: textColor),
        ),
        style: TextStyle(fontSize: fontSize, color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Color personalizado
    Color customColor = const Color(0xFF5BDA57);

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
          'Registro',
          style: TextStyle(
            color: customTextColor,
            fontSize: MediaQuery.of(context).size.height * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Contenedor principal con diseño de tarjeta
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
                  const SizedBox(height: 30),
                  // Campos de texto para nombre, correo y contraseña
                  buildTextField(
                      nameController, 'Ingrese su Nombre', customTextColor),
                  const SizedBox(height: 15),
                  buildTextField(
                      emailController, 'Ingrese su Correo', customTextColor),
                  const SizedBox(height: 15),
                  buildTextField(passwordController, 'Ingrese una Contraseña',
                      customTextColor,
                      isPassword: true),
                  const SizedBox(height: 15),
                  // Botón para crear la cuenta
                  buildCreateAccountButton(context),
                  const SizedBox(height: 5),
                  Text(
                    'o',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.022,
                        color: customTextColor),
                  ),
                  const SizedBox(height: 5),
                  // Botón elevado con icono para ingresar con Facebook
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginfacebook');
                    },
                    icon: Icon(
                      Icons.facebook,
                      size: MediaQuery.of(context).size.height * 0.03,
                      color: customColor,
                    ),
                    label: Text(
                      'Ingresa con Facebook',
                      style: TextStyle(
                        color: customTextColor,
                        fontSize: MediaQuery.of(context).size.height * 0.018,
                      ),
                    ),
                    // Estilo del botón
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.2,
                          MediaQuery.of(context).size.height * 0.060),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Botón elevado con icono para ingresar con Google
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/logingoogle');
                    },
                    icon: Icon(
                      Icons.mail,
                      size: MediaQuery.of(context).size.height * 0.03,
                      color: customColor,
                    ),
                    label: Text(
                      'Ingresa con Google',
                      style: TextStyle(
                        color: customTextColor,
                        fontSize: MediaQuery.of(context).size.height * 0.0199,
                      ),
                    ),
                    // Estilo del botón
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.2,
                          MediaQuery.of(context).size.height * 0.060),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Centro del logotipo y título
          Center(
            child: Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width / 2 - 20,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  // Imagen del logotipo
                  Image.asset(
                    'assets/logo.png',
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: MediaQuery.of(context).size.width * 0.33,
                  ),
                  const SizedBox(height: 15),
                  // Título "Crea tu cuenta"
                  Text(
                    'Crea tu cuenta',
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

  // Función para mostrar un AlertDialog con título, contenido y botón "OK"
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
          backgroundColor: Colors.red, // Personalizar color de fondo
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
}