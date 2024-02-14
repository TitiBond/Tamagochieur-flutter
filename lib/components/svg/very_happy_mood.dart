import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TamagoVeryHappyMoodSvg extends StatelessWidget {
  String fill;
  TamagoVeryHappyMoodSvg({super.key, this.fill = '#fff'});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
        '<svg viewBox="0 -960 960 960" fill="$fill"><path d="M480-260q68 0 123.5-38.5T684-400H276q25 63 80.5 101.5T480-260ZM312-520l44-42 42 42 42-42-84-86-86 86 42 42Zm250 0 42-42 44 42 42-42-86-86-84 86 42 42ZM480-80q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-400Zm0 320q134 0 227-93t93-227q0-134-93-227t-227-93q-134 0-227 93t-93 227q0 134 93 227t227 93Z"/></svg>');
  }
}
