import 'package:flutter/material.dart';
import 'prdouctModel.dart';

class ProductCardGenerator extends StatelessWidget {
  const ProductCardGenerator({
    required this.model,
  });
  final ProductInfo model;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Image.network(
            model.productPicUrl,
            height: 100,
            width: 80,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    model.productName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'NT\$ ${model.productPrice}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
