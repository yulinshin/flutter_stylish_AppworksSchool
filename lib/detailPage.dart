import 'package:flutter/material.dart';
import 'Product/prdouct.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Color/ColorPicker.dart';
import 'Size/SizeSelector.dart';
import 'Quantity/QuantitySelector.dart';
import 'Quantity/QuantityCubit.dart';
import 'Cart/CartButton.dart';
import 'package:flutter/services.dart';

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
                      Text(productDetialinfo.story ?? ''),
                      Image.network(
                        productDetialinfo.images?[0] ??
                            'assets/images/Image_Logo.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 16),
                      Image.network(
                        productDetialinfo.images?[1] ??
                            'assets/images/Image_Logo.png',
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
  final platform = const MethodChannel('iOSChannel');
  final paymentsChannel = const MethodChannel('payments');

  ProductInfoSection({
    Key? key,
    required this.maxWidth,
    required this.productInfo,
  }) : super(key: key) {
    paymentsChannel.setMethodCallHandler((call) async {
      if (call.method == 'paymentSuccess') {
        final prime = call.arguments['prime'] as String;
        print(prime);
      }
    });
  }

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
            productInfo.mainImage ?? 'assets/images/Image_Logo.png',
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
                    productInfo.title ?? '',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    productInfo.description ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'NT\$${productInfo.price}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ColorPicker(colorData: productInfo.colors ?? []),
                  SizeSelector(
                    sizes: productInfo.sizes ?? [],
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
                      text: '請選擇尺寸',
                      onPressed: () {
                        try {
                          platform.invokeMethod('presentTapPayView');
                        } on PlatformException catch (e) {
                          print("Failed to open native page: '${e.message}'.");
                        }
                      }),
                  const SizedBox(height: 16),
                  Text(
                    productInfo.note ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    productInfo.texture ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    productInfo.wash ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    productInfo.place ?? '',
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
