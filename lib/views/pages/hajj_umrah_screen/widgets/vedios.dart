import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:muslim_vision/views/pages/hajj_umrah_screen/widgets/hajj_vedios.dart';

class VediosPage extends StatefulWidget {
  const VediosPage({super.key});

  @override
  State<VediosPage> createState() => _VediosPageState();
}

class _VediosPageState extends State<VediosPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HajjUmrahVedios(vedio: 'l73KNCa7vlk')));
                  },
                  child: Text("hajj_gide".tr())),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HajjUmrahVedios(vedio: 'jjRUhG5cgZk')));
                  },
                  child: Text("hajj_in_detail_from_start_to_finish".tr())),
            ),
          ],
        ),
        // SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: ElevatedButton(
        //           onPressed: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => PDFScreen(
        //                           path: 'assets/pdf/Hajj book Bangla.pdf',
        //                           fileName: 'Hajj book Bangla.pdf',
        //                         )));
        //           },
        //           child: Text("PDf")),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
