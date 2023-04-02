import 'package:flutter/material.dart';

const _initialPage = 8.0;

class CoffeeBloc {
  final pageCoffeeController = PageController(
    viewportFraction: .35,
    initialPage: _initialPage.toInt(),
  );

  final pageTextController = PageController(initialPage: _initialPage.toInt());
  final currentPage = ValueNotifier<double>(_initialPage);
  final textPage = ValueNotifier<double>(_initialPage);

  void init() {
    pageCoffeeController.addListener(_coffeeScroll);
    pageTextController.addListener(_textScroll);
  }

  void _coffeeScroll() {
    currentPage.value = pageCoffeeController.page!;
  }

  void _textScroll() {
    textPage.value = pageTextController.page!;
  }

  void dispose() {
    pageCoffeeController.removeListener(_coffeeScroll);
    pageTextController.removeListener(_textScroll);
    pageCoffeeController.dispose();
    pageTextController.dispose();
  }
}

class CoffeeProvider extends InheritedWidget {
  final CoffeeBloc bloc;

  const CoffeeProvider({required this.bloc, required Widget child})
      : super(child: child);

  static CoffeeProvider? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CoffeeProvider>();
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
