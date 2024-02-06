// Clase que representa un modelo para las actividades
class ActividadesModel {
  // Atributos de la actividad
  String id;           // Identificador único de la actividad
  String actividad;    // Nombre o título de la actividad
  String descripcion;  // Descripción de la actividad
  String img;          // URL o ruta de la imagen asociada a la actividad

  // Constructor que requiere todos los atributos para crear una instancia de la clase
  ActividadesModel({
    required this.id,
    required this.actividad,
    required this.descripcion,
    required this.img,
  });

  // Constructor de fábrica que convierte un mapa JSON en una instancia de la clase
  factory ActividadesModel.fromJson(Map<String, dynamic> json) =>
      ActividadesModel(
        id: json["id"],
        actividad: json["actividad"],
        descripcion: json["descripcion"],
        img: json["img"],
      );

  // Método que convierte la instancia de la clase en un mapa JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "actividad": actividad,
        "descripcion": descripcion,
        "img": img,
      };
}
