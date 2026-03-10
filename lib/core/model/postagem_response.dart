class PostagemResponse {
  final List<String> titulos;
  final List<String> paragrafos;

  PostagemResponse({required this.titulos, required this.paragrafos});

  factory PostagemResponse.fromJson(Map<String, dynamic> json) {
    return PostagemResponse(
      titulos: List<String>.from(json['titulos'] ?? []),
      paragrafos: List<String>.from(json['paragrafos'] ?? []),
    );
  }

  Map<String, dynamic> toJson(PostagemResponse data) {
    return {
      'titulos': data.titulos,
      'paragrafos': data.paragrafos,
    };
  }

  bool isNotEmpty() => titulos.isNotEmpty || paragrafos.isNotEmpty;
}
