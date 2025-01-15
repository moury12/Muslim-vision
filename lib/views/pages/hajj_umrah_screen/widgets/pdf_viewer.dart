import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({
    Key? key,
    this.path,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.asset(
      widget.path!,
      canShowPaginationDialog: true,
      pageSpacing: 2.0,
    );
  }
}
