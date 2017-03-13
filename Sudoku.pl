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
    sublist(Board, Number, Number, AsList)

% Helper function to split a row into each square.
split([H | T], H, T).
splitRows(Board, S0, S1, S2, S3, S4, S5, S6, S7, S8) :-
      split(Board, S0, S0rest),
      split(S0rest, S1, S1rest),
      split(S1rest, S2, S2rest),
      split(S2rest, S3, S3rest),
      split(S3rest, S4, S4rest),
      split(S4rest, S5, S5rest),
      split(S5rest, S6, S6rest),
      split(S6rest, S7, S7rest),
      split(S7rest, S8, []).

% Helper function to solve for each item
solveSquare(Square,Row,Col,Cube) :-
      (nonvar(Square); var(Square), digit(Square), is_set(Row), is_set(Col), is_set(Cube)).

% Main solve function
solve(Board) :-
    % Introduce variables for each row.
    getRow(Board, 0, R0)
    getRow(Board, 1, R1)
    getRow(Board, 2, R2)
    getRow(Board, 3, R3)
    getRow(Board, 4, R4)
    getRow(Board, 5, R5)
    getRow(Board, 6, R6)
    getRow(Board, 7, R7)
    getRow(Board, 8, R8)

    % Introduce variables for each column.
    columnAsList(Board, 0, C0),
    columnAsList(Board, 1, C1),
    columnAsList(Board, 2, C2),
    columnAsList(Board, 3, C3),
    columnAsList(Board, 4, C4),
    columnAsList(Board, 5, C5),
    columnAsList(Board, 6, C6),
    columnAsList(Board, 7, C7),
    columnAsList(Board, 8, C8),

    % Introduce variables for each cube.
    getCube(Board, 0, Cub0),
    getCube(Board, 1, Cub1),
    getCube(Board, 2, Cub2),
    getCube(Board, 3, Cub3),
    getCube(Board, 4, Cub4),
    getCube(Board, 5, Cub5),
    getCube(Board, 6, Cub6),
    getCube(Board, 7, Cub7),
    getCube(Board, 8, Cub8),

    % Introduce variables for each square.
    splitRows(R0, S00, S01, S02, S03, S04, S05, S06, S07, S08),
    splitRows(R1, S10, S11, S12, S13, S14, S15, S16, S17, S18),
    splitRows(R2, S20, S21, S22, S23, S24, S25, S26, S27, S28),
    splitRows(R3, S30, S31, S32, S33, S34, S35, S36, S37, S38),
    splitRows(R4, S40, S41, S42, S43, S44, S45, S46, S47, S48),
    splitRows(R5, S50, S51, S52, S53, S54, S55, S56, S57, S58),
    splitRows(R6, S60, S61, S62, S63, S64, S65, S66, S67, S68),
    splitRows(R7, S70, S71, S72, S73, S74, S75, S76, S77, S78),
    splitRows(R8, S80, S81, S82, S83, S84, S85, S86, S87, S88),

    % Solve for each square, left to right, top to bottom.
    SolveSquare(S00, R0, C0, Cub0),
    SolveSquare(S00, R0, C1, Cub0),
    SolveSquare(S00, R0, C2, Cub0),
    SolveSquare(S00, R0, C3, Cub1),
    SolveSquare(S00, R0, C4, Cub1),
    SolveSquare(S00, R0, C5, Cub1),
    SolveSquare(S00, R0, C6, Cub2),
    SolveSquare(S00, R0, C7, Cub2),
    SolveSquare(S00, R0, C8, Cub2),

    SolveSquare(S00, R1, C0, Cub0),
    SolveSquare(S00, R1, C1, Cub0),
    SolveSquare(S00, R1, C2, Cub0),
    SolveSquare(S00, R1, C3, Cub1),
    SolveSquare(S00, R1, C4, Cub1),
    SolveSquare(S00, R1, C5, Cub1),
    SolveSquare(S00, R1, C6, Cub2),
    SolveSquare(S00, R1, C7, Cub2),
    SolveSquare(S00, R1, C8, Cub2),

    SolveSquare(S00, R2, C0, Cub0),
    SolveSquare(S00, R2, C1, Cub0),
    SolveSquare(S00, R2, C2, Cub0),
    SolveSquare(S00, R2, C3, Cub1),
    SolveSquare(S00, R2, C4, Cub1),
    SolveSquare(S00, R2, C5, Cub1),
    SolveSquare(S00, R2, C6, Cub2),
    SolveSquare(S00, R2, C7, Cub2),
    SolveSquare(S00, R2, C8, Cub2),

    SolveSquare(S00, R3, C0, Cub3),
    SolveSquare(S00, R3, C1, Cub3),
    SolveSquare(S00, R3, C2, Cub3),
    SolveSquare(S00, R3, C3, Cub4),
    SolveSquare(S00, R3, C4, Cub4),
    SolveSquare(S00, R3, C5, Cub4),
    SolveSquare(S00, R3, C6, Cub5),
    SolveSquare(S00, R3, C7, Cub5),
    SolveSquare(S00, R3, C8, Cub5),

    SolveSquare(S00, R4, C0, Cub3),
    SolveSquare(S00, R4, C1, Cub3),
    SolveSquare(S00, R4, C2, Cub3),
    SolveSquare(S00, R4, C3, Cub4),
    SolveSquare(S00, R4, C4, Cub4),
    SolveSquare(S00, R4, C5, Cub4),
    SolveSquare(S00, R4, C6, Cub5),
    SolveSquare(S00, R4, C7, Cub5),
    SolveSquare(S00, R4, C8, Cub5),

    SolveSquare(S00, R5, C0, Cub3),
    SolveSquare(S00, R5, C1, Cub3),
    SolveSquare(S00, R5, C2, Cub3),
    SolveSquare(S00, R5, C3, Cub4),
    SolveSquare(S00, R5, C4, Cub4),
    SolveSquare(S00, R5, C5, Cub4),
    SolveSquare(S00, R5, C6, Cub5),
    SolveSquare(S00, R5, C7, Cub5),
    SolveSquare(S00, R5, C8, Cub5),

    SolveSquare(S00, R6, C0, Cub6),
    SolveSquare(S00, R6, C1, Cub6),
    SolveSquare(S00, R6, C2, Cub6),
    SolveSquare(S00, R6, C3, Cub7),
    SolveSquare(S00, R6, C4, Cub7),
    SolveSquare(S00, R6, C5, Cub7),
    SolveSquare(S00, R6, C6, Cub8),
    SolveSquare(S00, R6, C7, Cub8),
    SolveSquare(S00, R6, C8, Cub8),

    SolveSquare(S00, R7, C0, Cub6),
    SolveSquare(S00, R7, C1, Cub6),
    SolveSquare(S00, R7, C2, Cub6),
    SolveSquare(S00, R7, C3, Cub7),
    SolveSquare(S00, R7, C4, Cub7),
    SolveSquare(S00, R7, C5, Cub7),
    SolveSquare(S00, R7, C6, Cub8),
    SolveSquare(S00, R7, C7, Cub8),
    SolveSquare(S00, R7, C8, Cub8),

    SolveSquare(S00, R8, C0, Cub6),
    SolveSquare(S00, R8, C1, Cub6),
    SolveSquare(S00, R8, C2, Cub6),
    SolveSquare(S00, R8, C3, Cub7),
    SolveSquare(S00, R8, C4, Cub7),
    SolveSquare(S00, R8, C5, Cub7),
    SolveSquare(S00, R8, C6, Cub8),
    SolveSquare(S00, R8, C7, Cub8),
    SolveSquare(S00, R8, C8, Cub8).

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
