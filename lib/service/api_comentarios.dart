import 'dart:convert';
import 'package:http/http.dart' as http;

// Clase que maneja la comunicación con la API de comentarios
class ApiComentarios {
  static const String apiUrl = 'http://192.168.1.5/comentariosApi/comentarios.php';

  // Método asíncrono para enviar un comentario a la API
  Future<bool> enviarComentario({
    required String comentario,
    required String email,
    required String actividad,
  }) async {
    try {
      // Construye la URL a partir de la constante apiUrl
      Uri url = Uri.parse(apiUrl);

      // Crea un mapa con los datos del comentario, email y actividad
      Map<String, dynamic> data = {
        'comentario': comentario,
        'email': email,
        'actividad': actividad,
      };

      // Realiza una solicitud HTTP POST a la URL con los datos proporcionados
      final response = await http.post(url, body: data);

      // Verifica si la respuesta del servidor tiene un código 200 (éxito)
      if (response.statusCode == 200) {
        // Decodifica el cuerpo de la respuesta JSON y obtiene la clave 'success'
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        final success = jsonResponse['success'] ?? false;

        // Retorna el valor de 'success'
        return success;
      } else {
        // Si la respuesta no es exitosa, lanza una excepción con el mensaje de error
        throw Exception('Error en la solicitud: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Captura cualquier excepción ocurrida durante el proceso y la imprime
      print('Error al enviar el comentario: $e');

      // Lanza la excepción nuevamente para que pueda ser manejada en otro lugar si es necesario
      throw e;
    }
  }
}
