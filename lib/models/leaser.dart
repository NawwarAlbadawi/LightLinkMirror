
class Leaser {
   int? x;
   int? y;
   Direction ?currentDirection;

  Leaser({ required this.x, required this.y});

 Leaser.fromJson(dynamic json) {
   x=json['x'];
   y=json['y'];
   currentDirection=Direction.values.firstWhere(
         (e)=>e.toString()=='Direction.'+json['direction'],
   );
 }



}

enum Direction {
  up,
  down,
  left,
  right

}


//
// import 'package:lightlink/models/cell.dart';
//
// class Laser extends Cell {
//
//   Direction ?currentDirection;
//   Laser({required super.x, required super.y,required this.currentDirection});
// // Laser.fromJson(dynamic json) {
// //
// //  super. x=json['x'];
// //  super.y=json['y'];
// //  currentDirection=Direction.values.firstWhere(
// //         (e)=>e.toString()=='Direction.'+json['direction'],
// //   );
// // }
//
//
//
// }
//
// enum Direction {
//   up,
//   down,
//   left,
//   right
//
// }



