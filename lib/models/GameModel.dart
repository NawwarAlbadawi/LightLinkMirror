import 'package:flutter/cupertino.dart';
import 'package:lightlink/models/leaser.dart';

import 'cell.dart';

/// Game : {"width":8,"height":7,"Grid":[[{"x":0,"y":0,"type":"empty"},{"x":0,"y":1,"type":"empty"},{"x":0,"y":2,"type":"fixedMirror45"},{"x":0,"y":3,"type":"empty"},{"x":0,"y":4,"type":"empty"},{"x":0,"y":5,"type":"constantMirror"},{"x":0,"y":6,"type":"empty"},{"x":0,"y":7,"type":"laserGenerator"}],[{"x":1,"y":0,"type":"empty"},{"x":1,"y":1,"type":"framingMirror"},{"x":1,"y":2,"type":"empty"},{"x":1,"y":3,"type":"empty"},{"x":1,"y":4,"type":"empty"},{"x":1,"y":5,"type":"empty"},{"x":1,"y":6,"type":"framingMirror"},{"x":1,"y":7,"type":"empty"}],[{"x":2,"y":0,"type":"fixedMirror45"},{"x":2,"y":1,"type":"empty"},{"x":2,"y":2,"type":"empty"},{"x":2,"y":3,"type":"empty"},{"x":2,"y":4,"type":"empty"},{"x":2,"y":5,"type":"empty"},{"x":2,"y":6,"type":"empty"},{"x":2,"y":7,"type":"fixedMirror45"}],[{"x":3,"y":0,"type":"empty"},{"x":3,"y":1,"type":"empty"},{"x":3,"y":2,"type":"empty"},{"x":3,"y":3,"type":"empty"},{"x":3,"y":4,"type":"empty"},{"x":3,"y":5,"type":"empty"},{"x":3,"y":6,"type":"empty"},{"x":3,"y":7,"type":"empty"}],[{"x":4,"y":0,"type":"empty"},{"x":4,"y":1,"type":"empty"},{"x":4,"y":2,"type":"empty"},{"x":4,"y":3,"type":"empty"},{"x":4,"y":4,"type":"empty"},{"x":4,"y":5,"type":"empty"},{"x":4,"y":6,"type":"empty"},{"x":4,"y":7,"type":"empty"}],[{"x":6,"y":0,"type":"empty"},{"x":6,"y":1,"type":"framingMirror"},{"x":6,"y":2,"type":"empty"},{"x":6,"y":3,"type":"empty"},{"x":6,"y":4,"type":"empty"},{"x":6,"y":5,"type":"empty"},{"x":6,"y":6,"type":"framingMirror"},{"x":6,"y":7,"type":"empty"}],[{"x":7,"y":0,"type":"empty"},{"x":7,"y":1,"type":"empty"},{"x":7,"y":2,"type":"constantMirror"},{"x":7,"y":3,"type":"empty"},{"x":7,"y":4,"type":"empty"},{"x":7,"y":5,"type":"fixedMirror45"},{"x":7,"y":6,"type":"empty"},{"x":7,"y":7,"type":"empty"}]]}

class GameModel {
  GameModel({
      this.game,});

  GameModel.fromJson(dynamic json) {
    game = json['Game'] != null ? Game.fromJson(json['Game']) : null;
  }
  Game? game;
GameModel copyWith({  Game? game,
}) => GameModel(  game: game ?? this.game,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (game != null) {
      map['Game'] = game?.toJson();
    }
    return map;
  }

}

