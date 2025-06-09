import 'package:flutter/material.dart';

class EditorCompletoPage extends StatefulWidget {
  const EditorCompletoPage({super.key});

  @override
  State<EditorCompletoPage> createState() => _EditorCompletoPageState();
}

class _EditorCompletoPageState extends State<EditorCompletoPage> {
  final controller = TextEditingController();

  void aplicarMarcacao(String tag) {
    final selection = controller.selection;
    if (!selection.isValid || selection.isCollapsed) return;

    final text = controller.text;
    final before = text.substring(0, selection.start);
    final selected = text.substring(selection.start, selection.end);
    final after = text.substring(selection.end);

    final marcado = '<$tag>$selected</$tag>';
    controller.text = before + marcado + after;
    controller.selection =
        TextSelection.collapsed(offset: (before + marcado).length);

    setState(() {});
  }

  void inserirImagem(String alinhamento) async {
    final urlController = TextEditingController();
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Inserir imagem'),
        content: TextField(
          controller: urlController,
          decoration: const InputDecoration(hintText: 'URL da imagem'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final url = urlController.text.trim();
              if (url.isNotEmpty) {
                final text = controller.text;
                final selection = controller.selection;
                final before = text.substring(0, selection.start);
                final after = text.substring(selection.end);
                final marcado = '<img align="$alinhamento">$url</img>';
                controller.text = before + marcado + after;
                controller.selection =
                    TextSelection.collapsed(offset: (before + marcado).length);
                setState(() {});
              }
              Navigator.pop(context);
            },
            child: const Text('Inserir'),
          ),
        ],
      ),
    );
  }

  List<InlineSpan> parseTextoFormatado(String texto) {
    final spans = <InlineSpan>[];
    final regex = RegExp(
        r'<(b|i|h1)>(.*?)<\/\1>|<img align="(.*?)">(.*?)<\/img>',
        dotAll: true);
    final matches = regex.allMatches(texto);

    int cursor = 0;
    for (final match in matches) {
      if (match.start > cursor) {
        spans.add(TextSpan(text: texto.substring(cursor, match.start)));
      }

      if (match.group(1) != null) {
        final tag = match.group(1);
        final content = match.group(2);

        TextStyle style;
        switch (tag) {
          case 'b':
            style = const TextStyle(fontWeight: FontWeight.bold);
            break;
          case 'i':
            style = const TextStyle(fontStyle: FontStyle.italic);
            break;
          case 'h1':
            style = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
            break;
          default:
            style = const TextStyle();
        }

        spans.add(TextSpan(text: content, style: style));
      } else if (match.group(3) != null) {
        final align = match.group(3);
        final url = match.group(4);
        Alignment alignment;
        switch (align) {
          case 'left':
            alignment = Alignment.centerLeft;
            break;
          case 'right':
            alignment = Alignment.centerRight;
            break;
          default:
            alignment = Alignment.center;
        }
        spans.add(WidgetSpan(
          child: Container(
            alignment: alignment,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Image.network(url!, height: 150),
          ),
        ));
      }
      cursor = match.end;
    }

    if (cursor < texto.length) {
      spans.add(TextSpan(text: texto.substring(cursor)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Editor com Formatação Parcial')),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        children: parseTextoFormatado(controller.text),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 48,
                            maxHeight: 96,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:
                                NotificationListener<OverscrollIndicatorNotification>(
                              onNotification:
                                  (OverscrollIndicatorNotification overscroll) {
                                overscroll.disallowIndicator();
                                return true;
                              },
                              child: SingleChildScrollView(
                                reverse: true,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: TextField(
                                  controller: controller,
                                  maxLines: null,
                                  expands: false,
                                  onChanged: (_) => setState(() {}),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Digite aqui...'),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.format_bold),
                        tooltip: 'Negrito',
                        onPressed: () => aplicarMarcacao('b'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.format_italic),
                        tooltip: 'Itálico',
                        onPressed: () => aplicarMarcacao('i'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.title),
                        tooltip: 'Título',
                        onPressed: () => aplicarMarcacao('h1'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.image),
                        tooltip: 'Imagem à esquerda',
                        onPressed: () => inserirImagem('left'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.image_rounded),
                        tooltip: 'Imagem centralizada',
                        onPressed: () => inserirImagem('center'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.image_rounded),
                        tooltip: 'Imagem à direita',
                        onPressed: () => inserirImagem('right'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => debugPrint(controller.text),
                        icon: const Icon(Icons.send),
                        label: const Text('Enviar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
