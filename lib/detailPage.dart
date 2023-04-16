import 'package:flutter/material.dart';
import 'Model/prdouct.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Color/ColorPicker.dart';
import 'Size/SizeSelector.dart';
import 'Quantity/QuantitySelector.dart';
import 'Quantity/QuantityCubit.dart';
import 'Cart/CartButton.dart';

List<String> colorDatas = [
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
          icon: const Icon(Icons.arrow_back),
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
                  constraints: const BoxConstraints(
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
                              return const LinearGradient(
                                colors: [Colors.purple, Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcIn,
                            child: const Text(
                              '細部說明',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Expanded(
                            child: Divider(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const Text(
                          'Suspendisse potenti. Proin a velit sapien. Aenean eu ex in dui tristique egestas in quis lorem. Curabitur imperdiet molestie purus. Donec volutpat at turpis at cursus. Nullam ut facilisis nulla. Praesent sit amet orci ullamcorper, pharetra ipsum vel, vulputate magna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices.'),
                      Image.network(
                        'https://picsum.photos/800/300',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
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
            padding: const EdgeInsets.all(16),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productInfo.productName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '產品描述',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'NT\$${productInfo.productPrice}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ColorPicker(colorData: colorDatas),
                  SizeSelector(
                    sizes: ['XS', 'S', 'M', 'L', 'XL'],
                    onSelect: (selectedSize) => print('選擇了尺寸 $selectedSize'),
                  ),
                  BlocProvider<QuantityCubit>(
                    create: (_) => QuantityCubit(1),
                    child: QuantitySelector(
                      initialValue: 1,
                      onQuantityChanged: (value) {},
                    ),
                  ),
                  AddToCartButton(
                      text: '請選擇尺寸', onPressed: () => print('加入購物車')),
                  const Text(
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