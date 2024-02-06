// Clase que representa un modelo para las reservas de un restaurante
class ReservasModel {
  // Atributos de la reserva
  String id;            // Identificador único de la reserva
  String nombre;        // Nombre completo del cliente que realiza la reserva
  String telefono;      // Número de teléfono del cliente
  String email;         // Dirección de correo electrónico del cliente
  String personas;      // Número de personas en la reserva
  String vip;           // Indicador VIP (1 si es VIP, 0 si no lo es)
  DateTime fecha;       // Fecha de la reserva
  String hora;          // Hora de la reserva (formato HH:mm)
  String restaurante;   // Nombre o identificación del restaurante de la reserva
  String notas;         // Notas adicionales o comentarios para la reserva
  String estado;        // Estado de la reserva (pendiente, finalizada, cancelada, etc.)

  // Constructor que requiere todos los atributos para crear una instancia de la clase
  ReservasModel({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.email,
    required this.personas,
    required this.vip,
    required this.fecha,
    required this.hora,
    required this.restaurante,
    required this.notas,
    required this.estado,
  });

  // Constructor de fábrica que convierte un mapa JSON en una instancia de la clase
  factory ReservasModel.fromJson(Map<String, dynamic> json) => ReservasModel(
        id: json["id"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        email: json["email"],
        personas: json["personas"],
        vip: json["vip"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        restaurante: json["restaurante"],
        notas: json["notas"],
        estado: json["estado"],
      );

  // Método que convierte la instancia de la clase en un mapa JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "telefono": telefono,
        "email": email,
        "personas": personas,
        "vip": vip,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "restaurante": restaurante,
        "notas": notas,
        "estado": estado,
      };
}

// Función que convierte un string JSON en una lista de instancias de ReservasModel
List<ReservasModel> reservasModelFromJson(String str) =>
    List<ReservasModel>.from(
        json.decode(str).map((x) => ReservasModel.fromJson(x)));

// Función que convierte una lista de instancias de ReservasModel en un string JSON
String reservasModelToJson(List<ReservasModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
