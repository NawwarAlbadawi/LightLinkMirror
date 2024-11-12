
{
  "Game": {
"width":8,
"height":7,
"Grid": [
[
{"x": 0, "y": 0, "type": "empty"},
{"x": 0, "y": 1, "type": "empty"},
{"x": 0, "y": 2, "type": "fixedMirror45"},
{"x": 0, "y": 3, "type": "empty"},
{"x": 0, "y": 4, "type": "empty"},
{"x": 0, "y": 5, "type": "constantMirror"},
{"x": 0, "y": 6, "type": "empty"},
{"x": 0, "y": 7, "type": "laserGenerator"}
],
[
{"x": 1, "y": 0, "type": "empty"},
{"x": 1, "y": 1, "type": "framingMirror"},
{"x": 1, "y": 2, "type": "empty"},
{"x": 1, "y": 3, "type": "empty"},
{"x": 1, "y": 4, "type": "empty"},
{"x": 1, "y": 5, "type": "empty"},
{"x": 1, "y": 6, "type": "framingMirror"},
{"x": 1, "y": 7, "type": "empty"}
],
[
{"x": 2, "y": 0, "type": "fixedMirror45"},
{"x": 2, "y": 1, "type": "empty"},
{"x": 2, "y": 2, "type": "empty"},
{"x": 2, "y": 3, "type": "empty"},
{"x": 2, "y": 4, "type": "empty"},
{"x": 2, "y": 5, "type": "empty"},
{"x": 2, "y": 6, "type": "empty"},
{"x": 2, "y": 7, "type": "fixedMirror45":"reflection":45}
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
{"x": 7, "y": 0, "type": "empty"},
{"x": 7, "y": 1, "type": "empty"},
{"x": 7, "y": 2, "type": "empty"},
{"x": 7, "y": 3, "type": "empty"},
{"x": 7, "y": 4, "type": "empty"},
{"x": 7, "y": 5, "type": "fixedMirror45","reflection":45},
{"x": 7, "y": 6, "type": "empty"},
{"x": 7, "y": 7, "type": "empty"}
]
];

"laser": [
    { "x": 0, "y": 7,"direction":"down" }, // Starting point (laser generator)
    { "x": 1, "y": "direction":"down" }, // Next point (moving right)
    { "x": 2, "y": "direction":"down" }, // ... and so on
      ]
}

}