
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lightlink/models/GameModel.dart';
import 'package:lightlink/models/Mirror.dart';
import 'package:lightlink/models/empty.dart';
import 'package:lightlink/models/fixedMirror45.dart';
import '../../models/cell.dart';
import '../../models/constantMirror.dart';
import '../../models/framing_mirror.dart';
import '../../models/goal.dart';
import '../../models/laserGenerator.dart';
import '../../models/leaser.dart';
import '../../models/wall.dart';
part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this.gameModel) : super(GameInitial());

  late List<Laser> laserPath=[];
  final  GameModel gameModel;

   bool isWin=false;
  List<List<bool>> isVisited = List.generate( 8, (i) => List.generate(8, (j) => false), );
   static  GameCubit get (context)=>BlocProvider.of(context);
   initValue()
   {


 //states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, grid));

    getNextState( gameModel.game!.grid!.map((row)=>row.map((cell)=>cell).toList()).toList());
     emit(PressOnMirrorState());

   }
  List<List<Cell>> calculateLaserPath(int x,int y ,Direction direction , List<List<Cell>> grid){

     laserPath=[];

    int currentX=x;
    int currentY=y;
    //print(grid);
    while (currentX<8&& currentX>=0&& currentY<=8&& currentY>=0) {
      if (grid[currentX][currentY]is Empty) {
        laserPath.add(
            Laser(x: currentX, y: currentY, currentDirection: direction));
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
      else if (grid[currentX][currentY] is Wall) {
        currentX = -1;
      }
      else if (grid[currentX][currentY] is Mirror) {
        laserPath.add(Laser(x: currentX, y: currentY, currentDirection: direction));
        Mirror mirror = grid[currentX][currentY] as Mirror;

        Map<String, dynamic>m = {};
        m = getXandY(mirror: mirror,
            direction: direction,
            currentY: currentY,
            currentX: currentX);
        if (m['x'] == currentX && m['y'] == currentY) {
          break;
        }
        currentX = m['x']!;
        currentY = m['y']!;
        direction = m['direction'];
        if (currentX < gameModel.game!.height! && currentX >= 0 &&
            currentY <= gameModel.game!.height! && currentY >= 0 &&
            grid[currentX][currentY]is Empty) {
          laserPath.add(Laser(x: currentX, y: currentY, currentDirection: direction));
        }
      }
      else if (grid[currentX][currentY]is Laser) {
        Laser laser = grid[currentX][currentY] as Laser;
        if (laser.currentDirection == Direction.down)
          currentX++;
        else if (laser.currentDirection == Direction.right) {
          currentY++;
        }
        else if (laser.currentDirection == Direction.up) {
          currentX--;
        }
        else if (laser.currentDirection == Direction.left) {
          currentY--;
        }
      }
      else if (grid[currentX][currentY] is LaserGenerator) {
        if (direction == Direction.left) {
          currentY--;
        }
        else if (direction == Direction.right) {
          currentY++;
        }
        else if (direction == Direction.down) {
          ('Down');
          currentX++;
        }
        else {
          currentX--;
        }
      }
      else {
        isWin = true;
        for (var e in laserPath) {
          int x = e.x;
          int y = e.y;

          if (gameModel.game!.grid![x][y] is Empty) {
            gameModel.game!.grid![x][y] =
                Laser(x: x, y: y, currentDirection: e.currentDirection);
          }
        }
        emit(GameWon());

        break;
      }
    }


     for (var e in laserPath) {
       int x = e.x;
       int y = e.y;

       if(grid[x][y] is Empty){
         grid[x][y]=Laser(x: x, y: y, currentDirection:e.currentDirection);}
     }
    return grid;

  }
  void pressOnMirror(Mirror mirror)
  {
    mirror .reflection = (mirror.reflection + 45) % 360;
    initValue();
  }

  void changeSourceDirection()
  {

    late Direction direction;
    (gameModel.game!.laser![0].x);
    (gameModel.game!.laser![0].y);

    switch(gameModel.game!.laser![0].currentDirection)
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
    gameModel.game!.laser![0].currentDirection=direction;
    initValue();


  }

  void changeFramingMirror(FramingMirror mirror){

     gameModel.game!.grid![mirror.x][mirror.y]=Empty(x: mirror.x, y: mirror.y);
 if(mirror.minX!=mirror.maxX){
     if(mirror.x>mirror.minX&&mirror.x<mirror.maxX)
       {
         mirror.x=mirror.maxX;
       }
     else if(mirror.x==mirror.maxX)
       {
         mirror.x=mirror.minX;
       }
     else {
       mirror.x++;
     } }
 else {
   if(mirror.y>mirror.minY&&mirror.y<mirror.maxY)
   {
     mirror.y=mirror.maxY;
   }
   else if(mirror.y==mirror.maxY)
   {
     mirror.y=mirror.minY;
   }
   else {
     mirror.y++;
   }
 }


    gameModel.game!.grid![mirror.x][mirror.y]=FramingMirror(x: mirror.x, y: mirror.y,reflection: mirror.reflection,minY: mirror.minY,minX: mirror.minX,maxY: mirror.maxY,maxX: mirror.maxX);
    initValue();
  }

  void getNextState(List<List<Cell>>gr){

    Set<List<List<Cell>>>states={} ;
   calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr);
   //states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr));
   for (var e in laserPath) {
     int x = e.x;
     int y = e.y;


       if(!isVisited[x][y]){
     if (gr[x][y] is FixedMirror45) {

       gameModel.game!.grid![x][y] = FixedMirror45(x: x, y: y, reflection: 315);
       gr=gameModel.game!.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();
       states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr));
       if(isWin)
         return;
       gameModel.game!.grid![x][y] = FixedMirror45(x: x, y: y, reflection: 135);
       gr=gameModel.game!.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();
       states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr));
       if(isWin)
         return;
       gameModel.game!.grid![x][y] = FixedMirror45(x: x, y: y, reflection: 270);
       gr=gameModel.game!.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();
       states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr));
       if(isWin)
         return;
       gameModel.game!.grid![x][y] = FixedMirror45(x: x, y: y, reflection: 45);
       gr=gameModel.game!.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();
       states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr));
       if(isWin)
         return;
       gameModel.game!.grid![x][y] = FixedMirror45(x: x, y: y, reflection: 90);
       gr=gameModel.game!.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();
       states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr));
       if(isWin)
         return;
     }
     isVisited[x][y]=true;
       }
    }




      states.forEach((v){
        stack.push(v);
      });
    Dfs();

}

  //gameModel.game!.grid![mirror.x][mirror.y]=FixedMirror45(x: mirror.x, y:mirror.y, reflection:mirror.reflection);

  void Dfs()
  {
    if(isWin)
      return;

    while(stack.isNotEmpty)
    {

      var g = stack.pop();
      printGrid(g);
      getNextState(g);
    }
  }


  void printStates(Set<List<List<Cell>>>states){

     states.forEach((g){

        g.forEach((r){
          String cellRepresentation=" " ;
          r.forEach((c){
            cellRepresentation +=getCellRepresentation(c)+" ";
          });
          print(cellRepresentation);
        });
        print('--------------------------');

     });

  }

  String getCellRepresentation(Cell cell) {
    if (cell is Empty) {
      return '.'; // Representation for Empty cell
    }
    else if (cell is FixedMirror45) {
      return '${cell.reflection}'; // Representation for FixedMirror45 cell
    } else if (cell is Laser) {
      return 'L'; // Representation for Laser cell
    } else if (cell is Goal) {
      return 'G'; // Representation for Goal cell
    } else if (cell is ConstantMirror) {
      return 'C'; // Representation for ConstantMirror cell
    } else if (cell is FramingMirror) {
      return 'F'; // Representation for FramingMirror cell
    } else {
      return '?'; // Representation for unknown cell type
    }
  }


  Stack<List<List<Cell>>> stack = Stack<List<List<Cell>>>();

  Map<String,dynamic>getXandY({required Mirror mirror, required Direction direction ,required int currentY, required int currentX }){
     Map<String,dynamic>m={};


     if (direction == Direction.up) {
       if(mirror.reflection==135)
       {
         currentY--;
         direction=Direction.left;
       }
       else if(mirror.reflection==45)
       {
         currentY++;
         direction=Direction.right;
       }


     }
     else if (direction == Direction.down) {


       if (mirror.reflection==45){

         currentY--;
         direction=Direction.left;
       }
       else if (mirror.reflection==315)
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


       if(mirror.reflection==45)
       {
         currentX--;
         direction=Direction.up;
       }
       else if(mirror.reflection==90)
       {
         currentY--;
         direction=Direction.left;
       }
       else if(mirror.reflection==135)
       {

         currentX++;
         direction=Direction.down;
       }


     }
     else if (direction == Direction.left) {
       if(mirror.reflection==45)
       {
         currentX++;
         direction=Direction.down;
       }
       else if (mirror.reflection==315) {
         currentX--;
         direction=Direction.up;
       }
       else{
         currentY=-1;}

     }

     m.addAll({'x':currentX,'y':currentY ,'direction':direction});
     return m;

  }


}



