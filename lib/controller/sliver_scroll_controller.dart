import 'package:first_flutter_challenge/data/data.dart';
import 'package:first_flutter_challenge/models/MyHeader.dart';
import 'package:first_flutter_challenge/models/product_category.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverScrollController {
  //list of products
  late List<ProducCategory> listCategory;

  //list offset values
  late List<double> listOffsetItemHeader = [];

  //header Notifier
  final headerNotifier = ValueNotifier<MyHeader?>(null);

//global offeset Value
  final globalOffsetValue = ValueNotifier<double>(0);

//indecator tif we are going down or up
  final goingDown = ValueNotifier<bool>(false);

  // value to do the validation of top icons
  final valueScroll = ValueNotifier<double>(0);

  //to mo top item inSliver
  late ScrollController scrollControllerItemHeader;

  //to have overall control of scrolling
  late ScrollController scrollControllerGlobally;

  void loadDataRandom() {
    final productsTwo = [...products];

    final productsThree = [...products];

    final productsfour = [...products];

    productsfour.shuffle();
    productsThree.shuffle();
    productsTwo.shuffle();

    listCategory = [
      ProducCategory(
        category: 'Order Again',
        products: products,
      ),
      ProducCategory(
        category: 'Picked For You',
        products: productsTwo,
      ),
      ProducCategory(
        category: 'Starters',
        products: productsThree,
      ),
      ProducCategory(
        category: 'Most Selling',
        products: productsfour,
      ),
    ];
  }

  void init() {
    loadDataRandom();
    listOffsetItemHeader =
        List.generate(listCategory.length, (index) => index.toDouble());
    scrollControllerGlobally = ScrollController();
    scrollControllerItemHeader = ScrollController();
    scrollControllerGlobally.addListener(() {
      _listenToscrollChange();
    });
  }

  _listenToscrollChange() {
    globalOffsetValue.value = scrollControllerGlobally.offset;
  }

  void dispose() {
    scrollControllerItemHeader.dispose();
    scrollControllerGlobally.dispose();
  }

  void scrollOnTap(int index) {
    print(scrollControllerGlobally.position.viewportDimension);
    final contentSize = scrollControllerGlobally.position.viewportDimension +
        scrollControllerGlobally.position.maxScrollExtent;
// Index to scroll to.
    print(scrollControllerGlobally.position.maxScrollExtent);

    print('contentSize $contentSize');
    //final index = 100;

// Estimate the target scroll position.
    final double target = 350 +
        (1210 * index) -
        math
            .pow(index, 2)
            .toDouble(); //350 is for image +100 for header data - 1210px noticing size is
    // static for sae list of food so its 1210 and substracting to keep scroll in bay
// Scroll to that position.
    //2842
    print('position ttt $target');

    scrollControllerGlobally.position.animateTo(
      target,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  void refreshHeader(int index, bool visible, int? lastIndex) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.index ?? index;
    final headerVisible = headerValue?.visible ?? false;
    //  print('refreshing $headerTitle ${headerValue?.index} $headerVisible');
    if (headerTitle != index || lastIndex != null || headerVisible) {
      Future.microtask(() {
        if (!visible && lastIndex != null) {
          headerNotifier.value = MyHeader(index: lastIndex, visible: true);
        } else {
          headerNotifier.value = MyHeader(index: index, visible: visible);
        }
      });
    }
  }
}
