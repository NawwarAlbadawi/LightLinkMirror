import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lightlink/models/GameModel.dart';
import 'package:lightlink/models/empty.dart';
import 'package:meta/meta.dart';

import '../../models/cell.dart';
import '../../models/leaser.dart';
import '../../models/wall.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this.gameModel) : super(GameInitial());
  late List<List<Cell>> grid=[];
  late List<Map<String,dynamic>> laserPath;
  final  GameModel gameModel;
   static  GameCubit get (context)=>BlocProvider.of(context);
   initValue()
   {
 grid=gameModel.game!.grid!.map((row)=>row.map((cell)=>cell.copyWith()).toList()).toList();
    calculateLaserPath(gameModel.game!.leaser![0].x!,gameModel.game!.leaser![0].x!,gameModel.game!.leaser![0].currentDirection!,grid);
     for (Map<String, dynamic> point in laserPath) {
       int x = point['x'] as int;
       int y = point['y'] as int;
       grid[x][y]=Cell(x: x, y: y, type: CellType.laser, reflection: 0);

     }
     emit(PressOnMirrorState());

   }
  void calculateLaserPath(int x,int y ,Direction direction , List<List<Cell>> grid){

     laserPath=[];

    int currentX=x;
    int currentY=y;
    while (currentX<7&& currentX>=0&& currentY<=7&& currentY>=0)
    {

      if(grid[currentX][currentY].type==CellType.empty)
      {

        laserPath.add({'x':currentX,'y':currentY});
        if (direction case Direction.up) {

          currentX--;

        }
        else if (direction == Direction.down) {
          currentX++;
        } else if (direction == Direction.left) {
          currentY--;
        } else if (direction == Direction.right) {
          currentY++;

        }
      }
      else if(grid[currentX][currentY].type ==CellType.wall||grid[currentX][currentY].type ==CellType.framingMirror)
      {
        currentX=-1;

      }
      else if(grid[currentX][currentY].type==CellType.fixedMirror45||grid[currentX][currentY].type==CellType.constantMirror)
      {

        if (direction == Direction.up) {
          if(grid[currentX][currentY].reflection==135)
          {
            currentY--;
            direction=Direction.left;
          }
          else if(grid[currentX][currentY].reflection==45)
          {
            currentY++;
            direction=Direction.right;
          }
          else {
            break;
          }

        }
        else if (direction == Direction.down) {


          if (grid[currentX][currentY].reflection==45){

            currentY--;

            direction=Direction.left;
          }
          else if (grid[currentX][currentY].reflection==315)
          {
            currentY++;
            direction=Direction.right;
          }

          else
          {
           currentY=-1;

          }


        }
        else if (direction == Direction.right) {

          if(grid[currentX][currentY].reflection==45)
          {
            currentX--;
            direction=Direction.up;
          }
          else if(grid[currentX][currentY].reflection==90)
          {
            currentY--;
            direction=Direction.left;
          }
          else if(grid[currentX][currentY].reflection==135)
          {
            currentX++;
            direction=Direction.down;
          }
          else {
            break;
          }

        }
        else if (direction == Direction.left) {
          if(grid[currentX][currentY].reflection==45)
          {
            currentX++;
            direction=Direction.down;
          }
          else if (grid[currentX][currentY].reflection==315) {
            currentX--;
            direction=Direction.up;
          }
          else
            currentY=-1;

        }


        if(currentX<7&& currentX>=0&& currentY<=7&& currentY>=0&&grid[currentX][currentY].type==CellType.empty) {

          laserPath.add({'x':currentX,'y':currentY});


        }

      }
      else if(grid[currentX][currentY].type==CellType.laser) {
        break;
      }
      else if(grid[currentX][currentY].type==CellType.laserGenerator)
        {
          if(direction==Direction.left)
            {

              currentY--;
            }
          else if(direction==Direction.right)
            {
              currentY++;
            }
          else if(direction==Direction.down)
            {
              print('Down');
              currentX++;
            }
          else {
            currentX--;
          }
        }
      else {
        emit(GameWon());
        break;
      }




    }

  }
  void pressOnMirror(Cell cell)
  {
    gameModel.game!.grid![cell.x!][cell.y!].reflection = (cell.reflection! + 45) % 360;
    cell.reflection=grid[cell.x!][cell.y!].reflection;
    initValue();
  }

  void changeSourceDirection()
  {

    late Direction direction;

    switch(gameModel.game!.leaser![0].currentDirection)
        {

      case Direction.down :
               direction=Direction.left;

      case Direction.left :
        direction=Direction.up;
      case Direction.up:
        direction=Direction.right;
      case Direction.right:
        direction= Direction.down;

      case null:
        // TODO: Handle this case.
    }
    gameModel.game!.leaser![0].currentDirection=direction;
    print( gameModel.game!.leaser![0].currentDirection);
    initValue();


  }


}



