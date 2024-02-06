import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reserva extends StatefulWidget {
  const Reserva({super.key});

  @override
  State<Reserva> createState() => _ReservaState();
}

class _ReservaState extends State<Reserva> {
  // Variable para almacenar la opción seleccionada en el menú
  String selectedValue = 'Cuy Asado';

  // Controlador de texto para la fecha
  final TextEditingController _dateController = TextEditingController();
  // Variable para almacenar la fecha seleccionada
  DateTime _selectedTime = DateTime.now();

  // Contador de personas en la reserva
  int _counter = 0;

  // Función para incrementar el contador de personas
  void _incrementCounter() {
    setState(() {
      _counter++;
      numeroPersonas = '$_counter';
    });
  }

  // Función para decrementar el contador de personas
  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
        numeroPersonas = '$_counter';
      });
    }
  }

  // Variables para almacenar información del restaurante
  late String restaurantee;
  late String idRestaurante;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recuperar argumentos
    Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Verificar si hay argumentos y extraer la información necesaria
    if (arguments != null) {
      restaurantee = arguments['restaurante'];
      idRestaurante = arguments['id'];
    }
  }

  // Nuevas variables para almacenar la información del formulario
  late String nombreCompleto;
  late String numeroTelefono;
  late String correoElectronico;
  late String numeroPersonas;
  late bool zonaVIP;
  late DateTime fecha;
  late TimeOfDay hora;
  late String restaurante;
  late String notas;
  late bool aceptaTerminos;

  @override
  void initState() {
    super.initState();
    // Inicializar las variables con valores predeterminados si es necesario
    nombreCompleto = "";
    numeroTelefono = "";
    correoElectronico = "";
    numeroPersonas = '0';
    zonaVIP = false;
    fecha = DateTime.now(); // Inicializar con la fecha actual
    hora = TimeOfDay.now(); // Inicializar con la hora actual
    restaurante = "";
    notas = "";
    aceptaTerminos = false;
  }

  // Función para validar si el formulario está completo y acepta términos
  bool isFormValid() {
    return nombreCompleto.isNotEmpty &&
        numeroTelefono.isNotEmpty &&
        correoElectronico.isNotEmpty &&
        numeroPersonas.isNotEmpty &&
        notas.isNotEmpty &&
        aceptaTerminos;
  }

  @override
  Widget build(BuildContext context) {
    // Obtener dimensiones de la pantalla
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Colores personalizados
    Color customColor = const Color(0xFF5BDA57);
    Color customColor3 = const Color(0xFFF2F5F0);

    // Radio para los bordes redondeados
    double radius = 45.5;

    // Tamaño del ícono en la barra inferior
    double iconsize = screenHeight * 0.032;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'GASTRONOMIA',
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
      body: Stack(
        children: [
          // Información del restaurante
          Positioned(
            top: screenHeight * 0.02,
            left: 0, // Ajusta según sea necesario
            right: 0, // Ajusta según sea necesario
            child: Center(
              child: Text(
                restaurantee,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenHeight * 0.028,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Sección de elegir fecha y hora
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.08,
            child: Text(
              'Elige tu fecha',
              style: TextStyle(
                color: Colors.black,
                fontSize: screenHeight * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.18,
            child: Text(
              'Elige tu hora',
              style: TextStyle(
                color: Colors.black,
                fontSize: screenHeight * 0.018,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Sección de notas y confirmar reserva
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.61,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Campo de notas y botón de confirmar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontSize: screenHeight * 0.018,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Notas',
                          ),
                          onChanged: (value) {
                            // Asigna el valor del TextField a la variable notas
                            setState(() {
                              notas = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          restaurante = restaurantee;
                          if (isFormValid()) {
                            Navigator.pushNamed(context, '/reserva2',
                                arguments: {
                                  'nombreCompleto': nombreCompleto,
                                  'numeroTelefono': numeroTelefono,
                                  'correoElectronico': correoElectronico,
                                  'numeroPersonas': numeroPersonas,
                                  'zonaVIP': zonaVIP,
                                  'fecha': fecha,
                                  'hora': hora,
                                  'restaurante': restaurante,
                                  'idRestaurante': idRestaurante,
                                  'notas': notas,
                                });
                          } else {
                            // Mostrar diálogo de campos incompletos
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Campos incompletos'),
                                  content: const Text(
                                      'Por favor, complete todos los campos y acepte los términos.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            isFormValid() ? customColor : Colors.grey,
                          ),
                        ),
                        child: Text(
                          'Confirmar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.016,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Checkbox de aceptar términos
                  CheckboxListTile(
                    title: Text(
                      'Estoy de acuerdo con los términos de servicio del restaurante.',
                      style: TextStyle(
                        fontSize: screenHeight * 0.016,
                      ),
                    ),
                    value: aceptaTerminos,
                    activeColor: customColor,
                    onChanged: (value) {
                      setState(() {
                        aceptaTerminos = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          // Información personal del usuario
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.35,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título "Tu Información"
                Text(
                  'Tu Información',
                  style: TextStyle(
                    fontSize: screenHeight * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1),
                // Campos de nombre, teléfono y correo
                TextField(
                  style: TextStyle(
                    fontSize: screenHeight * 0.018,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Nombre Completo',
                  ),
                  onChanged: (value) {
                    setState(() {
                      nombreCompleto = value;
                    });
                  },
                ),
                const SizedBox(height: 1),
                TextField(
                  style: TextStyle(
                    fontSize: screenHeight * 0.018,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Número de Teléfono',
                  ),
                  onChanged: (value) {
                    setState(() {
                      numeroTelefono = value;
                    });
                  },
                ),
                const SizedBox(height: 1),
                TextField(
                  style: TextStyle(
                    fontSize: screenHeight * 0.018,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                  ),
                  onChanged: (value) {
                    setState(() {
                      correoElectronico = value;
                    });
                  },
                ),
              ],
            ),
          ),
          // Checkbox de zona VIP
          Positioned(
            left: screenWidth * 0.012,
            right: screenWidth * 0.055,
            top: screenHeight * 0.295,
            child: CheckboxListTile(
              title: Text(
                'Zona VIP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenHeight * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
              value: zonaVIP,
              activeColor: customColor,
              onChanged: (value) {
                setState(() {
                  zonaVIP = value!;
                });
              },
            ),
          ),
          // Sección de cantidad de personas
          Positioned(
            left: screenWidth * 0.055,
            right: screenWidth * 0.055,
            top: screenHeight * 0.26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Texto "Cuántas personas:"
                Text(
                  'Cuántas personas:',
                  style: TextStyle(
                      fontSize: screenHeight * 0.018,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                // Botones para incrementar y decrementar cantidad
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _decrementCounter,
                    ),
                    Text(
                      '$_counter',
                      style: TextStyle(
                          fontSize: screenHeight * 0.018, color: Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _incrementCounter,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Sección de selección de hora
          Positioned(
            left: screenWidth * 0.135,
            right: screenWidth * 0.135,
            top: screenHeight * 0.22,
            child: GestureDetector(
              onTap: () {
                _selectTime(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: customColor3,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    const SizedBox(width: 8.5),
                    Icon(
                      Icons.access_time,
                      color: Colors.black,
                      size: screenHeight * 0.022,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      DateFormat('HH:mm').format(_selectedTime),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenHeight * 0.018,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Sección de selección de fecha
          Positioned(
              left: screenWidth * 0.055,
              right: screenWidth * 0.055,
              top: screenHeight * 0.08,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(30),
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'FECHA',
                    labelStyle: TextStyle(
                      fontSize: screenHeight * 0.018,
                    ),
                    filled: true,
                    fillColor: customColor3,
                    prefixIcon:
                        Icon(Icons.calendar_today, size: screenHeight * 0.022),
                    enabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: customColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 0.0),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                ),
              ))),
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            bottom: screenHeight * 0.015), // Ajusta según tu necesidad
        padding: EdgeInsets.only(
            left: screenWidth * 0.07, right: screenWidth * 0.07),
        child: Container(
          height: screenHeight * 0.09,
          decoration: BoxDecoration(
            color: customColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Iconos de la barra inferior
              IconButton(
                icon: Icon(
                  Icons.image,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/actividades');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.restaurant,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/gastronomia');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/mapa');
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: iconsize,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/qrscan');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para seleccionar la fecha
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      // Actualizar la fecha seleccionada
      _updateSelectedDate(picked);
    }
  }

  // Función para actualizar la fecha seleccionada
  void _updateSelectedDate(DateTime pickedDate) {
    setState(() {
      fecha = pickedDate;

      // Formatear la fecha y actualizar el controlador de texto
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _dateController.text = formattedDate;
    });
  }

  // Función para seleccionar la hora
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );

    if (picked != null &&
        (picked.hour != _selectedTime.hour ||
            picked.minute != _selectedTime.minute)) {
      setState(() {
        _selectedTime = DateTime(
          _selectedTime.year,
          _selectedTime.month,
          _selectedTime.day,
          picked.hour,
          picked.minute,
        );

        // Formatear la hora y actualizar la variable
        String formattedTime = DateFormat('HH:mm:ss').format(_selectedTime);
        hora = TimeOfDay.fromDateTime(
          DateFormat('HH:mm:ss').parse(formattedTime),
        );
      });
    }
  }
}
