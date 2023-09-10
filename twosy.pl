/* ===========================================================================
    author : Abhayjit Sodhi
     first : 
    latest : 2022-11-02

    Solves the 2x2x2 Rubik's mini-cube ...
=========================================================================== */

:- use_module(r2x2x2).

:- dynamic sphere/4.

legalnode(Temp, Trail, Fin):-
	(xy(Temp,Fin) ; xy(Fin, Temp), legal(Fin, Trail).


legal(Temp, []).

legal(Temp, [Top|End] :- \+Temp=Top, legal(Temp, End).


rev([], []).

rev([Top|End], L) :- rev(End, Z), append(Z, [Top], L).


delete(_, [], []).

delete(Temp, [Temp|L], M) :- !, delete(Temp, L, M).

delete(Temp, [Fin|L1], [Fin,L2]):-delete(Temp, L1, L2).


%----------------------------------------------------------------------------%
% twosy
%     State: The State variable represents the current state for the 2x2x2 cube. 
%     Path:  The Path is the list of moves required to change the shuffled State into the Solved State.

twosy(State, Path) :-
    sphere(State, Path),
    apply_path(State, Path).

%----------------------------------------------------------------------------%
% sphere
%     BooleanState: is a variable that represents the shuffled state with true and solved state with the value false. 
%     Shuffled: is a variable that represents what the program began with as the shuffled state.
%     Path: the list of moves required to change the shuffled state into the solved state
%     State: The state variable represents the current state of the 2x2x2 cube.
%     TransitionState: verifies the current state and checks for changes.
%     AltState: value used to reference the alternative state of TransitionState.

sphere(state_zero(Temp), []) :- !.

sphere(State, Path) :-
	zo(State, _),
	xo(state_zero(Temp), _),

	sphere([true, State], state_zero(Temp), State, Path).

sphere([_|TransitionState], AltState, Shuffled, Path) :- 
	TransitionState \= Shuffled

	TransitionState \= state_zero(Temp),
	,
	fullpath(Shuffled, TransitionState, Transo), 

	reversecheck(state_zero(Temp), TransitionState, Transx), 

	append(Transo, Transx, Mvs),

	delete(_, Mvs,Path), 
	!.

sphere([BooleanState|TransitionState], AltState, Shuffled, Path) :-
	move_transform(TransitionState, holdi, NTransitionState),

	\+isthere(BooleanState, NTransitionState, Shuffled),
	
	xy(TransitionState, NTransitionState),
	movedone(BooleanState, NTransitionState, holdi),
	sphere([\+BooleanState, AltState], NTransitionState, Shuffled, Path).
    !.

sphere([BooleanState|TransitionState], AltState, Shuffled, Path) :-
	move_transform(TransitionState, holdthree, NTransitionState),

	\+isthere(BooleanState, NTransitionState, Shuffled),
	
	xy(TransitionState, NTransitionState),
	movedone(BooleanState, NTransitionState, holdthree),
	sphere([\+BooleanState, AltState], NTransitionState, Shuffled, Path).
    !.

sphere([BooleanState|TransitionState], AltState, Shuffled, Path) :-
	move_transform(TransitionState, hold, NTransitionState),

	\+isthere(BooleanState, NTransitionState, Shuffled),

	
	xy(TransitionState, NTransitionState),
	movedone(BooleanState, NTransitionState, hold),

	sphere([\+BooleanState, AltState], NTransitionState, Shuffled, Path).
    !.
sphere([BooleanState|TransitionState], AltState, Shuffled, Path) :-
	move_transform(TransitionState, holdcx, NTransitionState),

	\+isthere(BooleanState, NTransitionState, Shuffled),
	
	xy(TransitionState, NTransitionState),
	movedone(BooleanState, NTransitionState, holdcx),
	sphere([\+BooleanState, AltState], NTransitionState, Shuffled, Path).
    !.

sphere([BooleanState|TransitionState], AltState, Shuffled, Path) :-
	move_transform(TransitionState, holdf, NTransitionState),

	\+isthere(BooleanState, NTransitionState, Shuffled),
	
	xy(TransitionState, NTransitionState),
	movedone(BooleanState, NTransitionState, holdf),
	sphere([\+BooleanState, AltState], NTransitionState, Shuffled, Path).
    !.

sphere([BooleanState|TransitionState], AltState, Shuffled, Path) :-
	move_transform(TransitionState, holdtwo, NTransitionState),

	\+isthere(BooleanState, NTransitionState, Shuffled),
	
	xy(TransitionState, NTransitionState),
	movedone(BooleanState, NTransitionState, holdtwo),
	sphere([\+BooleanState, AltState], NTransitionState, Shuffled, Path).
    !.




%----------------------------------------------------------------------------%
% verify
%     BooleanState: is a variable that represents the shuffled state with true and solved state with the value false. 
%     
%     Path: the list of moves required to change the shuffled state into the solved state
%     State: The state variable represents the current state of the 2x2x2 cube.
%     Test: Checks what state it is on.
%    
verify(BooleanState, Sta, Shuffled) :- BooleanState, fullpath(Shuffled, Sta, _).

verify(BooleanState, Sta, Shuffled) :- \+BooleanState, fullpath(state_zero(Temp), Sta, _)

%----------------------------------------------------------------------------%
% fullpath
%	Beginpath: whatever state the cube begins on
%	DeShuffled: finding the solved state of the cube
%	ListTransi: full transitions to complete states
%----------------------------------------------------------------------------%
% reversefnct
%	Beginpath: whatever state the cube begins on
%	DeShuffled: finding the solved state of the cube
%	ListTransi: full transitions to complete states
%----------------------------------------------------------------------------%
% shufftomid
%	Sta: the state
%	fin: finishing state of cube
%	trans: the tranisitions
%----------------------------------------------------------------------------%

% reversecheck
%	Sta: the state
%	Fin: finishing state of cube
%	Trans: the tranisitions


fullpath(Beginpath, DeShuffled, ListTransi) :-
	shufftomid(Beginpath, DeShuffled, [], Rever),
	rev(Rever, ListTransi).

shufftomid(Sta, Sta, Trans, [Temp|Trans]).
shufftomid(Sta, Fin, Trans, Rever):-
	legalnode(Sta, Trans, Nxt),
	shufftomid(Nxt, Fin, [zo(Sta, Mv)|Trans], Rever).

reversefnct(Beginpath, DeShuffled, ListTransi) :-
	reversecheck(Beginpath, DeShuffled, [], ListTransi).

reversecheck(Temp, Temp, Trans, [Temp|Trans]).
reversecheck(Sta, Fin, Trans, Rever):-
	legalnode(Sta, Trans, Nxt),
	reversecheck(Nxt, Fin, [xo(Sta, Mv)|Trans], Rever).





%----------------------------------------------------------------------------%
% transition
%     BooleanState: is a variable that represents the shuffled state with true and solved state with the value false. 
%     
%     Path: the list of moves required to change the shuffled state into the solved state
%     State: The state variable represents the current state of the 2x2x2 cube.
%     Test: Checks what state it is on.
%    

transition(BooleanState, Sta, Mv) :- BooleanState, zo(Sta, Mv).

transition(BooleanState, Sta, Mv) :- \+BooleanState, xo(Sta, reversal(Mv, RMv)).

%----------------------------------------------------------------------------%