// import 'dart:convert';
//
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lightlink/models/GameModel.dart';
// import 'package:lightlink/models/constantMirror.dart';
// import 'package:lightlink/models/empty.dart';
// import 'package:lightlink/models/laserGenerator.dart';
// import 'package:meta/meta.dart';
//
// import '../../models/cell.dart';
// import '../../models/fixedMirror45.dart';
// import '../../models/leaser.dart';
// import '../../models/wall.dart';
//
// part 'game_state.dart';
//
// class GameCubit extends Cubit<GameState> {
//   GameCubit(this.gameModel) : super(GameInitial());
//   late List<List<dynamic>> grid=[];
//   late List<Laser> laserPath;
//   final  GameModel gameModel;
//   static  GameCubit get (context)=>BlocProvider.of(context);
//   initValue()
//   {
//     grid=gameModel.game!.grid!;
//     calculateLaserPath(gameModel.game!.laser![0].x,0,gameModel.game!.laser![0].currentDirection!,grid);
//     for (var point in laserPath) {
//
//       grid[point.x][point.y]=Laser(x:point.x, y: point.y, currentDirection: point.currentDirection);
//
//     }
//     emit(PressOnMirrorState());
//
//   }
//   void calculateLaserPath(int x,int y ,Direction direction , List<List<dynamic>> grid){
//
//     laserPath=[];
//
//     int currentX=x;
//     int currentY=y;
//     while (currentX<7&& currentX>=0&& currentY<=7&& currentY>=0)
//     {
//
//       if(grid[currentX][currentY] is Empty)
//       {
//
//         laserPath.add(Laser(x: currentX, y: currentY, currentDirection: direction));
//         if (direction case Direction.up) {
//
//           currentX--;
//
//         }
//         else if (direction == Direction.down) {
//           currentX++;
//         } else if (direction == Direction.left) {
//           currentY--;
//         } else if (direction == Direction.right) {
//           currentY++;
//
//         }
//       }
//       else if(grid[currentX][currentY] is Wall||grid[currentX][currentY] is FramingMirror)
//       {
//         currentX=-1;
//
//       }
//       else if(grid[currentX][currentY] is FixedMirror45||grid[currentX][currentY] is ConstantMirror)
//       {
//
//         if (direction == Direction.up) {
//           if(grid[currentX][currentY].reflection==135)
//           {
//             currentY--;
//             direction=Direction.left;
//           }
//           else if(grid[currentX][currentY].reflection==45)
//           {
//             currentY++;
//             direction=Direction.right;
//           }
//           else {
//             break;
//           }
//
//         }
//         else if (direction == Direction.down) {
//
//
//           if (grid[currentX][currentY].reflection==45){
//
//             currentY--;
//
//             direction=Direction.left;
//           }
//           else if (grid[currentX][currentY].reflection==315)
//           {
//             currentY++;
//             direction=Direction.right;
//           }
//
//           else
//           {
//             currentY=-1;
//
//           }
//
//
//         }
//         else if (direction == Direction.right) {
//
//           if(grid[currentX][currentY].reflection==45)
//           {
//             currentX--;
//             direction=Direction.up;
//           }
//           else if(grid[currentX][currentY].reflection==90)
//           {
//             currentY--;
//             direction=Direction.left;
//           }
//           else if(grid[currentX][currentY].reflection==135)
//           {
//             currentX++;
//             direction=Direction.down;
//           }
//           else {
//             break;
//           }
//
//         }
//         else if (direction == Direction.left) {
//           if(grid[currentX][currentY].reflection==45)
//           {
//             currentX++;
//             direction=Direction.down;
//           }
//           else if (grid[currentX][currentY].reflection==315) {
//             currentX--;
//             direction=Direction.up;
//           }
//           else
//             currentY=-1;
//
//         }
//
//
//         if(currentX<7&& currentX>=0&& currentY<=7&& currentY>=0&&grid[currentX][currentY] is Empty) {
//
//           laserPath.add(Laser(x: currentX, y: currentY, currentDirection: direction));
//
//
//         }
//
//       }
//       else if(grid[currentX][currentY]  is Laser) {
//         break;
//       }
//       else if(grid[currentX][currentY] is LaserGenerator)
//       {
//         if(direction==Direction.left)
//         {
//
//           currentY--;
//         }
//         else if(direction==Direction.right)
//         {
//           currentY++;
//         }
//         else if(direction==Direction.down)
//         {
//           print('Down');
//           currentX++;
//         }
//         else {
//           currentX--;
//         }
//       }
//       else {
//         emit(GameWon());
//         break;
//       }
//
//
//
//
//     }
//
//   }
//   void pressOnMirror(FixedMirror45 mirror)
//   {
//     gameModel.game!.grid![mirror.x][mirror.y].reflection = (mirror.reflection + 45) % 360;
//     mirror.reflection=grid[mirror.x][mirror.y].reflection;
//     initValue();
//   }
//
//   void changeSourceDirection()
//   {
//
//     late Direction direction;
//
//     switch(gameModel.game!.laser![0].currentDirection)
//     {
//
//       case Direction.down :
//         direction=Direction.left;
//
//       case Direction.left :
//         direction=Direction.up;
//       case Direction.up:
//         direction=Direction.right;
//       case Direction.right:
//         direction= Direction.down;
//
//       case null:
//       // TODO: Handle this case.
//     }
//     gameModel.game!.laser![0].currentDirection=direction;
//     print( gameModel.game!.laser![0].currentDirection);
//     initValue();
//
//
//   }
//
//
// }
