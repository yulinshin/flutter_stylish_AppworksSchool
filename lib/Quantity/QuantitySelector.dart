import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'QuantityCubit.dart';

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final Function(int) onQuantityChanged;

  const QuantitySelector({
    Key? key,
    required this.initialValue,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          '數量',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: () {
            context.read<QuantityCubit>().decrement();
            _textController.text = context.read<QuantityCubit>().state.toString();
          },
        ),
        Expanded(
          child: BlocBuilder<QuantityCubit, int>(
            builder: (context, state) {
              return TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(border: InputBorder.none),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.read<QuantityCubit>().updateQuantity(int.parse(value));
                  }
                },
                controller: _textController,
              );
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: () {
            context.read<QuantityCubit>().increment();
            _textController.text = context.read<QuantityCubit>().state.toString();
          },
        ),
      ],
    );
  }
}
