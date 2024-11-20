
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lightlink/models/GameModel.dart';
import 'package:lightlink/module/widgets/game_cubit.dart';
import '../../models/cell.dart';
import '../../models/constantMirror.dart';
import '../../models/empty.dart';
import '../../models/fixedMirror45.dart';
import '../../models/framing_mirror.dart';
import '../../models/laserGenerator.dart';
import '../../models/leaser.dart';
import '../../models/wall.dart';
class GameViewBody extends StatelessWidget {
  const GameViewBody({super.key, required this.gameModel});
  final  GameModel gameModel;


  @override
  Widget build(BuildContext context) {
  Cell cell;


    return BlocProvider(
      create: (context)=>GameCubit(gameModel)..initValue(),
      child: BlocConsumer<GameCubit,GameState>(
        listener: (context,state){
          if(state is GameWon)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const  Text('Congraltion You win!'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 6,
                ),
              );
            }
        },
        builder: (context,state) {
          var cubit=GameCubit.get(context);

          return Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 500,
                  child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
                      itemCount: 64,
                      itemBuilder: (context,index){
                        int row = index ~/ cubit.grid[0].length;
                        int col = index % cubit.grid[0] .length;
                         cell = cubit.grid[row][col];
                        return Container(
                          decoration:  BoxDecoration(
                            color:Colors.lightGreen,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    blurRadius: 4
                                )
                              ]// Add borders
                          ),

                          child:   _getCellWidget(cell,cubit),
                        );})
              )
            ],
          );
        }
      ),
    );
  }

  Widget _getCellWidget(Cell cell,GameCubit cubit) {

    switch (cell) {
      case Empty _:
        return const  Text(' '); // Empty cell
      case FixedMirror45 _:
        return IconButton(
            onPressed: (){

          cubit.pressOnMirror(cell);

        },
            icon:  Transform.rotate(
                angle: cell.reflection.toDouble(),
                child: const   Icon(Icons.remove,size: 30,color: Colors.white,))); // Fixed mirror 45 degrees
      case ConstantMirror _:
        return Transform.rotate(
          angle: -cell.reflection.toDouble(),
            child: const  Icon(Icons.remove,size: 30,)); // Constant mirror
      case FramingMirror _:
        return GestureDetector(
          onTap: (){
            cubit.changeFramingMirror(cell);

          },
            child: const  Icon(Icons.panorama_wide_angle,size: 45,color: Colors.black,)); // Framing mirror
      case Wall _:
        return const  Icon(Icons.block); // Wall
      case LaserGenerator _:
        return IconButton( onPressed:(){
           cubit.changeSourceDirection();
        } , icon: const  Icon(FontAwesomeIcons.lightbulb,size: 30,color: Colors.white,));
      case Laser _:
        return const  Icon(Icons.flash_on,color: Colors.yellow,size: 35,);// Laser generator
      default:
        return const Icon(FontAwesomeIcons.bullseye,color: Colors.red,); // Unknown cell type
    }
  }
}






