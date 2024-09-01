import 'package:flutter/material.dart';
import 'package:moben/view/reading_view/reading_view_body.dart';

class ReadingView extends StatelessWidget {
  const ReadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: ReadingViewBody(),
    );
  }
}
