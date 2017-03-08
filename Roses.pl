% Define types first
customer(hugh).
customer(ida).
customer(jeremy).
customer(leroy).
customer(stella).

rose(cottage_beauty).
rose(golden_sunset).
rose(mountain_bloom).
rose(pink_paradise).
rose(sweet_dreams).

event(anniversary_party).
event(charity_auction).
event(retirement_banquet).
event(senior_prom).
event(wedding).

item(balloons).
item(candles).
item(chocolates).
item(place_cards).
item(streamers).

solve :-
  % Define all roses
  rose(HughRose), rose(IdaRose), rose(JeremyRose), rose(LeroyRose), rose(StellaRose),
  all_different([HughRose, IdaRose, JeremyRose, LeroyRose, StellaRose]),

  % Define all events
  event(HughEvent), event(IdaEvent), event(JeremyEvent), event(LeroyEvent), event(StellaEvent),
  all_different([HughEvent, IdaEvent, JeremyEvent, LeroyEvent, StellaEvent]),

  % Define all items
  item(HughItem), item(IdaItem), item(JeremyItem), item(LeroyItem), item(StellaItem),
  all_different([HughItem, IdaItem, JeremyItem, LeroyItem, StellaItem]),

  % Do what the sample code did.
  Quadruples = [ [hugh, HughRose, HughEvent, HughItem],
                 [ida, IdaRose, IdaEvent, IdaItem],
                 [jeremy, JeremyRose, JeremyEvent, JeremyItem],
                 [leroy, LeroyRose, LeroyEvent, LeroyItem],
                 [stella, StellaRose, StellaEvent, StellaItem] ],

  % These are all the relations included in the problem
  % 1. Clue one
  member([jeremy, _, senior_prom, _], Quadruples),
  \+ member([stella, _, wedding, _], Quadruples),
  member([stella, cottage_beauty, _, _], Quadruples),

  % 2. Clue two
  member([hugh, pink_paradise, _, _], Quadruples),
  \+ member([hugh, _, charity_auction, _], Quadruples),
  \+ member([hugh, _, wedding, _], Quadruples),

  % 3. Clue three
  member([_, _, anniversary_party, streamers], Quadruples),
  member([_, _, wedding, balloons], Quadruples),

  % 4. Clue four
  member([_, sweet_dreams, _, chocolates], Quadruples),
  \+ member([jeremy, mountain_bloom, _, _], Quadruples),

  % 5. Clue five
  member([leroy, _, retirement_banquet, _], Quadruples),
  member([_, _, senior_prom, candles], Quadruples),

  % Display all possible solutions
  tell(hugh, HughRose, HughEvent, HughItem),
  tell(ida, IdaRose, IdaEvent, IdaItem),
  tell(jeremy, JeremyRose, JeremyEvent, JeremyItem),
  tell(leroy, LeroyRose, LeroyEvent, LeroyItem),
  tell(stella, StellaRose, StellaEvent, StellaItem).

% Define helper funciton
all_different([H | T]) :- member(H,T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(C, R, E, I) :-
  write(C), write(' chose the '), write(R), write(' roses for the '), write(E),
  write(' and also bought the '), write(I), write('.'), nl.
