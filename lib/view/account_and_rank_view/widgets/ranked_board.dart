import 'package:flutter/material.dart';
import 'package:moben/view/account_and_rank_view/widgets/ranked_base_container.dart';
import 'first_ranked_widget.dart';

class RankedBoard extends StatelessWidget {
  const RankedBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.bottomCenter,
      children: [
        RankedBaseContainer(),
        FirstRankedWidget(),
      ],
    );
  }
}