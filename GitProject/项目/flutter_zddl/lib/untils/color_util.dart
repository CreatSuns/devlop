import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorUtil {
  static Color getColor(String bg) {
    if (bg.contains("#")) {
      if (bg.length == 4) {
        String n_bg = "#" +
            bg.substring(1, 2) +
            bg.substring(1, 2) +
            bg.substring(2, 3) +
            bg.substring(2, 3) +
            bg.substring(3, 4) +
            bg.substring(3, 4);
        return fromHex(n_bg);
      } else {
        return fromHex(bg);
      }
    } else if (bg.contains("rgba")) {
      List<String> n_bg = bg.split("(")[1].split(")")[0].split(", ");
      return Color.fromARGB(((double.parse(n_bg[3])) * 255).toInt(),
          int.parse(n_bg[0]), int.parse(n_bg[1]), int.parse(n_bg[2]));
    } else if (bg.contains("rgb")) {
      List<String> n_bg = bg.split("(")[1].split(")")[0].split(", ");
      return Color.fromARGB(
          255, int.parse(n_bg[0]), int.parse(n_bg[1]), int.parse(n_bg[2]));
    } else {
      return Colors.white;
    }
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
