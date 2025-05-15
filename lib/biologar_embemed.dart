import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'dart:html' as html show IFrameElement;


class BiologarEmbed extends StatelessWidget {
  const BiologarEmbed({super.key});

  @override
  Widget build(BuildContext context) {
    // Registrar o iframe no DOM
    const String viewID = 'biologar-iframe';
    ui.platformViewRegistry.registerViewFactory(
      viewID,
          (int viewId) => html.IFrameElement()
        ..src = 'https://www.biologar.com.br/post/'
        ..style.border = 'none'
        ..width = '100%'
        ..height = '100%',
    );

    return const SizedBox(
      width: 1024,
      height: 768,
      child: HtmlElementView(viewType: viewID),
    );
  }
}