/// width : 8
/// height : 7
/// Grid : [[{"x":0,"y":0,"type":"empty"},{"x":0,"y":1,"type":"empty"},{"x":0,"y":2,"type":"fixedMirror45"},{"x":0,"y":3,"type":"empty"},{"x":0,"y":4,"type":"empty"},{"x":0,"y":5,"type":"constantMirror"},{"x":0,"y":6,"type":"empty"},{"x":0,"y":7,"type":"laserGenerator"}],[{"x":1,"y":0,"type":"empty"},{"x":1,"y":1,"type":"framingMirror"},{"x":1,"y":2,"type":"empty"},{"x":1,"y":3,"type":"empty"},{"x":1,"y":4,"type":"empty"},{"x":1,"y":5,"type":"empty"},{"x":1,"y":6,"type":"framingMirror"},{"x":1,"y":7,"type":"empty"}],[{"x":2,"y":0,"type":"fixedMirror45"},{"x":2,"y":1,"type":"empty"},{"x":2,"y":2,"type":"empty"},{"x":2,"y":3,"type":"empty"},{"x":2,"y":4,"type":"empty"},{"x":2,"y":5,"type":"empty"},{"x":2,"y":6,"type":"empty"},{"x":2,"y":7,"type":"fixedMirror45"}],[{"x":3,"y":0,"type":"empty"},{"x":3,"y":1,"type":"empty"},{"x":3,"y":2,"type":"empty"},{"x":3,"y":3,"type":"empty"},{"x":3,"y":4,"type":"empty"},{"x":3,"y":5,"type":"empty"},{"x":3,"y":6,"type":"empty"},{"x":3,"y":7,"type":"empty"}],[{"x":4,"y":0,"type":"empty"},{"x":4,"y":1,"type":"empty"},{"x":4,"y":2,"type":"empty"},{"x":4,"y":3,"type":"empty"},{"x":4,"y":4,"type":"empty"},{"x":4,"y":5,"type":"empty"},{"x":4,"y":6,"type":"empty"},{"x":4,"y":7,"type":"empty"}],[{"x":6,"y":0,"type":"empty"},{"x":6,"y":1,"type":"framingMirror"},{"x":6,"y":2,"type":"empty"},{"x":6,"y":3,"type":"empty"},{"x":6,"y":4,"type":"empty"},{"x":6,"y":5,"type":"empty"},{"x":6,"y":6,"type":"framingMirror"},{"x":6,"y":7,"type":"empty"}],[{"x":7,"y":0,"type":"empty"},{"x":7,"y":1,"type":"empty"},{"x":7,"y":2,"type":"constantMirror"},{"x":7,"y":3,"type":"empty"},{"x":7,"y":4,"type":"empty"},{"x":7,"y":5,"type":"fixedMirror45"},{"x":7,"y":6,"type":"empty"},{"x":7,"y":7,"type":"empty"}]]

class Game {
  Game({
      this.width,
      this.height,
      this.grid,
      this.leaser
  });

