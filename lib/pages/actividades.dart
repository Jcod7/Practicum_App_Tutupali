import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens.dart';

/// Esta clase representa la pantalla de Actividades.
class Actividades extends StatefulWidget {
  const Actividades({Key? key}) : super(key: key);

  @override
  State<Actividades> createState() => _ActividadesState();
}

class _ActividadesState extends State<Actividades> {
  // Colores utilizados en la pantalla
  Color selectedColor = const Color(0xFF417123);
  Color defaultColor = Colors.white;
  Color customTextColor = const Color(0xFF417123);
  Color customColor = const Color(0xFF5BDA57);

  // Tamaños y dimensiones utilizados en la pantalla
  double titulos = 17.8;
  double descripcionn = 14.2;
  double width = 250.0;
  double height = 220.0;
  double radius = 45.5;
  double lr = 22;

  int selectedIndex = 0;

  late String mailC;

  /// Método que se ejecuta cuando se producen cambios en las dependencias.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recuperar argumentos
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Verificar si hay argumentos y extraer la información necesaria
    if (arguments != null) {
      mailC = arguments['mailC'];
    } else {
      mailC = 'byron@gmail.com';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        elevation: 0,
        leading: GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.028),
            child: Image.asset(
              'assets/logo.png',
              width: screenWidth * 0.093,
              height: screenHeight * 0.093,
            ),
          ),
        ),
        title: Text(
          'QUE HACER',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: screenHeight * 0.04,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/configuracion');
            },
          ),
        ],
        toolbarHeight: screenHeight * 0.1,
      ),
      body: FutureBuilder<List<ActividadesModel>>(
        future: fetchActividades(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            // Manejo de errores al cargar datos
            String errorMessage = 'Error cargando datos';
            if (snapshot.error != null) {
              errorMessage += ': ${snapshot.error}';
            }
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  // Mostrar un diálogo de error
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(errorMessage),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  // Copiar mensaje de error al portapapeles
                                  Clipboard.setData(
                                      ClipboardData(text: errorMessage));
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Copiar mensaje'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text(errorMessage),
              ),
            );
          } else {
            // Datos cargados exitosamente, mostrar la lista de actividades
            final List<ActividadesModel> actividades = snapshot.data!;

            return ListView.builder(
              itemCount: actividades.length,
              itemBuilder: (context, index) {
                final ActividadesModel actividad = actividades[index];

                return Column(
                  children: [
                    const SizedBox(
                        height: 10), // Espacio antes de cada elemento
                    customListTile(
                      imageAsset: actividad.img,
                      title: actividad.actividad,
                      description: actividad.descripcion,
                      id: actividad.id,
                      onTap: () {},
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: screenHeight * 0.015), // Ajusta según tu necesidad
        padding: EdgeInsets.only(
            left: screenWidth * 0.07, right: screenWidth * 0.07),
        child: Container(
          height: screenHeight * 0.09,
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildIconButton(Icons.image, 0),
              buildIconButton(Icons.restaurant, 1),
              buildIconButton(Icons.location_on_outlined, 2),
              buildIconButton(Icons.qr_code, 3),
            ],
          ),
        ),
      ),
    );
  }

  // Construye un botón de la barra de navegación inferior
  IconButton buildIconButton(IconData icon, int index) {
    double screenHeight = MediaQuery.of(context).size.height;
    double iconsize = screenHeight * 0.032;

    return IconButton(
      icon: Icon(
        icon,
        color: selectedIndex == index ? selectedColor : defaultColor,
        size: iconsize,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });

        // Navegar a las pantallas correspondientes según el ícono seleccionado
        if (index == 1) {
          Navigator.pushNamed(context, '/gastronomia');
        }
        if (index == 2) {
          Navigator.pushNamed(context, '/mapa');
        }
        if (index == 3) {
          Navigator.pushNamed(context, '/qrscan');
        }
      },
    );
  }

  // Construye un elemento personalizado de la lista de actividades
  Widget customListTile({
    required String imageAsset,
    required String title,
    required String description,
    required String id,
    required Function onTap,
  }) {
    return Column(
      children: [
        // Imagen de la actividad
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () {
                if (title != "Gastronomia") {
                  // Navegar a la pantalla de detalles de la actividad
                  Navigator.pushNamed(
                    context,
                    '/actividades2',
                    arguments: {
                      'title': title,
                      'imageAsset': imageAsset,
                      'description': description,
                      'mailC': mailC,
                      'id': id,
                    },
                  );
                } else {
                  // Navegar a la pantalla de gastronomía
                  Navigator.pushNamed(context, '/gastronomia');
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageAsset.startsWith('http')
                    ? Image.network(
                        imageAsset,
                        width: width * 1.27,
                        height: height * 0.8,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        imageAsset,
                        width: width * 1.27,
                        height: height * 0.8,
                        fit: BoxFit.cover,
                      ),
              ),
            )),
        // Detalles de la actividad
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: customTextColor,
              fontSize: titulos,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            description,
            style: TextStyle(
              color: customTextColor,
              fontSize: descripcionn,
            ),
            textAlign: TextAlign.justify,
          ),
          onTap: () => onTap(),
        ),
        // Línea divisoria entre elementos de la lista
        Divider(
          color: customTextColor,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
