import 'package:crowd_funding_app/widgets/manage_card.dart';
import 'package:flutter/material.dart';

class Manage extends StatelessWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Scrollbar(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return ManageCard(image: "image1.png");
            }),
      ),
    );
  }
}
