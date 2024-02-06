import 'dart:convert';
import 'package:http/http.dart' as http;

// Clase estática que maneja las funciones de la API
class API {
  // Definición de la URL base para la conexión a la API
  static const hostConnect = "http://192.168.1.5/flutterApi";
  static const hostConnectUser = hostConnect;

  // Definición de endpoints específicos
  static const validateEmail = "$hostConnect/validate_email.php";
  static const signUp = "$hostConnect/signUp.php";
  static const login = "$hostConnect/login.php";

  // Método para obtener la URL completa concatenando el endpoint
  static String getFullUrl(String endpoint) {
    return "$hostConnect/$endpoint";
  }

  // Método asíncrono para verificar si un correo electrónico ya existe en la base de datos
  static Future<bool> checkEmailExists(String email) async {
    try {
      // Realiza una solicitud HTTP POST a la URL de validación de correo electrónico
      final response = await http.post(
        Uri.parse(validateEmail),
        body: {'user_email': email},
      );

      // Verifica si la respuesta del servidor tiene un código 200 (éxito)
      if (response.statusCode == 200) {
        // Decodifica el cuerpo de la respuesta JSON en un mapa dinámico
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Retorna el valor booleano indicando si el correo electrónico ya existe
        return responseData['emailFound'];
      } else {
        // Si la respuesta no es exitosa, lanza una excepción con un mensaje de error
        throw Exception('Error en la solicitud HTTP (${response.statusCode})');
      }
    } catch (e) {
      // Captura cualquier error durante la ejecución y lanza una excepción
      throw Exception('Error inesperado: $e');
    }
  }
}
