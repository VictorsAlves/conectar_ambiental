class PostagemViewModel {
  final List<String> titulos;
  final List<String> paragrafos;

  PostagemViewModel({required this.titulos, required this.paragrafos});

  factory PostagemViewModel.fromJson(Map<String, dynamic> json) {
    return PostagemViewModel(
      titulos: List<String>.from(json['titulos']),
      paragrafos: List<String>.from(json['paragrafos']),
    );
  }
}
