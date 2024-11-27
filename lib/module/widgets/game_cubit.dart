import 'package:collection/collection.dart';
import 'dart:collection';
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


  final  GameModel gameModel;
  late Game gameState;

  PriorityQueue<Game> stateQueue = PriorityQueue((a, b) => a.cost!.compareTo(b.cost!));

   bool isWin=false;

  List<List<bool>> isVisited = List.generate( 8, (i) => List.generate(8, (j) => false), );
   static  GameCubit get (context)=>BlocProvider.of(context);
   List<List<Cell>>gridToPrint=[];
   void init ()
   {
     gridToPrint=gameModel.game!.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();   }
   initValue()
   {

gameState =gameModel.game!.deepCopy();
calculateLaserPath(gameModel.game!.laserPath!.first.x, gameModel.game!.laserPath!.first.y, gameModel.game!.laserPath!.first.currentDirection!, gameState);
Dfs(gameState);


   }
  void calculateLaserPath(int x,int y ,Direction direction , Game state){

    int currentX=x;
    int currentY=y;
    while (currentX<8&& currentX>=0&& currentY<=8&& currentY>=0) {
      if (state.grid![currentX][currentY]is Empty) {
        state.laserPath!.add(Laser(x: currentX, y: currentY, currentDirection: direction));
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
      else if (state.grid![currentX][currentY] is Wall) {
        currentX = -1;
      }
      else if (state.grid![currentX][currentY] is Mirror) {

       state. laserPath!.add(Laser(x: currentX, y: currentY, currentDirection: direction));
        Mirror mirror = state.grid![currentX][currentY] as Mirror;

        Map<String, dynamic>m = {};
        m = getXandY(mirror: mirror,
            direction: direction,
            currentY: currentY,
            currentX: currentX);
        if (m['x'] == currentX && m['y'] == currentY) {
          break;
        }
        else {
        currentX = m['x']!;
        currentY = m['y']!;
        direction = m['direction'];
        if (currentX < gameModel.game!.height! && currentX >= 0 &&
            currentY <= gameModel.game!.height! && currentY >= 0 &&
           state.grid![currentX][currentY]is Empty) {
      //    state.laserPath!.add(Laser(x: currentX, y: currentY, currentDirection: direction));
        }}
      }
      else if (state.grid![currentX][currentY]is Laser) {
        Laser laser = state.grid![currentX][currentY] as Laser;
        if (laser.currentDirection == Direction.down) {
          currentX++;
        } else if (laser.currentDirection == Direction.right) {
          currentY++;
        }
        else if (laser.currentDirection == Direction.up) {
          currentX--;
        }
        else if (laser.currentDirection == Direction.left) {
          currentY--;
        }
      }
      else if (state.grid![currentX][currentY] is LaserGenerator) {
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

        for (var e in state.laserPath!) {
          int x = e.x;
          int y = e.y;
          if (gameModel.game!.grid![x][y] is Empty) {
            gameModel.game!.grid![x][y] = Laser(x: x, y: y, currentDirection: e.currentDirection);
          }
        }
        gameModel.game!.grid=state.grid;
       break ;
      }
    }


     for (var e in state.laserPath!) {
       int x = e.x;
       int y = e.y;

       if(state.grid![x][y] is Empty){
         state.grid![x][y]=Laser(x: x, y: y, currentDirection:e.currentDirection);}
     }
     gridToPrint=state.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();


  }
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


  FramingMirror changeFramingMirror(FramingMirror mirror){

   //  gameModel.game!.grid![mirror.x][mirror.y]=Empty(x: mirror.x, y: mirror.y);
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
print(mirror.x);

return FramingMirror(x: mirror.x, y: mirror.y,reflection: mirror.reflection,minY: mirror.minY,minX: mirror.minX,maxY: mirror.maxY,maxX: mirror.maxX);

  }


  void getNextState(Game state){

    List<Game>states=[] ;




    //states.add(calculateLaserPath(gameModel.game!.laser![0].x, gameModel.game!.laser![0].y, gameModel.game!.laser![0].currentDirection!, gr));
    for (var e in state.laserPath!)
      {
      int x = e.x;
      int y = e.y;

      if(!isVisited[x][y]){
        if (state.grid![x][y] is FixedMirror45) {



            Game  childState = gameModel.game!.deepCopy();
          childState.grid![x][y]= FixedMirror45(x: x, y: y, reflection: 135);
          childState.cost=calTheCost(childState: childState, fatherChild: state);
          states.add(childState);


          childState=  gameModel.game!.deepCopy();
          childState.grid![x][y]=FixedMirror45(x: x, y: y, reflection: 315);
            childState.cost=calTheCost(childState: childState, fatherChild: state)+state.cost!;
          states.add(childState);

            childState=  gameModel.game!.deepCopy();
            childState.grid![x][y]=FixedMirror45(x: x, y: y, reflection: 270);
            childState.cost=calTheCost(childState: childState, fatherChild: state)+state.cost!;
           states.add(childState);

            childState=  gameModel.game!.deepCopy();
            childState.grid![x][y]=   FixedMirror45(x: x, y: y, reflection: 45);
            childState.cost=calTheCost(childState: childState, fatherChild: state)+state.cost!;
          states.add(childState);

            childState=  gameModel.game!.deepCopy();
            childState.grid![x][y]=FixedMirror45(x: x, y: y, reflection: 90);
            childState.cost=calTheCost(childState: childState, fatherChild: state)+state.cost!;
          states.add(childState);
        isVisited[x][y]=true;

        }


      }
    }


if(isWin)
  {
    return ;
  }

    for (var v in states) {
      printGrid(v.grid!);
      stack.push(v);
    }


  }

  Queue<Game>queue= Queue<Game>();
  // void BFS()
  // {
  //
  //
  //   while(queue.isNotEmpty)
  //   {
  //
  //     var g = queue.removeFirst();
  //
  //     printGrid(g.grid!);
  //     calculateLaserPath(gameModel.game!.laserPath!.first.x, gameModel.game!.laserPath!.first.y, gameModel.game!.laserPath!.first.currentDirection!, g);
  //     if(isWin)
  //     {
  //       emit(GameWon());
  //       UCS();
  //
  //       return ;
  //
  //     }
  //     else {
  //       getNextState(g);
  //
  //     }
  //
  //   }
  //   if(isWin)
  //   {
  //
  //     return ;
  //   }
  //
  //   emit(GameLose());
  //   return;
  // }
  Stack<Game> stack = Stack<Game>();
  void Dfs(Game state )
  {
    //calculateLaserPath(gameModel.game!.laserPath!.first.x, gameModel.game!.laserPath!.first.y, gameModel.game!.laserPath!.first.currentDirection!, state);

    stack.push(state);
    while(stack.isNotEmpty)
    {
      var g = stack.pop();
      calculateLaserPath(gameModel.game!.laserPath!.first.x, gameModel.game!.laserPath!.first.y, gameModel.game!.laserPath!.first.currentDirection!, g);
      gridToPrint=g.grid!.map((row)=>row.map((cell)=>cell).toList()).toList();

      if(isWin)
        {
        //  printGrid(state.grid!);
emit(GameWon());

          return ;

        }
      else {getNextState(g);

      }

    }
    if(isWin)
      {
        return ;
      }

emit(GameLose());
    return;
  }

  void UCS (Game state) {
    printGrid(state.grid!);
    print('============================');
    stateQueue.add(state);

      while(stateQueue.isNotEmpty)
        {

          Game j =stateQueue.removeFirst();

          calculateLaserPath(gameModel.game!.laserPath!.first.x, gameModel.game!.laserPath!.first.y, gameModel.game!.laserPath!.first.currentDirection!, j);
          if(isWin)
          {
            emit(GameWon());

            return ;

          }
          getNextState(j);




        }
    if(isWin)
    {
      return ;
    }
    emit(GameLose());
  }

  int calTheCost ({required Game childState, required Game fatherChild })
  {
    int cost =0;
    for (int i=0;i<8;i++) {

      for (int j=0;j<8;j++) {
        if(fatherChild.grid![i][j] is Laser && childState.grid![i][j] is Empty )
          {
            cost++;
          }
      }

      // Print newline for next row
    }
    return  cost ;
  }

5




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









