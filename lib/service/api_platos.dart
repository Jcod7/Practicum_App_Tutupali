import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/screens.dart';

// Función asíncrona para obtener la lista de platos desde la API
Future<List<PlatosModel>> fetchPlatos() async {
  try {
    // Realiza una solicitud GET a la URL de la API que proporciona la lista de platos
    final response =
        await http.get(Uri.parse('http://192.168.1.5/platosApi/platos.php'));

    // Verifica si la respuesta del servidor tiene un código de estado 200 (éxito)
    if (response.statusCode == 200) {
      // Decodifica el cuerpo de la respuesta JSON en una lista dinámica
      final List<dynamic> jsonList = json.decode(response.body);

      // Mapea cada elemento de la lista JSON a un objeto PlatosModel y retorna la lista resultante
      return jsonList.map((json) => PlatosModel.fromJson(json)).toList();
    } else {
      // Si la respuesta no es exitosa, lanza una excepción con un mensaje de error
      throw Exception('Failed to load platos');
    }
  } catch (e) {
    // Captura cualquier error durante la ejecución y lanza una excepción
    print('Error fetching platos: $e');
    throw e;
  }
}
