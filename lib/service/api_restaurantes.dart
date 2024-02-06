// Importa las bibliotecas necesarias
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../pages/screens.dart';  // Asegúrate de importar el archivo correcto que contiene la definición de RestaurantesModel

// Función asincrónica para obtener la lista de restaurantes
Future<List<RestaurantesModel>> fetchRestaurantes() async {
  // Realiza una solicitud GET a la URL de la API que proporciona la información de los restaurantes
  final response = await http
      .get(Uri.parse('http://192.168.1.5/restaurantesApi/restaurantes.php'));

  // Verifica si la respuesta del servidor tiene un código de estado 200 (OK)
  if (response.statusCode == 200) {
    // Convierte la respuesta JSON en una lista dinámica
    final List<dynamic> jsonList = json.decode(response.body);
    
    // Mapea cada elemento de la lista JSON a un objeto RestaurantesModel y devuelve la lista resultante
    return jsonList.map((json) => RestaurantesModel.fromJson(json)).toList();
  } else {
    // Lanza una excepción si la solicitud no fue exitosa
    throw Exception('Failed to load platos');  // El mensaje indica que ha fallado al cargar platos, ¿es correcto?
  }
}