  Game.fromJson(dynamic json) {
    //print(json['laser']);
    width = json['width'];
    height = json['height'];
    if (json['Grid'] != null) {
      grid = [];


      json['Grid'].forEach((v){
        List<Cell>cells=[];
        v.forEach((i){

          cells.add( Cell.fromJson(i));

        });
        grid!.add(cells);
      });

    }
    if(json['laser']!=null){

    json['laser'].forEach((v){



      leaser!.add(Leaser.fromJson(v));

    });
  }
  }
  int? width;
  int? height;
  List<List<Cell>>? grid;
  List<Leaser>?leaser=[];
Game copyWith({  int? width,
  int? height,
  List<List<Cell>>? grid,
}) => Game(  width: width ?? this.width,
  height: height ?? this.height,
  grid: grid ?? this.grid,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    if (grid != null) {
     // map['Grid'] = grid?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// x : 0
/// y : 0
/// type : "empty"


// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:lightlink/models/leaser.dart';
//
// import 'cell.dart';
// import 'constantMirror.dart';
// import 'empty.dart';
// import 'fixedMirror45.dart';
// import 'goal.dart';
//
// /// Game : {"width":8,"height":7,"Grid":[[{"x":0,"y":0,"type":"empty"},{"x":0,"y":1,"type":"empty"},{"x":0,"y":2,"type":"fixedMirror45"},{"x":0,"y":3,"type":"empty"},{"x":0,"y":4,"type":"empty"},{"x":0,"y":5,"type":"constantMirror"},{"x":0,"y":6,"type":"empty"},{"x":0,"y":7,"type":"laserGenerator"}],[{"x":1,"y":0,"type":"empty"},{"x":1,"y":1,"type":"framingMirror"},{"x":1,"y":2,"type":"empty"},{"x":1,"y":3,"type":"empty"},{"x":1,"y":4,"type":"empty"},{"x":1,"y":5,"type":"empty"},{"x":1,"y":6,"type":"framingMirror"},{"x":1,"y":7,"type":"empty"}],[{"x":2,"y":0,"type":"fixedMirror45"},{"x":2,"y":1,"type":"empty"},{"x":2,"y":2,"type":"empty"},{"x":2,"y":3,"type":"empty"},{"x":2,"y":4,"type":"empty"},{"x":2,"y":5,"type":"empty"},{"x":2,"y":6,"type":"empty"},{"x":2,"y":7,"type":"fixedMirror45"}],[{"x":3,"y":0,"type":"empty"},{"x":3,"y":1,"type":"empty"},{"x":3,"y":2,"type":"empty"},{"x":3,"y":3,"type":"empty"},{"x":3,"y":4,"type":"empty"},{"x":3,"y":5,"type":"empty"},{"x":3,"y":6,"type":"empty"},{"x":3,"y":7,"type":"empty"}],[{"x":4,"y":0,"type":"empty"},{"x":4,"y":1,"type":"empty"},{"x":4,"y":2,"type":"empty"},{"x":4,"y":3,"type":"empty"},{"x":4,"y":4,"type":"empty"},{"x":4,"y":5,"type":"empty"},{"x":4,"y":6,"type":"empty"},{"x":4,"y":7,"type":"empty"}],[{"x":6,"y":0,"type":"empty"},{"x":6,"y":1,"type":"framingMirror"},{"x":6,"y":2,"type":"empty"},{"x":6,"y":3,"type":"empty"},{"x":6,"y":4,"type":"empty"},{"x":6,"y":5,"type":"empty"},{"x":6,"y":6,"type":"framingMirror"},{"x":6,"y":7,"type":"empty"}],[{"x":7,"y":0,"type":"empty"},{"x":7,"y":1,"type":"empty"},{"x":7,"y":2,"type":"constantMirror"},{"x":7,"y":3,"type":"empty"},{"x":7,"y":4,"type":"empty"},{"x":7,"y":5,"type":"fixedMirror45"},{"x":7,"y":6,"type":"empty"},{"x":7,"y":7,"type":"empty"}]]}
//
// class GameModel {
//   GameModel({
//     this.game,});
//
//   GameModel.fromJson(dynamic json) {
//     game = json['Game'] != null ? Game.fromJson(json['Game']) : null;
//   }
//   Game? game;
//   GameModel copyWith({  Game? game,
//   }) => GameModel(  game: game ?? this.game,
//   );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (game != null) {
//       map['Game'] = game?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// width : 8
// /// height : 7
// /// Grid : [[{"x":0,"y":0,"type":"empty"},{"x":0,"y":1,"type":"empty"},{"x":0,"y":2,"type":"fixedMirror45"},{"x":0,"y":3,"type":"empty"},{"x":0,"y":4,"type":"empty"},{"x":0,"y":5,"type":"constantMirror"},{"x":0,"y":6,"type":"empty"},{"x":0,"y":7,"type":"laserGenerator"}],[{"x":1,"y":0,"type":"empty"},{"x":1,"y":1,"type":"framingMirror"},{"x":1,"y":2,"type":"empty"},{"x":1,"y":3,"type":"empty"},{"x":1,"y":4,"type":"empty"},{"x":1,"y":5,"type":"empty"},{"x":1,"y":6,"type":"framingMirror"},{"x":1,"y":7,"type":"empty"}],[{"x":2,"y":0,"type":"fixedMirror45"},{"x":2,"y":1,"type":"empty"},{"x":2,"y":2,"type":"empty"},{"x":2,"y":3,"type":"empty"},{"x":2,"y":4,"type":"empty"},{"x":2,"y":5,"type":"empty"},{"x":2,"y":6,"type":"empty"},{"x":2,"y":7,"type":"fixedMirror45"}],[{"x":3,"y":0,"type":"empty"},{"x":3,"y":1,"type":"empty"},{"x":3,"y":2,"type":"empty"},{"x":3,"y":3,"type":"empty"},{"x":3,"y":4,"type":"empty"},{"x":3,"y":5,"type":"empty"},{"x":3,"y":6,"type":"empty"},{"x":3,"y":7,"type":"empty"}],[{"x":4,"y":0,"type":"empty"},{"x":4,"y":1,"type":"empty"},{"x":4,"y":2,"type":"empty"},{"x":4,"y":3,"type":"empty"},{"x":4,"y":4,"type":"empty"},{"x":4,"y":5,"type":"empty"},{"x":4,"y":6,"type":"empty"},{"x":4,"y":7,"type":"empty"}],[{"x":6,"y":0,"type":"empty"},{"x":6,"y":1,"type":"framingMirror"},{"x":6,"y":2,"type":"empty"},{"x":6,"y":3,"type":"empty"},{"x":6,"y":4,"type":"empty"},{"x":6,"y":5,"type":"empty"},{"x":6,"y":6,"type":"framingMirror"},{"x":6,"y":7,"type":"empty"}],[{"x":7,"y":0,"type":"empty"},{"x":7,"y":1,"type":"empty"},{"x":7,"y":2,"type":"constantMirror"},{"x":7,"y":3,"type":"empty"},{"x":7,"y":4,"type":"empty"},{"x":7,"y":5,"type":"fixedMirror45"},{"x":7,"y":6,"type":"empty"},{"x":7,"y":7,"type":"empty"}]]
//
// class Game {
//   Game({
//     this.width,
//     this.height,
//     this.grid,
//
//   });
//
//   Game.fromJson(dynamic json) {
//     //print(json['laser']);
//     width = json['width'];
//     height = json['height'];
//     if (json['Grid'] != null) {
//
//       grid = [];
//
//
//       List<List<dynamic>> gridData = json['Grid'];
//
// // Create the grid
//
//       for (var rowData in gridData) {
//         List<Cell> row = [];
//         for (var cellData in rowData) {
//           String type = cellData['type'];
//           int x = cellData['x'];
//           int y = cellData['y'];
//
//           switch (type) {
//             case 'Empty':
//               row.add(Empty(x: x, y: y));
//               break;
//             case 'FixedMirror45':
//               row.add(FixedMirror45(x: x, y: y, reflection: cellData['reflection']));
//               break;
//             case 'Laser':
//               row.add(Laser(x: x, y: y, currentDirection: Direction.values.byName(cellData['direction'])));
//               break;
//             case 'Goal':
//               row.add(Goal(x: x, y: y));
//               break;
//             case 'ConstantMirror':
//               row.add(ConstantMirror(x: x, y: y, reflection: cellData['reflection']));
//               break;
//             case 'FramingMirror':
//             //row.add(FramingMirror(x: x, y: y, reflection: cellData['reflection']));
//               break;
//             default:
//             // Handle unknown cell types (optional)
//               print('Unknown cell type: $type');
//           }
//         }
//         grid!.add(row);
//       }
//
//     }
//
//     printGrid(grid!);
//
//   }
//   int? width;
//   int? height;
//   List<List<Cell>>? grid;
//
//   Game copyWith({  int? width,
//     int? height,
//     List<List<Cell>>? grid,
//   }) => Game(  width: width ?? this.width,
//     height: height ?? this.height,
//     grid: grid ?? this.grid,
//   );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['width'] = width;
//     map['height'] = height;
//     if (grid != null) {
//       // map['Grid'] = grid?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// class FramingMirror {
// }
//
// void printGrid(List<List<Cell>> grid) {
//   for (var row in grid) {
//     for (var cell in row) {
//       String cellRepresentation = getCellRepresentation(cell);
//       stdout.write(cellRepresentation + ' '); // Print cell representation with space
//     }
//     stdout.writeln(); // Print newline for next row
//   }
// }
//
// String getCellRepresentation(Cell cell) {
//   if (cell is Empty) {
//     return '.'; // Representation for Empty cell
//   } else if (cell is FixedMirror45) {
//     return '/'; // Representation for FixedMirror45 cell
//   } else if (cell is Laser) {
//     return 'L'; // Representation for Laser cell
//   } else if (cell is Goal) {
//     return 'G'; // Representation for Goal cell
//   } else if (cell is ConstantMirror) {
//     return 'C'; // Representation for ConstantMirror cell
//   } else if (cell is FramingMirror) {
//     return 'F'; // Representation for FramingMirror cell
//   } else {
//     return '?'; // Representation for unknown cell type
//   }
// }
//
// /// x : 0
// /// y : 0
// /// type : "empty"
//
