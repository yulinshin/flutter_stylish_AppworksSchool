import 'package:flutter/material.dart';
import 'prdouctModel.dart';
import 'productCardGenerator.dart';

class CollapsibleHeaderList extends StatefulWidget {
  final List<ProductCategory> data;

  const CollapsibleHeaderList({Key? key, required this.data}) : super(key: key);

  @override
  _CollapsibleHeaderListState createState() => _CollapsibleHeaderListState();
}

class _CollapsibleHeaderListState extends State<CollapsibleHeaderList> {
  late final Map<String, bool> _collapsedMap;

  @override
  void initState() {
    super.initState();
    _collapsedMap = Map<String, bool>.fromIterable(widget.data,
        key: (e) => e.title, value: (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (BuildContext context, int sectionIndex) {
        final String sectionTitle = widget.data[sectionIndex].title;
        final bool isCollapsed = _collapsedMap[sectionTitle]!;
        return CollapsibleHeader(
          title: sectionTitle,
          isCollapsed: isCollapsed,
          onHeaderTapped: () {
            setState(() {
              _collapsedMap[sectionTitle] = !isCollapsed;
            });
          },
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.data[sectionIndex].products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCardGenerator(
                  model: widget.data[sectionIndex].products[index]);
            },
          ),
        );
      },
    );
  }
}

class CollapsibleHeader extends StatelessWidget {
  const CollapsibleHeader({
    Key? key,
    required this.title,
    required this.isCollapsed,
    required this.onHeaderTapped,
    required this.child,
  }) : super(key: key);

  final String title;
  final bool isCollapsed;
  final Function() onHeaderTapped;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkWell(
          onTap: onHeaderTapped,
          child: Container(
            height: 48,
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  isCollapsed ? Icons.expand_more : Icons.expand_less,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: isCollapsed ? 0 : null,
          child: child,
        ),
      ],
    );
  }
}
