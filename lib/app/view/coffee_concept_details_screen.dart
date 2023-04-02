import 'package:coffee/app/model/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeConceptDetailsScreen extends StatefulWidget {
  final Coffee coffee;

  const CoffeeConceptDetailsScreen({
    super.key,
    required this.coffee,
  });

  @override
  State<CoffeeConceptDetailsScreen> createState() =>
      _CoffeeConceptDetailsScreenState();
}

class _CoffeeConceptDetailsScreenState
    extends State<CoffeeConceptDetailsScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 11, top: 10),
                  child: Text(
                    count <= 0 ? '' : count.toString(),
                    style: TextStyle(
                      color: Colors.brown.shade600,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(
                  Icons.shopping_bag_outlined,
                  color: count <= 0
                      ? Colors.brown.shade600
                      : Colors.brown.shade300,
                  size: 30,
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .2),
            child: Hero(
              tag: "text_${widget.coffee.name}",
              child: Material(
                color: Colors.white,
                child: Text(
                  widget.coffee.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: size.height * .4,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: widget.coffee.name,
                    child: Image.asset(
                      widget.coffee.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              // left: size.width * .30,
              top: size.height * .15,
            ),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(-100 * value, 240 * value),
                  child: child,
                );
              },
              duration: const Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () => setState(() => count--),
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'R\$ ${widget.coffee.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 10,
                              spreadRadius: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () => setState(() => count++),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
