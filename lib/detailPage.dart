import 'package:flutter/material.dart';
import 'prdouctModel.dart';

List<String> colorData = [
  '#FFC0CB', // pink
  '#FFB6C1', // lightpink
  '#FF69B4', // hotpink
];

class ProductDetailsPage extends StatelessWidget {
  final ProductInfo productDetialinfo;

  const ProductDetailsPage({required this.productDetialinfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.grey[800],
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/Image_Logo.png',
            fit: BoxFit.contain, height: 30),
        centerTitle: true,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth =
                constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 800,
                  ),
                  child: Column(
                    children: [
                      ProductInfoSection(
                          maxWidth: maxWidth, productInfo: productDetialinfo),
                      Row(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                colors: [Colors.purple, Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              '細部說明',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      Text(
                          'Suspendisse potenti. Proin a velit sapien. Aenean eu ex in dui tristique egestas in quis lorem. Curabitur imperdiet molestie purus. Donec volutpat at turpis at cursus. Nullam ut facilisis nulla. Praesent sit amet orci ullamcorper, pharetra ipsum vel, vulputate magna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices.'),
                      Image.network(
                        'https://picsum.photos/800/300',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 16),
                      Image.network(
                        'https://picsum.photos/800/600',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductInfoSection extends StatelessWidget {
  final num maxWidth;
  final ProductInfo productInfo;

  const ProductInfoSection({
    Key? key,
    required this.maxWidth,
    required this.productInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: maxWidth > 600 ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: maxWidth > 600 ? 1 : 0,
          child: Image.network(
            'https://picsum.photos/300/300',
            width: double.infinity,
            height: 500,
            fit: BoxFit.cover,
          ),
        ),
        Flexible(
          flex: maxWidth > 600 ? 1 : 0,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productInfo.productName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '產品描述',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'NT\$${productInfo.productPrice}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ColorPicker(),
                  SizeSelector(
                    sizes: ['XS', 'S', 'M', 'L', 'XL'],
                    onSelect: (selectedSize) => print('選擇了尺寸 $selectedSize'),
                  ),
                  QuantitySelector(
                    initialValue: 1,
                    onQuantityChanged: (newQuantity) {
                      print('New quantity: $newQuantity');
                    },
                  ),
                  AddToCartButton(
                      text: '請選擇尺寸', onPressed: () => print('加入購物車')),
                  Text(
                    '實品顏色依單品照為主 \n 棉 100% \n 厚薄：薄 \n 彈性：無 \n 素材產地/日本 \n 加工產地 / 中國',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '顏色',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        VerticalDivider(
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
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
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
                primary:
                    _selectedSize == size ? Colors.grey[600] : Colors.grey[200],
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '尺寸',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        VerticalDivider(
          color: Colors.grey,
          thickness: 1,
        ),
        IconButton(
          icon: Icon(Icons.remove_circle),
          onPressed: _decrementQuantity,
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(border: InputBorder.none),
            onChanged: (value) {
              if (value.isNotEmpty) {
                _quantity = int.parse(value);
                widget.onQuantityChanged(_quantity);
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: _incrementQuantity,
        ),
      ],
    );
  }
}

class AddToCartButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback onPressed;

  AddToCartButton({
    required this.text,
    this.enabled = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          backgroundColor: enabled ? Colors.grey[800] : Colors.grey[300],
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
      ),
    );
  }
}
