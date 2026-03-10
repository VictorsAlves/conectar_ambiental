import 'indice_item.dart';

class IndiceResponse {
  final List<IndiceItem> itens;

  IndiceResponse({required this.itens});

  factory IndiceResponse.fromJson(List<dynamic> json) {
    return IndiceResponse(
      itens: json.map((e) => IndiceItem.fromJson(e)).toList(),
    );
  }

  List<dynamic> toJson() {
    return itens.map((e) => e.toJson()).toList();
  }
}

