// Clase que representa un modelo para la información de restaurantes
class RestaurantesModel {
  // Atributos que describen un restaurante
  String id;            // Identificador único del restaurante
  String restaurante;   // Nombre o identificación del restaurante
  String direccion;     // Dirección física del restaurante
  String img;           // URL o referencia de la imagen del restaurante

  // Constructor que exige todos los atributos necesarios para instanciar un objeto RestaurantesModel
  RestaurantesModel({
    required this.id,
    required this.restaurante,
    required this.direccion,
    required this.img,
  });

  // Constructor de fábrica que convierte un mapa JSON en una instancia de la clase
  factory RestaurantesModel.fromJson(Map<String, dynamic> json) => RestaurantesModel(
        id: json["id"],
        restaurante: json["restaurante"],
        direccion: json["direccion"],
        img: json["img"],
      );

  // Método que convierte la instancia de la clase en un mapa JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurante": restaurante,
        "direccion": direccion,
        "img": img,
      };
}

// Función que convierte un string JSON en una lista de instancias de RestaurantesModel
List<RestaurantesModel> restaurantesModelFromJson(String str) =>
    List<RestaurantesModel>.from(
        json.decode(str).map((x) => RestaurantesModel.fromJson(x)));

// Función que convierte una lista de instancias de RestaurantesModel en un string JSON
String restaurantesModelToJson(List<RestaurantesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
