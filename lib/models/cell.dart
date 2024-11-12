class  Cell {

   int? x;
   int? y;
  CellType ?type;
  int   ?reflection;
  Cell.fromJson(dynamic json) {
    x = json['x'];
    y = json['y'];
    type = CellType.values.firstWhere(
        (e)=>e.toString()=='CellType.'+json['type'],
    );
   if( json['reflection']!=null)
     {
       reflection=json['reflection'];
     }
   else
     {
       reflection=0;
     }
  }
   Cell copyWith({
     int? x,
     int? y,
     int? reflection,
     CellType? type,
   }) {
     return Cell(
       x: x ?? this.x,
       y: y ?? this.y,
       reflection: reflection ?? this.reflection,
       type: type ?? this.type,
     );}


  Cell({required this.x, required this.y, required this.type,required this.reflection});


}
enum CellType {

  fixedMirror45,
  constantMirror,
  framingMirror,
  wall,
  empty,
  laserGenerator,
  laser,
  goal

}


// abstract class  Cell {
//
//    int x;
//    int y;
//
//
//    Cell({required this.x, required this.y});
//
// }

