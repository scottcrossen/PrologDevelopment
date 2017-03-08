% Define types first
teacher(ms_appleton).
teacher(ms_gross).
teacher(mr_knight).
teacher(mr_mcevoy).
teacher(ms_parnell).

subject(english).
subject(gym).
subject(history).
subject(math).
subject(science).

state(california).
state(florida).
state(maine).
state(oregon).
state(virginia).

activity(antiquing).
activity(camping).
activity(sightseeing).
activity(spelunking).
activity(water_skiing).


solve :-
  % Define all teacher subjects
  subject(AppletonSubject), subject(GrossSubject), subject(KnightSubject),
  subject(McevoySubject), subject(ParnellSubject),
  all_different([AppletonSubject, GrossSubject, KnightSubject, McevoySubject, ParnellSubject]),

  % Define all states
  state(AppletonState), state(GrossState), state(KnightState),
  state(McevoyState), state(ParnellState),
  all_different([AppletonState, GrossState, KnightState, McevoyState, ParnellState]),

  % Define all activities
  activity(AppletonAct), activity(GrossAct), activity(KnightAct),
  activity(McevoyAct), activity(ParnellAct),
  all_different([AppletonAct, GrossAct, KnightAct, McevoyAct, ParnellAct]),

  % Do what the sample code did
  Quadruples = [ [ms_appleton, AppletonSubject, AppletonState, AppletonAct],
                 [ms_gross, GrossSubject, GrossState, GrossAct],
                 [mr_knight, KnightSubject, KnightState, KnightAct],
                 [mr_mcevoy, McevoySubject, McevoyState, McevoyAct],
                 [ms_parnell, ParnellSubject, ParnellState, ParnellAct] ],

  % 1. Clue one
  ( member([ms_gross, math, _, _], Quadruples) ; member([ms_gross, science, _, _], Quadruples) ),
  ( member([ms_gross, _, florida, antiquing], Quadruples) ; member([ms_gross, _, california, _], Quadruples) ),

  % 2. Clue two
  ( member([_, science, california, water_skiing], Quadruples) ; member([_, science, florida, water_skiing], Quadruples) ),
  ( member([mr_mcevoy, history, maine, _], Quadruples) ; member([mr_mcevoy, history, oregon, _], Quadruples) ),

  % 3. Clue three
  ( member([ms_appleton, english, virginia, _], Quadruples) ; member([ms_parnell, _, virginia, _], Quadruples) ),
  member([ms_parnell, _, _, spelunking], Quadruples),

  % 4. Clue four
  \+ member([_, gym, maine, _], Quadruples),
  \+ member([_, _, maine, sightseeing], Quadruples),

  % 5. Clue five
  \+ member([ms_gross, _, _, camping], Quadruples),
  ( member([ms_gross, _, _, antiquing], Quadruples) ;
    member([ms_parnell, _, _, antiquing], Quadruples) ;
    member([ms_appleton, _, _, antiquing], Quadruples) ),

  % Display all possible solutions
  tell(ms_appleton, AppletonSubject, AppletonState, AppletonAct),
  tell(ms_gross, GrossSubject, GrossState, GrossAct),
  tell(mr_knight, KnightSubject, KnightState, KnightAct),
  tell(mr_mcevoy, McevoySubject, McevoyState, McevoyAct),
  tell(ms_parnell, ParnellSubject, ParnellState, ParnellAct).

% Define helper functions
all_different([H | T]) :- member(H,T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(T, Sub, St, Act) :-
  write(T), write(', who teaches '), write(Sub), write(', is going on a trip to '),
  write(St), write(' to engage in '), write(Act), write('.'), nl.
