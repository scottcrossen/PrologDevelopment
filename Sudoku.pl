digit(1).
digit(2).
digit(3).
digit(4).
digit(5).
digit(6).
digit(7).
digit(8).
digit(9).
 
numBetween(Num, Lower, Upper) :-
        Num >= Lower,
        Num =< Upper.
 
% cubeBounds: (RowLow, RowHigh, ColLow, ColHigh, CubeNumber)
cubeBounds(0, 2, 0, 2, 0).
cubeBounds(0, 2, 3, 5, 1).
cubeBounds(0, 2, 6, 8, 2).
cubeBounds(3, 5, 0, 2, 3).
cubeBounds(3, 5, 3, 5, 4).
cubeBounds(3, 5, 6, 8, 5).
cubeBounds(6, 8, 0, 2, 6).
cubeBounds(6, 8, 3, 5, 7).
cubeBounds(6, 8, 6, 8, 8).
 
% columnAsList: (Board, ColumnNumber, AsRow)
columnAsList([], _, []).
columnAsList([Head|Tail], ColumnNum, [Item|Rest]) :-
        nth0(ColumnNum, Head, Item),
        columnAsList(Tail, ColumnNum, Rest).
 
% cubeNum: (RowNum, ColNum, WhichCube)
cubeNum(RowNum, ColNum, WhichCube) :-
        cubeBounds(RowLow, RowHigh, ColLow, ColHigh, WhichCube),
        numBetween(RowNum, RowLow, RowHigh),
        numBetween(ColNum, ColLow, ColHigh).
 
% drop: (InputList, NumToDrop, ResultList)
drop([], _, []):-!.
drop(List, 0, List):-!.
drop([_|Tail], Num, Rest) :-
        Num > 0,
        NewNum is Num - 1,
        drop(Tail, NewNum, Rest).
 
% take: (InputList, NumToTake, ResultList)
take([], _, []):-!.
take(_, 0, []):-!.
take([Head|Tail], Num, [Head|Rest]) :-
        Num > 0,
        NewNum is Num - 1,
        take(Tail, NewNum, Rest).
 
% sublist: (List, Start, End, NewList)
sublist(List, Start, End, NewList) :-
        drop(List, Start, TempList),
        NewEnd is End - Start + 1,
        take(TempList, NewEnd, NewList).
 
% getCube: (Board, CubeNumber, ContentsOfCube)
getCube(Board, Number, AsList) :-
        cubeBounds(RowLow, RowHigh, ColLow, ColHigh, Number),
        sublist(Board, RowLow, RowHigh, [Row1, Row2, Row3]),
        sublist(Row1, ColLow, ColHigh, Row1Nums),
        sublist(Row2, ColLow, ColHigh, Row2Nums),
        sublist(Row3, ColLow, ColHigh, Row3Nums),
        append(Row1Nums, Row2Nums, TempRow),
        append(TempRow, Row3Nums, AsList).
 
% Import the is_set/1 function
:- use_module(library(lists)).

% Helper function to get row by index
getRow(Board, Number, AsList) :-
      nth0(Number, Board, AsList).

% Helper function to split a row into each square.
split([H | T], H, T).
splitRows(Board, R0, R1, R2, R3, R4, R5, R6, R7, R8) :-
      split(Board, R0, R0rest),
      split(R0rest, R1, R1rest),
      split(R1rest, R2, R2rest),
      split(R2rest, R3, R3rest),
      split(R3rest, R4, R4rest),
      split(R4rest, R5, R5rest),
      split(R5rest, R6, R6rest),
      split(R6rest, R7, R7rest),
      split(R7rest, R8, []).

% Helper function to solve for each item
solveItem(Square,Row,Col,Cube) :-
      (nonvar(Square); var(Square), digit(Square), is_set(Row), is_set(Col), is_set(Cube)).
solveSquare(Board, XPos, YPos):-
      getRow(Board, YPos, Row),
      columnAsList(Board, XPos, Col),
      CubeIndex is div(XPos,3)+div(YPos,3)*3,
      getCube(Board, CubeIndex, Cube),
      nth0(XPos,Row,Square),
      solveItem(Square, Row, Col, Cube).

