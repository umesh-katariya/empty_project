import 'package:empty_project/core/widgets/text_view.dart';
import 'package:flutter/material.dart';

class NoDataView extends StatelessWidget {
  String? noDataText;

  NoDataView({super.key, this.noDataText}) {
    noDataText ??= 'No data found';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextView(noDataText!,
              fontSize: 18,
              textColor: Colors.grey[350],
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
