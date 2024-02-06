import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiReservas {
  // URL de la API para gestionar reservas
  static const String apiUrl = 'http://192.168.1.5/reservasApi/reservas.php';

  // Método para enviar una solicitud de reserva
  Future<bool> enviarReserva({
    required String nombreCompleto,
    required String numeroTelefono,
    required String correoElectronico,
    required String numeroPersonas,
    required bool zonaVIP,
    required DateTime fecha,
    required TimeOfDay hora,
    required String restaurante,
    required String notas,
  }) async {
    try {
      // Construye la URL de la API
      Uri url = Uri.parse(apiUrl);

      // Imprime la hora antes y después de formatear para depuración
      print('Hora antes de formatear: $hora');
      String horaFormateada =
          '${hora.hour}:${hora.minute.toString().padLeft(2, '0')}:00';
      print('Hora formateada: $horaFormateada');

      // Convierte el valor booleano a su representación de cadena
      String zonaVIPString = zonaVIP.toString();

      // Datos a enviar en el cuerpo de la solicitud POST
      Map<String, dynamic> data = {
        'nombre': nombreCompleto,
        'telefono': numeroTelefono,
        'email': correoElectronico,
        'personas': numeroPersonas,
        'vip': zonaVIPString,
        'fecha': fecha.toIso8601String(),
        'hora': horaFormateada,
        'restaurante': restaurante,
        'notas': notas,
      };

      // Imprime tipos de datos y valores antes de enviar la solicitud para depuración
      print('Tipos de datos y valores antes de enviar la solicitud:');
      data.forEach((key, value) {
        print('$key: ${value.runtimeType}, Valor: $value');
      });

      // Realiza la solicitud POST a la API
      http.Response response = await http.post(url, body: data);

      // Verifica si la respuesta del servidor tiene un código de estado 200 (éxito)
      if (response.statusCode == 200) {
        // Manejo especial si la respuesta contiene '<br />' (HTML)
        if (response.body.contains('<br />')) {
          // Manejar respuesta HTML
          print('Respuesta HTML del servidor: ${response.body}');
          // Realizar acciones adicionales según sea necesario
          return false; // O lanza una excepción si es necesario
        }

        // Decodifica el cuerpo de la respuesta JSON
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        // Obtiene el valor de 'success' o establece un valor predeterminado como falso
        bool success = jsonResponse['success'] ?? false;
        return success;
      } else {
        // Lanza una excepción si la respuesta no es exitosa
        throw Exception('Error en la solicitud: ${response.reasonPhrase}');
      }
    } catch (e, stackTrace) {
      // Captura cualquier error durante la ejecución y muestra información de depuración
      print('Error al enviar la reserva: $e');
      print('Stack trace: $stackTrace');

      // Puedes mostrar un mensaje de error o realizar acciones adicionales según sea necesario
      return false; // o lanza una excepción si es necesario
    }
  }
}