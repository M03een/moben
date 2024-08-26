import 'package:flutter/material.dart';
import 'package:moben/view/counter_view/widgets/counter_view_body.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CounterViewBody(),
    );
  }
}
