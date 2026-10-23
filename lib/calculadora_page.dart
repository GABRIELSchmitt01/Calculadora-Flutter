import 'package:flutter/material.dart';
import 'historico_page.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _expressao = '';
  String _resultado = '0';
  final List<String> _historico = [];

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == 'C') {
        _expressao = '';
        _resultado = '0';
      } else if (valor == '=') {
        try {
          // Processamento simples da expressão
          var expCalculo = _expressao.replaceAll('x', '*').replaceAll('÷', '/');
          // Avaliação básica do resultado
          var resultadoCalculo = _avaliarExpressao(expCalculo);
          
          String registro = '$_expressao = $resultadoCalculo';
          _historico.add(registro);
          
          _resultado = resultadoCalculo.toString();
        } catch (e) {
          _resultado = 'Erro';
        }
      } else {
        if (_expressao == '' && ('+-x÷'.contains(valor))) return;
        _expressao += valor;
      }
    });
  }

  // Avaliador matemático básico para suportar a lógica do curso
  double _avaliarExpressao(String expressao) {
    try {
      // Usando uma lógica simples de cálculo direto para garantir funcionamento
      final partes = expressao.split(RegExp(r'([\+\-\*/])'));
      if (partes.length == 2) {
        double n1 = double.parse(partes[0]);
        double n2 = double.parse(partes[1]);
        if (expressao.contains('+')) return n1 + n2;
        if (expressao.contains('-')) return n1 - n2;
        if (expressao.contains('*')) return n1 * n2;
        if (expressao.contains('/')) return n2 != 0 ? n1 / n2 : 0;
      }
      return double.tryParse(expressao) ?? 0.0;
    } catch (_) {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Flutter'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoricoPage(historicoOperacoes: _historico),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expressao,
                    style: const TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _resultado,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // Grade de botões da calculadora
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _construirLinhaBotoes(['7', '8', '9', '÷']),
                  _construirLinhaBotoes(['4', '5', '6', 'x']),
                  _construirLinhaBotoes(['1', '2', '3', '-']),
                  _construirLinhaBotoes(['C', '0', '=', '+']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirLinhaBotoes(List<String> botoes) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: botoes.map((texto) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: texto == '=' ? Colors.deepPurple : Colors.grey[200],
                  foregroundColor: texto == '=' ? Colors.white : Colors.black87,
                ),
                onPressed: () => _pressionarBotao(texto),
                child: Text(
                  texto,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}