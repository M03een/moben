import 'package:flutter/material.dart';
import 'package:moben/view/account_and_rank_view/widgets/ranked_item.dart';

class RankedItemsList extends StatelessWidget {
  const RankedItemsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return RankedItem(
            isFirst: index == 0,
          );
        },
      ),
    );
  }
}
