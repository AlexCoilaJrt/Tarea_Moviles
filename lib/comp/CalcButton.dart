import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String? text;
  final int fillColor;
  final int textColor;
  final double textSize;
  final Function? callback;
  const CalcButton({
    Key? key,
    this.text,
    this.fillColor = 0xFF81D4FA, // Color de relleno predeterminado (celeste)
    this.textColor = 0xFFFFFFFF, // Blanco para el texto
    this.textSize = 25, // Tamaño de texto más grande para destacar
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5), // Espacio alrededor de cada botón
      child: SizedBox(
        width: 70, // Ajuste del tamaño del botón
        height: 70,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(fillColor), // Color del botón
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Bordes redondeados
            ),
          ),
          onPressed: () {
            callback!(text);
          },
          child: Text(
            text!,
            style: TextStyle(
              fontSize: textSize,
              color: Color(textColor),
              fontWeight: FontWeight.bold, // Hace que el texto sea más prominente
            ),
          ),
        ),
      ),
    );
  }
}
