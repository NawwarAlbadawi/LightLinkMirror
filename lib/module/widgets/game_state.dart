part of 'game_cubit.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

final class PressOnMirrorState extends GameState {

}

final class ChangeSourceDirectionState extends GameState {

}

final class GameWon extends GameState {

}


