

import 'package:lightlink/models/Mirror.dart';

class FramingMirror extends Mirror  {
 final int maxX;
  final  int minX;
  final int maxY;
  final int minY;
  FramingMirror({required this.maxX, required this.minX,required this.maxY,required this.minY, required super.x, required super.y, required super.reflection});
}