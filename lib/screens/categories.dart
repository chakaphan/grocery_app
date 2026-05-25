import 'package:flutter/material.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/categories_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  List<Color> gridColor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.brown,
  ];
  List<Map<String, dynamic>> catInfo = [
    {'imgPath': 'assets/images/cat/fruits.png', 'catText': 'Fruits'},
    {'imgPath': 'assets/images/cat/veg.png', 'catText': 'Vegetables'},
    {'imgPath': 'assets/images/cat/herbs.png', 'catText': 'Herbs'},
    {'imgPath': 'assets/images/cat/nuts.png', 'catText': 'Nuts'},
    {'imgPath': 'assets/images/cat/spices.png', 'catText': 'Spices'},
    {'imgPath': 'assets/images/cat/grains.png', 'catText': 'Grains'},
  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Categories",
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8),
          childAspectRatio: 240 / 250,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(6, (index) {
            return CategoriesWidget(
              catText: catInfo[index]['catText'],
              imgPath: catInfo[index]['imgPath'],
              passedColor: gridColor[index],
            );
          }),
        ),
      ),
    );
  }
}
