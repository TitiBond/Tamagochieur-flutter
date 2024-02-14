import 'package:flutter/material.dart';
import 'package:tamagochieur/components/mood_icon.dart';
import 'package:tamagochieur/components/needs_tile.dart';
import 'package:tamagochieur/components/tips_tile.dart';

class TamagoDraggableScrollableSheet extends StatelessWidget {
  const TamagoDraggableScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double modalBorderRadius = 25;
    List<Color> modalBackgroundColors = [
      Colors.amber[100]!,
      Colors.amber[400]!,
      Colors.amber[700]!
    ];
    double modalPadding = 12;
    double modalTitleTextSize = 20;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      maxChildSize: 0.65,
      minChildSize: 0.20,
      builder: (context, ScrollController scrollController) {
        return Container(
            padding: EdgeInsets.all(modalPadding),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: modalBackgroundColors,
                    end: Alignment.bottomRight,
                    begin: Alignment.topLeft),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(modalBorderRadius),
                    topRight: Radius.circular(modalBorderRadius))),
            child: ListView(
              controller: scrollController,
              children: [
                //MODAL TITLE
                Text(
                  "ASTUCES",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: modalTitleTextSize),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TamagoTipsTile(type: NeedsType.drink),
                const SizedBox(
                  height: 30,
                ),
                const TamagoTipsTile(type: NeedsType.sleep),
                const SizedBox(
                  height: 30,
                ),
                const TamagoTipsTile(type: NeedsType.hug),
                const Divider(
                  color: Colors.black,
                  height: 30,
                  indent: 50,
                  endIndent: 50,
                ),
                Text("HUMEURS",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: modalTitleTextSize)),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Ton 'chieur' peut avoir différentes humeurs.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: MoodEnum.values
                      .map((val) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(color: Colors.black)),
                          child: TamagoMoodIcon(mood: val, size: 45)))
                      .toList(),
                )
              ],
            ));
      },
    );
  }
}
