
import 'package:flutter/material.dart';

class BannerGenerator extends StatelessWidget {
  const BannerGenerator({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;
  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.network(
        url,
        height: 200,
        width: 400,
        fit: BoxFit.fitWidth,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}