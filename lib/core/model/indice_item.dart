class IndiceItem {
  final int numero;
  final String arquivo;
  final List<String> titulos;

  IndiceItem({required this.numero, required this.arquivo, required this.titulos});

  factory IndiceItem.fromJson(Map<String, dynamic> json) {
    return IndiceItem(
      numero: json['numero'],
      arquivo: json['arquivo'],
      titulos: List<String>.from(json['titulos']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero': numero,
      'arquivo': arquivo,
      'titulos': titulos,
    };
  }
}
