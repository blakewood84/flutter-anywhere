import 'package:flutter/material.dart' show MediaQueryData, Orientation;

extension IsTablet on MediaQueryData {
  bool get isTablet => size.shortestSide > 600;
}

extension IsPortrait on MediaQueryData {
  bool get isPortrait => orientation == Orientation.portrait;
}
