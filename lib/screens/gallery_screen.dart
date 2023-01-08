// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:upload_image/Helpers/jumping_ball/jumping_ball.dart';
import 'package:upload_image/Helpers/jumping_ball/jumping_position_bloc/jumping_position_bloc.dart';

import 'package:upload_image/styling/pallet.dart';

import '../widgets/app_header.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JumpingPositionBloc(),
      child: Scaffold(
        backgroundColor: Pallet.lightBk,
        appBar: appHeader,
        body: _content(context),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Stack(
      children: [
        _productsList(),
        _totalCart(),
        const JumpingBall(),
      ],
    );
  }

  Widget _totalCart() {
    return Align(
      alignment: Alignment.bottomRight,
      child: TotalCart(
        parentKey: _key,
      ),
    );
  }

  Container _productsList() {
    return Container(
      key: _key,
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                return ListItemCard(
                  product: allProducts[index],
                  parentKey: _key,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TotalCart extends StatefulWidget {
  const TotalCart({
    Key? key,
    required this.parentKey,
  }) : super(key: key);

  final GlobalKey parentKey;

  @override
  State<TotalCart> createState() => _TotalCartState();
}

class _TotalCartState extends State<TotalCart> {
  final GlobalKey _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getPosition(context));
    // _getPosition(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      margin: const EdgeInsets.only(bottom: 10, right: 32),
      // padding: const EdgeInsets.all(12),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.teal,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            // offset: const Offset(4, 4),
            blurRadius: 3,
          )
        ],
      ),
      alignment: Alignment.center,
      child: const Text(
        '0',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }

  _getPosition(BuildContext context) {
    RenderBox? child = _key.currentContext?.findRenderObject() as RenderBox?;
    Offset childOffset =
        child?.localToGlobal(Offset.zero) ?? const Offset(0, 0);
    RenderBox? parent =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox?;
    Offset childRelativeToParent =
        parent?.globalToLocal(childOffset) ?? const Offset(0, 0);
    context
        .read<JumpingPositionBloc>()
        .add(JumpingPositionSetTarget(position: childRelativeToParent));
  }
}

class ListItemCard extends StatefulWidget {
  const ListItemCard({
    Key? key,
    required this.product,
    required this.parentKey,
  }) : super(key: key);
  final Product product;
  final GlobalKey parentKey;
  @override
  State<ListItemCard> createState() => _ListItemCardState();
}

class _ListItemCardState extends State<ListItemCard> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.name),
                const SizedBox(height: 8),
                Text(
                  widget.product.body,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () => _onPressed(context),
            child: Container(
              key: _key,
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    // offset: const Offset(4, 4),
                    blurRadius: 3,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: const FaIcon(
                FontAwesomeIcons.cartPlus,
                color: Colors.white,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }

  _pressed(BuildContext context) {
    RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
    Offset boxPosition = box?.localToGlobal(Offset.zero) ?? const Offset(0, 0);
    final Offset position =
        Offset(boxPosition.dx + (box?.size.width ?? 0) / 2, boxPosition.dy);

    context
        .read<JumpingPositionBloc>()
        .add(JumpingPositionMoved(position: position));
  }

  _onPressed(BuildContext context) {
    RenderBox? child = _key.currentContext?.findRenderObject() as RenderBox?;
    Offset childOffset =
        child?.localToGlobal(Offset.zero) ?? const Offset(0, 0);
    RenderBox? parent =
        widget.parentKey.currentContext?.findRenderObject() as RenderBox?;
    Offset childRelativeToParent =
        parent?.globalToLocal(childOffset) ?? const Offset(0, 0);
    context
        .read<JumpingPositionBloc>()
        .add(JumpingPositionMoved(position: childRelativeToParent));
  }
}

class Product {
  final String name;
  final String body;
  final double price;

  Product({
    required this.name,
    required this.body,
    required this.price,
  });

  Product copyWith({
    String? name,
    String? body,
    double? price,
  }) {
    return Product(
      name: name ?? this.name,
      body: body ?? this.body,
      price: price ?? this.price,
    );
  }
}

final List<Product> allProducts = [
  Product(
    name: 'Item1',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item2',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item3',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item4',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item2',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item3',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item4',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item2',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item3',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
  Product(
    name: 'Item4',
    body: 'Item 1 body sdfsdf sdfsf sdfsdfs sdfsfsf',
    price: 120,
  ),
];
