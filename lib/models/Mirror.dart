
import 'package:lightlink/models/cell.dart';

abstract class Mirror extends Cell{

   int reflection;
  Mirror({required super.x, required super.y,required this.reflection});
}
