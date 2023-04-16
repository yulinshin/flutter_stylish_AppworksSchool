import 'package:flutter/material.dart';
import 'SizeSelectorCubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  final Function(String) onSelect;

  const SizeSelector({Key? key, required this.sizes, required this.onSelect})
      : super(key: key);

  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  late final SizeSelectorCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = SizeSelectorCubit(widget.sizes);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '尺寸',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
        BlocBuilder<SizeSelectorCubit, String>(
          bloc: _cubit,
          builder: (context, selectedSize) {
            return Row(
              children: widget.sizes
                  .map(
                    (size) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _cubit.updateSize(size);
                          widget.onSelect(size);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedSize == size
                              ? Colors.grey[600]
                              : Colors.grey[200],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Text(
                          size,
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedSize == size
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
