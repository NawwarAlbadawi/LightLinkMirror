
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lightlink/models/GameModel.dart';
import 'package:lightlink/models/Mirror.dart';
import 'package:lightlink/models/empty.dart';
import 'package:lightlink/models/fixedMirror45.dart';
import '../../models/cell.dart';
import '../../models/framing_mirror.dart';
import '../../models/laserGenerator.dart';
import '../../models/leaser.dart';
import '../../models/wall.dart';
part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this.gameModel) : super(GameInitial());
  late List<List<Cell>> grid=[];
  late List<Laser> laserPath=[];
  final  GameModel gameModel;
   Set<List<List<Cell>>>states={} ;
  List<List<bool>> isVisited = List.generate( 8, (i) => List.generate(8, (j) => false), );
   static  GameCubit get (context)=>BlocProvider.of(context);
   initValue()
   {

 grid=gameModel.game!.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();
 states.add(grid);
    calculateLaserPath(gameModel.game!.laser![0].x,
        gameModel.game!.laser![0].y,
        gameModel.game!.laser![0].currentDirection!,
        grid);


    for (var e in laserPath) {
      int x = e.x;
      int y = e.y;
      grid[x][y]=Laser(x: x, y: y, currentDirection:e.currentDirection);
    }
     emit(PressOnMirrorState());

   }
  void calculateLaserPath(int x,int y ,Direction direction , List<List<Cell>> grid){

     laserPath=[];

    int currentX=x;
    int currentY=y;
    while (currentX<8&& currentX>=0&& currentY<=8&& currentY>=0)
    {

      if(grid[currentX][currentY]is Empty)
      {

        laserPath.add(Laser(x: currentX, y: currentY, currentDirection: direction));
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
      else if(grid[currentX][currentY] is Wall)
      {
        currentX=-1;

      }
      else if(grid[currentX][currentY] is Mirror)
      {

        Mirror mirror = grid[currentX][currentY] as Mirror;
        Map<String,dynamic>m={};
        m=getXandY(mirror: mirror, direction: direction, currentY: currentY, currentX: currentX);
         if(m['x']==currentX&&m['y']==currentY)
           {
             break;
           }
         currentX=m['x']!;
         currentY=m['y']!;
         direction=m['direction'];
        if(currentX<gameModel.game!.height!&& currentX>=0&& currentY<=gameModel.game!.height!&& currentY>=0&&grid[currentX][currentY]is Empty) {
          laserPath.add(Laser(x: currentX, y: currentY, currentDirection: direction));


        }

      }
      else if(grid[currentX][currentY]is Laser) {
        break;
      }
      else if(grid[currentX][currentY] is LaserGenerator)
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
              ('Down');
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

  // void getNextState(List<List<cell>>grid){
  //  calculateLaserPath(x, y, direction, grid)
  // gameModel.game!.grid![mirror.x][mirror.y]=FixedMirror45(x: mirror.x, y:mirror.y, reflection:mirror.reflection);
  //
  //
  // }


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




