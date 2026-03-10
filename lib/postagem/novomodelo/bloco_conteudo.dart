enum TipoBloco { texto, imagem, link }

class BlocoConteudo {
  final TipoBloco tipo;
  final String conteudo;
  final bool titulo;
  final bool italico;
  final double tamanhoFonte;

  BlocoConteudo({
    required this.tipo,
    required this.conteudo,
    this.titulo = false,
    this.italico = false,
    this.tamanhoFonte = 16,
  });

  factory BlocoConteudo.fromJson(Map<String, dynamic> json) {
    return BlocoConteudo(
      tipo: TipoBloco.values.firstWhere((e) => e.name == json['tipo']),
      conteudo: json['conteudo'],
      titulo: json['titulo'] ?? false,
      italico: json['italico'] ?? false,
      tamanhoFonte: (json['tamanhoFonte'] ?? 16).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'tipo': tipo.name,
    'conteudo': conteudo,
    'titulo': titulo,
    'italico': italico,
    'tamanhoFonte': tamanhoFonte,
  };
}
