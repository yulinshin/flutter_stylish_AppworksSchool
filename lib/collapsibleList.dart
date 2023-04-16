import 'package:flutter/material.dart';
import 'package:flutter_stylish/API/netWorking.dart';
import 'Model/prdouct.dart';
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
          child: FutureBuilder(
            future: getProducts(),
            builder: (BuildContext context, AsyncSnapshot<List<ProductInfo>> snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load hots'));
          } else {
            return Column(
              children: [
                ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCardGenerator(
                  model: snapshot.data![index]
                  );
            },
          )
              ],
            );
          }
            }
          )
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