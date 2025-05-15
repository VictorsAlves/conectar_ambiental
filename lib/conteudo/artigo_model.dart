class Artigo {
  final String titulo;
  final List<String> paragrafos;

  Artigo({required this.titulo, required this.paragrafos});

  factory Artigo.fromJson(Map<String, dynamic> json) {
    return Artigo(
      titulo: json['titulo'],
      paragrafos: List<String>.from(json['paragrafos']),
    );
  }
}