% Main solve function
solve(Board) :- 
      solveSquare(Board,0,0),
      solveSquare(Board,0,1),
      solveSquare(Board,0,2),
      solveSquare(Board,0,3),
      solveSquare(Board,0,4),
      solveSquare(Board,0,5),
      solveSquare(Board,0,6),
      solveSquare(Board,0,7),
      solveSquare(Board,0,8),

      solveSquare(Board,1,0),
      solveSquare(Board,1,1),
      solveSquare(Board,1,2),
      solveSquare(Board,1,3),
      solveSquare(Board,1,4),
      solveSquare(Board,1,5),
      solveSquare(Board,1,6),
      solveSquare(Board,1,7),
      solveSquare(Board,1,8),

      solveSquare(Board,2,0),
      solveSquare(Board,2,1),
      solveSquare(Board,2,2),
      solveSquare(Board,2,3),
      solveSquare(Board,2,4),
      solveSquare(Board,2,5),
      solveSquare(Board,2,6),
      solveSquare(Board,2,7),
      solveSquare(Board,2,8),

      solveSquare(Board,3,0),
      solveSquare(Board,3,1),
      solveSquare(Board,3,2),
      solveSquare(Board,3,3),
      solveSquare(Board,3,4),
      solveSquare(Board,3,5),
      solveSquare(Board,3,6),
      solveSquare(Board,3,7),
      solveSquare(Board,3,8),

      solveSquare(Board,4,0),
      solveSquare(Board,4,1),
      solveSquare(Board,4,2),
      solveSquare(Board,4,3),
      solveSquare(Board,4,4),
      solveSquare(Board,4,5),
      solveSquare(Board,4,6),
      solveSquare(Board,4,7),
      solveSquare(Board,4,8),

      solveSquare(Board,5,0),
      solveSquare(Board,5,1),
      solveSquare(Board,5,2),
      solveSquare(Board,5,3),
      solveSquare(Board,5,4),
      solveSquare(Board,5,5),
      solveSquare(Board,5,6),
      solveSquare(Board,5,7),
      solveSquare(Board,5,8),

      solveSquare(Board,6,0),
      solveSquare(Board,6,1),
      solveSquare(Board,6,2),
      solveSquare(Board,6,3),
      solveSquare(Board,6,4),
      solveSquare(Board,6,5),
      solveSquare(Board,6,6),
      solveSquare(Board,6,7),
      solveSquare(Board,6,8),

      solveSquare(Board,7,0),
      solveSquare(Board,7,1),
      solveSquare(Board,7,2),
      solveSquare(Board,7,3),
      solveSquare(Board,7,4),
      solveSquare(Board,7,5),
      solveSquare(Board,7,6),
      solveSquare(Board,7,7),
      solveSquare(Board,7,8),

      solveSquare(Board,8,0),
      solveSquare(Board,8,1),
      solveSquare(Board,8,2),
      solveSquare(Board,8,3),
      solveSquare(Board,8,4),
      solveSquare(Board,8,5),
      solveSquare(Board,8,6),
      solveSquare(Board,8,7),
      solveSquare(Board,8,8).

% Prints out the given board.
printBoard([]).
printBoard([Head|Tail]) :-
        write(Head), nl,
        printBoard(Tail).
 
test1(Board) :-
        Board = [[2, _, _, _, 8, 7, _, 5, _],
                 [_, _, _, _, 3, 4, 9, _, 2],
                 [_, _, 5, _, _, _, _, _, 8],
                 [_, 6, 4, 2, 1, _, _, 7, _],
                 [7, _, 2, _, 6, _, 1, _, 9],
                 [_, 8, _, _, 7, 3, 2, 4, _],
                 [8, _, _, _, _, _, 4, _, _],
                 [3, _, 9, 7, 4, _, _, _, _],
                 [_, 1, _, 8, 2, _, _, _, 5]],
        solve(Board),
        printBoard(Board).
 
test2(Board) :-
        Board = [[_, _, _, 7, 9, _, 8, _, _],
                 [_, _, _, _, _, 4, 3, _, 7],
                 [_, _, _, 3, _, _, _, 2, 9],
                 [7, _, _, _, 2, _, _, _, _],
                 [5, 1, _, _, _, _, _, 4, 8],
                 [_, _, _, _, 5, _, _, _, 1],
                 [1, 2, _, _, _, 8, _, _, _],
                 [6, _, 4, 1, _, _, _, _, _],
                 [_, _, 3, _, 6, 2, _, _, _]],
        solve(Board),
        printBoard(Board).
