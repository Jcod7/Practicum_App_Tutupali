import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/screens.dart';  // Asumiendo que importas los modelos desde este archivo

// Función asíncrona que obtiene la lista de actividades desde la API
Future<List<ActividadesModel>> fetchActividades() async {
  // Realiza una solicitud HTTP GET a la URL de la API
  final response = await http.get(Uri.parse('http://192.168.1.5/actividadesApi/actividades.php'));

  // Verifica si la respuesta del servidor es exitosa (código 200)
  if (response.statusCode == 200) {
    // Decodifica el cuerpo de la respuesta JSON y lo almacena en una lista dinámica
    final List<dynamic> jsonList = json.decode(response.body);
    
    // Mapea la lista dinámica a una lista de objetos ActividadesModel usando el constructor fromJson
    return jsonList.map((json) => ActividadesModel.fromJson(json)).toList();
  } else {
    // Si la respuesta no es exitosa, lanza una excepción con un mensaje de error
    throw Exception('Failed to load actividades');
  }
}
