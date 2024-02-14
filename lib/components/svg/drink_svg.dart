import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TamagoDrinkSvg extends StatelessWidget {
  String fill;
  TamagoDrinkSvg({super.key, this.fill = '#fff'});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
        '<svg viewBox="0 -960 960 960" fill="$fill" ><path d="M491-200q12-1 20.5-9.5T520-230q0-14-9-22.5t-23-7.5q-41 3-87-22.5T343-375q-2-11-10.5-18t-19.5-7q-14 0-23 10.5t-6 24.5q17 91 80 130t127 35ZM480-80q-137 0-228.5-94T160-408q0-100 79.5-217.5T480-880q161 137 240.5 254.5T800-408q0 140-91.5 234T480-80Zm0-80q104 0 172-70.5T720-408q0-73-60.5-165T480-774Q361-665 300.5-573T240-408q0 107 68 177.5T480-160Zm0-320Z"/></svg>');
  }
}
