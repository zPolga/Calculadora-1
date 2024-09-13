import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculadora Feita em Flutter By: AdrianPolga 802.379"),
        ),
        body: Calculadora(),
      ),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = "0";
  String _input = "";
  String _operador = "";
  double _resultadoAtual = 0;

  void _pressionarBotao(String texto) {
    setState(() {
      if (texto == "C") {
        _input = "";
        _output = "0";
        _resultadoAtual = 0;
        _operador = "";
      } else if (texto == "=") {
        if (_input.isNotEmpty) {
          _resultadoAtual = _calcularResultado();
          _output = _resultadoAtual.toStringAsFixed(2);
          _input = "";
          _operador = "";
        }
      } else if (texto == "+" || texto == "-" || texto == "*" || texto == "/") {
        if (_input.isNotEmpty) {
          _resultadoAtual = double.parse(_input);
          _input = "";
          _operador = texto;
        }
      } else {
        _input += texto;
        _output = _input;
      }
    });
  }

  double _calcularResultado() {
    List<String> partes = _input.split(RegExp(r'([+\-*/])'));
    double num1 = double.parse(partes[0]);
    double num2 = double.parse(partes[1]);
    switch (_operador) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "*":
        return num1 * num2;
      case "/":
        return num2 != 0 ? num1 / num2 : 0;
      default:
        return 0;
    }
  }

  Widget _buildBotao(String texto) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _pressionarBotao(texto),
          child: Text(
            texto,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                _buildBotao("7"),
                _buildBotao("8"),
                _buildBotao("9"),
                _buildBotao("/"),
              ],
            ),
            Row(
              children: [
                _buildBotao("4"),
                _buildBotao("5"),
                _buildBotao("6"),
                _buildBotao("*"),
              ],
            ),
            Row(
              children: [
                _buildBotao("1"),
                _buildBotao("2"),
                _buildBotao("3"),
                _buildBotao("-"),
              ],
            ),
            Row(
              children: [
                _buildBotao("0"),
                _buildBotao("C"),
                _buildBotao("="),
                _buildBotao("+"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}