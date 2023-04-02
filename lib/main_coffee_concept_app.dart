import 'package:coffee/app/bloc/coffee_bloc.dart';
import 'package:coffee/app/view/coffee_concept_home_screen.dart';
import 'package:flutter/material.dart';

class MainCoffeeConcept extends StatefulWidget {
  const MainCoffeeConcept({super.key});

  @override
  State<MainCoffeeConcept> createState() => _MainCoffeeConceptState();
}

class _MainCoffeeConceptState extends State<MainCoffeeConcept> {
  final bloc = CoffeeBloc();

  @override
  void initState() {
    bloc.init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: CoffeeProvider(
        bloc: bloc,
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: CoffeeConceptHomeScreen(),
        ),
      ),
    );
  }
}
