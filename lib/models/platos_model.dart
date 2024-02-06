// Clase que representa un modelo para los platos de un restaurante
class PlatosModel {
  // Atributos del plato
  String id;           // Identificador único del plato
  String plato;        // Nombre o título del plato
  String precio;       // Precio del plato
  String img;          // URL o ruta de la imagen asociada al plato
  String restaurante;  // Nombre o identificación del restaurante al que pertenece el plato

  // Constructor que requiere todos los atributos para crear una instancia de la clase
  PlatosModel({
    required this.id,
    required this.plato,
    required this.precio,
    required this.img,
    required this.restaurante,
  });

  // Constructor de fábrica que convierte un mapa JSON en una instancia de la clase
  factory PlatosModel.fromJson(Map<String, dynamic> json) => PlatosModel(
        id: json["id"],
        plato: json["plato"],
        precio: json["precio"],
        img: json["img"],
        restaurante: json["restaurante"],
      );

  // Método que convierte la instancia de la clase en un mapa JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "plato": plato,
        "precio": precio,
        "img": img,
        "restaurante": restaurante,
      };
}

// Función que convierte un string JSON en una lista de instancias de PlatosModel
List<PlatosModel> platosModelFromJson(String str) => List<PlatosModel>.from(
    json.decode(str).map((x) => PlatosModel.fromJson(x)));

// Función que convierte una lista de instancias de PlatosModel en un string JSON
String platosModelToJson(List<PlatosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
