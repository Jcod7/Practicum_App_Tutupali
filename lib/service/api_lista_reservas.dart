import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/screens.dart';

// Función asíncrona para obtener la lista de reservas desde la API
Future<List<ReservasModel>> fetchReservas() async {
  // Realiza una solicitud HTTP GET a la URL de la API de reservas
  final response = await http
      .get(Uri.parse('http://192.168.1.5/reservasApi2/listaReservas.php'));

  // Verifica si la respuesta del servidor tiene un código 200 (éxito)
  if (response.statusCode == 200) {
    // Decodifica el cuerpo de la respuesta JSON en una lista dinámica
    final List<dynamic> jsonList = json.decode(response.body);

    // Mapea la lista dinámica a una lista de objetos ReservasModel utilizando el constructor desdeJson
    return jsonList.map((json) => ReservasModel.fromJson(json)).toList();
  } else {
    // Si la respuesta no es exitosa, lanza una excepción con un mensaje de error
    throw Exception('Failed to load platos');
  }
}