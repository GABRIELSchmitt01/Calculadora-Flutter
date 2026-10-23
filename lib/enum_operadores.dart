enum TipoOperacao {
  adicao('+'),
  subtracao('-'),
  multiplicacao('x'),
  divisao('÷');

  final String simbolo;

  const TipoOperacao(this.simbolo);
}
