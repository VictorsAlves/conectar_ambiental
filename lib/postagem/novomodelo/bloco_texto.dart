class BlocoTexto {
  final String texto;
  final bool negrito;
  final bool italico;
  final double tamanhoFonte;

  BlocoTexto({
    required this.texto,
    this.negrito = false,
    this.italico = false,
    this.tamanhoFonte = 16.0,
  });

  Map<String, dynamic> toJson() => {
    'texto': texto,
    'negrito': negrito,
    'italico': italico,
    'tamanhoFonte': tamanhoFonte,
  };

  factory BlocoTexto.fromJson(Map<String, dynamic> json) {
    return BlocoTexto(
      texto: json['texto'],
      negrito: json['negrito'] ?? false,
      italico: json['italico'] ?? false,
      tamanhoFonte: (json['tamanhoFonte'] ?? 16.0).toDouble(),
    );
  }
}
