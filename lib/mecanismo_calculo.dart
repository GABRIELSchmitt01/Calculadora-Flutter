import 'enum_operadores.dart';

class MecanismoCalculo {
  /// Resolve as operações de alta prioridade (Multiplicação e Divisão)
  static void _resolverPrioridades(
    List<double> numeros,
    List<TipoOperacao> operadores,
  ) {
    int indice = 0;

    while (indice < operadores.length) {
      final operadorAtual = operadores[indice];

      if (operadorAtual == TipoOperacao.multiplicacao) {
        numeros[indice] = numeros[indice] * numeros[indice + 1];
        numeros.removeAt(indice + 1);
        operadores.removeAt(indice);
      } else if (operadorAtual == TipoOperacao.divisao) {
        final divisor = numeros[indice + 1];
        if (divisor == 0) {
          throw Exception('Divisão por zero');
        }
        numeros[indice] = numeros[indice] / divisor;
        numeros.removeAt(indice + 1);
        operadores.removeAt(indice);
      } else {
        indice++;
      }
    }
  }

  /// Resolve as operações de baixa prioridade (Adição e Subtração)
  static double _resolverAdicaoESubtracao(
    List<double> numeros,
    List<TipoOperacao> operadores,
  ) {
    while (operadores.isNotEmpty) {
      final operadorAtual = operadores[0];

      if (operadorAtual == TipoOperacao.adicao) {
        numeros[0] = numeros[0] + numeros[1];
      } else if (operadorAtual == TipoOperacao.subtracao) {
        numeros[0] = numeros[0] - numeros[1];
      }

      numeros.removeAt(1);
      operadores.removeAt(0);
    }

    return numeros.first;
  }

  /// Método principal que executa o cálculo completo
  static double executar(List<double> numeros, List<TipoOperacao> operadores) {
    if (numeros.isEmpty) return 0.0;
    if (operadores.isEmpty) return numeros.first;

    final listaNumeros = List<double>.from(numeros);
    final listaOperadores = List<TipoOperacao>.from(operadores);

    _resolverPrioridades(listaNumeros, listaOperadores);
    return _resolverAdicaoESubtracao(listaNumeros, listaOperadores);
  }
}