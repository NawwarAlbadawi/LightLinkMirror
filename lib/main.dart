import 'package:flutter/material.dart';
import 'package:lightlink/models/GameModel.dart';
import 'package:lightlink/models/leaser.dart';
import 'package:lightlink/models/states.dart';
import 'package:lightlink/module/views/game_view.dart';

import 'models/cell.dart';

void main() {
 States states=States();

 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  GameView(gameModel:GameModel.fromJson({


      "Game": {
      "width":8,
      "height":7,
      "Grid": [
      [
      {"x": 0, "y": 0, "type": "laserGenerator","reflection":45},
      {"x": 0, "y": 1, "type": "empty"},
      {"x": 0, "y": 2, "type": "fixedMirror45","reflection":45},
      {"x": 0, "y": 3, "type": "empty"},
      {"x": 0, "y": 4, "type": "empty"},
      {"x": 0, "y": 5, "type": "empty"},
      {"x": 0, "y": 6, "type": "empty"},
      {"x": 0, "y": 7, "type": "fixedMirror45","reflection":45}
      ],
      [
      {"x": 1, "y": 0, "type": "empty"},
      {"x": 1, "y": 1, "type": "framingMirror"},
      {"x": 1, "y": 2, "type": "empty"},
      {"x": 1, "y": 3, "type": "empty"},
      {"x": 1, "y": 4, "type": "empty"},
      {"x": 1, "y": 5, "type": "empty"},
      {"x": 1, "y": 6, "type": "empty"},
      {"x": 1, "y": 7, "type": "empty"}
      ],
      [
      {"x": 2, "y": 0, "type": "fixedMirror45","reflection":45},
      {"x": 2, "y": 1, "type": "empty"},
      {"x": 2, "y": 2, "type": "constantMirror","reflection":45},
      {"x": 2, "y": 3, "type": "empty"},
      {"x": 2, "y": 4, "type": "empty"},
      {"x": 2, "y": 5, "type": "empty"},
      {"x": 2, "y": 6, "type": "empty"},
      {"x": 2, "y": 7, "type": "empty"}
      ],
      [
      {"x": 3, "y": 0, "type": "empty"},
      {"x": 3, "y": 1, "type": "empty"},
      {"x": 3, "y": 2, "type": "empty"},
      {"x": 3, "y": 3, "type": "empty"},
      {"x": 3, "y": 4, "type": "empty"},
      {"x": 3, "y": 5, "type": "empty"},
      {"x": 3, "y": 6, "type": "empty"},
      {"x": 3, "y": 7, "type": "empty"}
      ],
      [
      {"x": 4, "y": 0, "type": "empty"},
      {"x": 4, "y": 1, "type": "empty"},
      {"x": 4, "y": 2, "type": "empty"},
      {"x": 4, "y": 3, "type": "empty"},
      {"x": 4, "y": 4, "type": "empty"},
      {"x": 4, "y": 5, "type": "empty"},
      {"x": 4, "y": 6, "type": "empty"},
      {"x": 4, "y": 7, "type": "empty"}
      ],
      [
      {"x": 6, "y": 0, "type": "empty"},
      {"x": 6, "y": 1, "type": "framingMirror"},
      {"x": 6, "y": 2, "type": "empty"},
      {"x": 6, "y": 3, "type": "empty"},
      {"x": 6, "y": 4, "type": "empty"},
      {"x": 6, "y": 5, "type": "empty"},
      {"x": 6, "y": 6, "type": "framingMirror"},
      {"x": 6, "y": 7, "type": "empty"}
      ],
      [
      {"x": 7, "y": 0, "type": "goal"},
      {"x": 7, "y": 1, "type": "empty"},
      {"x": 7, "y": 2, "type": "empty"},
      {"x": 7, "y": 3, "type": "empty"},
      {"x": 7, "y": 4, "type": "empty"},
      {"x": 7, "y": 5, "type": "empty"},
      {"x": 7, "y": 6, "type": "empty"},
      {"x": 7, "y": 7, "type": "constantMirror","reflection":45}
      ]
      ],

      "laser": [
        // Starting point (laser generator)
          { "x": 0, "y":0, "direction":"down" }, // Next point (moving right)
         // ... and so on
      ]
      }

      }))


    );
  }
}

