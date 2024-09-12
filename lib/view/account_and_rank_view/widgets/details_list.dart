import 'package:flutter/cupertino.dart';
import 'details__item.dart';

class DetailsList extends StatelessWidget {
  const DetailsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return const DetailsItem();
        },
      ),
    );
  }
}
