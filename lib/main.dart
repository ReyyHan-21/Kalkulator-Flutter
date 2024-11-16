// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Android',
      theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          )),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0"; // Nilai Awal atau default

  void buttonPressed(String buttonText) {
    setState(() {
      // Jika Tombol C Ditekan maka akan kembali ke Nilai awal
      if (buttonText == "C") {
        output = '0';
        // Jika Tombol = ditekan maka hasil dari nilainya akan keluar
      } else if (buttonText == "=") {
        try {
          output = evaluateExpression(output
              .replaceAll('x', '*')
              .replaceAll('/', '÷')
            ); // Mengganti Tombol x dan /
        } catch (e) {
          output = 'Error';
        }
      } else {
        if (output == "0") {
          output = buttonText;
        } else {
          output += buttonText;
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    final parseExpression = Expression.parse(expression); //
    final evaluator = ExpressionEvaluator(); //
    final result = evaluator.eval(parseExpression, {}); //
    return result.toString(); //
  }

// digunakan untuk membuat tombol
  Widget buildButton(String buttonText, Color color,
      {double widthFactory = 1.0}) {
    return Expanded(
      flex: widthFactory.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 22),
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 0,
            ),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 24, left: 24),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton('C', Colors.grey.shade600),
                  buildButton('+/-', Colors.grey.shade600),
                  buildButton('%', Colors.grey.shade600),
                  buildButton('/', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('7', Colors.grey.shade800),
                  buildButton('8', Colors.grey.shade800),
                  buildButton('9', Colors.grey.shade800),
                  buildButton('x', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('4', Colors.grey.shade800),
                  buildButton('5', Colors.grey.shade800),
                  buildButton('6', Colors.grey.shade800),
                  buildButton('-', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('1', Colors.grey.shade800),
                  buildButton('2', Colors.grey.shade800),
                  buildButton('3', Colors.grey.shade800),
                  buildButton('+', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('0', Colors.grey.shade800, widthFactory: 2.0),
                  buildButton('.', Colors.grey.shade800),
                  buildButton('=', Colors.orange),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