class Stack<T> {
  final List<T> _items = [];

  void push(T item) {
    _items.add(item);
  }

  T pop() {
    if (isEmpty) {
      throw Exception('Stack is empty');
    }
    return _items.removeLast();
  }

  T? peek() {
    if (isEmpty) {
      return null;
    }
    return _items.last;
  }

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

// You can add other helper methods if needed, like:
// - size(): Returns the number of elements in the stack.
// - clear(): Removes all elements from the stack.
// - contains(item): Checks if the stack contains a specific item.
}



// void getNextState(List<List<Cell>>gr){
//   states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr));
//   if(!states.contains(gr)||!isWin) {
//     printGrid(gr);
//     //calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr);
//
//     for (var e in laserPath) {
//       int x = e.x;
//       int y = e.y;
//
//
//       if (!isVisited[x][y]) {
//         if (gr[x][y] is FixedMirror45) {
//           Mirror mirror = gr[x][y] as Mirror;
//           gr[x][y] = FixedMirror45(x: x, y: y, reflection: (mirror.reflection));
//           getNextState(gr);
//           gr[x][y] = FixedMirror45(x: x, y: y, reflection: (mirror.reflection + 45) % 360);
//           getNextState(gr);
//           gr[x][y] = FixedMirror45(x: x, y: y, reflection: (mirror.reflection + 90) % 360);
//           getNextState(gr);
//           gr[x][y] = FixedMirror45(x: x, y: y, reflection: (mirror.reflection + 180)%360);
//           getNextState(gr);
//           gr[x][y] = FixedMirror45(x: x, y: y, reflection: (mirror.reflection+270)%360);
//           getNextState(gr);
//         }
//         isVisited[x][y] = true;
//       }
//       else {
//         states.forEach((v){
//           stack.push(v);
//         });
//         //Dfs();
//       }
//
//     }
//   }
//
//   return ;
//
//
//
//
//
//
// }