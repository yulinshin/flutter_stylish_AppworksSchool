import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  final List<String> colorData;
  const ColorPicker({required this.colorData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '顏色',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        const VerticalDivider(
          width: 20,
          color: Colors.grey,
          thickness: 1,
        ),
        ColorSelector(colors: colorData),
      ],
    );
  }
}

class ColorSelector extends StatelessWidget {
  final List<String> colors;

  const ColorSelector({required this.colors});

  @override
  Widget build(BuildContext context) {
    List<Widget> colorWidgets = [];

    for (int i = 0; i < colors.length; i++) {
      colorWidgets.add(Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Color(int.parse(colors[i].replaceAll('#', '0xFF'))),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colorWidgets,
    );
  }
}
