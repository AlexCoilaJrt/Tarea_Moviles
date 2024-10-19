import 'package:calc_upeu/comp/CustomAppBar.dart';
import 'package:calc_upeu/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'comp/CalcButton.dart';
import 'dart:math'; // Importa math para usar operaciones como pow y sqrt

void main() => runApp(CalcApp());

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  CalcAppState createState() => CalcAppState();
}

class CalcAppState extends State<CalcApp> {
  String valorAnt = '';
  String operador = '';
  bool decimalAdded = false;
  TextEditingController _controller = new TextEditingController();

  // Función para el botón de número o decimal
  void numClick(String text) {
    setState(() {
      if (text == "." && decimalAdded) {
        return; // Evita agregar más de un punto decimal
      } else if (text == ".") {
        decimalAdded = true;
      }
      _controller.text += text;
    });
  }

  // Función para la tecla AC (Borrar todo)
  void clearAll(String text) {
    setState(() {
      _controller.text = '';      // Limpia la pantalla
      valorAnt = '';              // Elimina cualquier valor anterior
      operador = '';              // Elimina el operador seleccionado
      decimalAdded = false;       // Resetea el estado del punto decimal
    });
  }

  // Función para la tecla C (Borrar solo la entrada actual)
  void clearEntry(String text) {
    setState(() {
      _controller.text = '';      // Limpia la pantalla, pero no toca el operador ni el valor anterior
      decimalAdded = false;       // Permite agregar un nuevo punto decimal
    });
  }

  // Función para seleccionar operadores
  void opeClick(String text) {
    setState(() {
      valorAnt = _controller.text;
      operador = text;
      _controller.text = '';
      decimalAdded = false;
    });
  }

  // Función para operaciones individuales (raíz cuadrada, inverso)
  void singleOpe(String text) {
    setState(() {
      if (text == "π") {
        _controller.text = pi.toString(); // Solo muestra el valor de Pi
      } else {
        double valor = double.parse(_controller.text);
        switch (text) {
          case "√": // Raíz cuadrada
            _controller.text = sqrt(valor).toString();
            break;
          case "1/x": // Inverso
            if (valor != 0) {
              _controller.text = (1 / valor).toString();
            } else {
              _controller.text = "Error"; // Manejo de división entre 0
            }
            break;
          case "x²": // Potencia al cuadrado
            _controller.text = pow(valor, 2).toString(); // Eleva al cuadrado
            break;
        }
      }
    });
  }

  // Función para calcular la operación seleccionada
  void resultOperacion(String text) {
    setState(() {
      double valor1 = double.parse(valorAnt);
      double valor2 = double.parse(_controller.text);
      switch (operador) {
        case "/":
          if (valor2 != 0) {
            _controller.text = (valor1 / valor2).toString();
          } else {
            _controller.text = "Error";
          }
          break;
        case "*":
          _controller.text = (valor1 * valor2).toString();
          break;
        case "+":
          _controller.text = (valor1 + valor2).toString();
          break;
        case "-":
          _controller.text = (valor1 - valor2).toString();
          break;
        case "%":
          _controller.text = (valor1 % valor2).toString();
          break;
        case "^": // Potencia
          _controller.text = pow(valor1, valor2).toString();
          break;
      }
      decimalAdded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Matrices de etiquetas y funciones
    List<List> labelList = [
      ["AC", "C", "√", "1/x"],
      ["7", "8", "9", "/"],
      ["4", "5", "6", "*"],
      ["1", "2", "3", "-"],
      [".", "0", "^", "+"],
      ["π", "x²", "=", "%"]
    ];

    List<List> funx = [
      [clearAll, clearEntry, singleOpe, singleOpe], // AC usa `clearAll`, C usa `clearEntry`
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, opeClick, opeClick], // Potencia
      [singleOpe, singleOpe, resultOperacion, opeClick] // Pi y potencia al cuadrado
    ];

    AppTheme.colorX = Colors.lightBlue;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alex Coila Calc',
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData, // Aplica el tema seleccionado
      home: Scaffold(
        appBar: CustomAppBar(accionx: () {}),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: _controller,
                  style: const TextStyle(fontSize: 30), // Tamaño de texto más grande
                  readOnly: true, // Evita que se edite manualmente
                ),
              ),
              const SizedBox(height: 20),
              // Botones organizados en filas usando la matriz restaurada
              ...List.generate(labelList.length, (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(labelList[index].length, (indexx) {
                  return CalcButton(
                    text: labelList[index][indexx],
                    callback: funx[index][indexx] as Function,
                  );
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
