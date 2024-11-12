import 'package:flutter/material.dart';
import 'package:lightlink/models/GameModel.dart';
import 'package:lightlink/module/widgets/game_view_body.dart';
class GameView extends StatelessWidget {
  const GameView({super.key, required this.gameModel});
 final GameModel gameModel;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GameViewBody(gameModel: gameModel),
    );
  }
}
