import 'package:flutter/material.dart';

class HistoricoPage extends StatelessWidget {
  final List<String> historicoOperacoes;

  const HistoricoPage({
    super.key,
    required this.historicoOperacoes,
  });

  @override
  Widget build(BuildContext context) {
    const corTema = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Cálculos'),
        backgroundColor: corTema,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: historicoOperacoes.isEmpty
          ? _construirEstadoVazio(corTema)
          : _construirListaHistorico(),
    );
  }

  Widget _construirEstadoVazio(Color corTema) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history_toggle_off_rounded,
            size: 64,
            color: corTema.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nenhum cálculo realizado',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirListaHistorico() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      itemCount: historicoOperacoes.length,
      itemBuilder: (context, indice) {
        final operacao = historicoOperacoes[indice];
        final numeroItem = indice + 1;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.shade100,
              child: Text(
                '$numeroItem',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            title: Text(
              operacao,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}