import 'package:flutter/material.dart';
import 'prdouctModel.dart';

class DetailPage extends StatelessWidget {
  final ProductInfo product;

  const DetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TwoBlocksWidget(topText: '1', bottomText: '2'),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> colorData = [
  '#FFC0CB', // pink
  '#FFB6C1', // lightpink
  '#FF69B4', // hotpink
];

class TwoBlocksWidget extends StatelessWidget {
  final String topText;
  final String bottomText;

  const TwoBlocksWidget({required this.topText, required this.bottomText});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: MediaQuery.of(context).size.width < 600
          ? Axis.vertical
          : Axis.horizontal,
      children: [
        Flexible(
          child: SizedBox(
            height: 400,
            child: Image.network(
              'https://images.pexels.com/photos/3965557/pexels-photo-3965557.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(
          child: Container(
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '產品名稱',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '產品編號: 123456',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '價錢: \$100',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey[500],
                    ),
                    Row(
                      children: [
                        Text(
                          '顏色',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey[500],
                          ),
                        ),
                        ColorSelector(colors: colorData),
                      ],
                    ),
                    SizeSelector(
                      sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
                      onSelect: (selectedSize) => print('選擇了尺寸 $selectedSize'),
                    ),
                    QuantitySelector(
                      initialValue: 1,
                      onQuantityChanged: (newQuantity) {
                        print('New quantity: $newQuantity');
                      },
                    ),
                    RectangleButton(text: '請選擇尺寸', onPressed: () => print('加入購物車')),
                     Text(
                          '實品顏色依單品照為主 \n 棉 100% \n 厚薄：薄 \n 彈性：無 \n 素材產地/日本 \n 加工產地 / 中國',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorSelector extends StatelessWidget {
  final List<String> colors;

  ColorSelector({required this.colors});

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

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  final Function(String) onSelect;

  const SizeSelector({Key? key, required this.sizes, required this.onSelect})
      : super(key: key);

  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String _selectedSize = '';

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.sizes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '尺寸',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        for (var size in widget.sizes)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedSize = size;
                });
                widget.onSelect(size);
              },
              child: Text(
                size,
                style: TextStyle(
                  fontSize: 16,
                  color: _selectedSize == size ? Colors.white : Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: _selectedSize == size ? Colors.blue : Colors.grey[200],
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final Function(int) onQuantityChanged;

  QuantitySelector(
      {required this.initialValue, required this.onQuantityChanged});

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late TextEditingController _controller;
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
    _controller = TextEditingController(text: _quantity.toString());
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _controller.text = _quantity.toString();
    });
    widget.onQuantityChanged(_quantity);
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
        _controller.text = _quantity.toString();
      }
    });
    widget.onQuantityChanged(_quantity);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrementQuantity,
        ),
        SizedBox(
          width: 64.0,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                _quantity = int.parse(value);
                widget.onQuantityChanged(_quantity);
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _incrementQuantity,
        ),
      ],
    );
  }
}

class RectangleButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback onPressed;

  RectangleButton({
    required this.text,
    this.enabled = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        primary: enabled ? Colors.blue : Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
