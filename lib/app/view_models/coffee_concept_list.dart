import 'package:coffee/app/bloc/coffee_bloc.dart';
import 'package:coffee/app/model/coffee.dart';
import 'package:coffee/app/view/coffee_concept_details_screen.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);

class CoffeeConceptList extends StatefulWidget {
  const CoffeeConceptList({super.key});

  @override
  State<CoffeeConceptList> createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = CoffeeProvider.of(context)!.bloc;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            top: size.height * .75,
            height: size.height * .3,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    offset: Offset.zero,
                    spreadRadius: 45,
                  )
                ],
              ),
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: bloc.currentPage,
            builder: (context, currentPage, _) {
              return Transform.scale(
                scale: 1.6,
                alignment: Alignment.bottomCenter,
                child: PageView.builder(
                  controller: bloc.pageCoffeeController,
                  scrollDirection: Axis.vertical,
                  itemCount: coffees.length + 1,
                  onPageChanged: (value) {
                    if (value < coffees.length) {
                      bloc.pageTextController.animateToPage(
                        value,
                        duration: _duration,
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  itemBuilder: (builder, index) {
                    if (index == 0) {
                      return const SizedBox.shrink();
                    }
                    final coffee = coffees[index - 1];
                    final result = currentPage - index + 1;
                    final value = -0.4 * result + 1;
                    final opacity = value.clamp(0.0, 1.0);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 650),
                            pageBuilder: (context, animation, _) {
                              return FadeTransition(
                                opacity: animation,
                                child:
                                    CoffeeConceptDetailsScreen(coffee: coffee),
                              );
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                              0.0,
                              size.height / 2.6 * (1 - value).abs(),
                            )
                            ..scale(value),
                          child: Opacity(
                            opacity: opacity,
                            child: Hero(
                              tag: coffee.name,
                              child: Image.asset(
                                coffee.image,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 100,
            child: _CoffeeHeader(size: size),
          ),
        ],
      ),
    );
  }
}

class _CoffeeHeader extends StatelessWidget {
  const _CoffeeHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final bloc = CoffeeProvider.of(context)!.bloc;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: .0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, -100 * value),
          child: child,
        );
      },
      duration: _duration,
      child: ValueListenableBuilder<double>(
          valueListenable: bloc.textPage,
          builder: (context, textPage, _) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: coffees.length,
                    controller: bloc.pageTextController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final opacity =
                          (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                      return Opacity(
                        opacity: opacity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * .2,
                          ),
                          child: Hero(
                            tag: "text_${coffees[index].name}",
                            child: Material(
                              child: Text(
                                coffees[index].name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                AnimatedSwitcher(
                  duration: _duration,
                  child: Text(
                    'R\$ ${coffees[textPage.toInt()].price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                    key: Key(coffees[textPage.toInt()].name),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
