roundName(2,final).
roundName(4,semi_finals).
roundName(8,quarter_finals).
roundName(16,round_four).
roundName(32,round_five).
roundName(64,round_six).
roundName(128,round_seven).
roundName(256,round_eight).

schedule_round(N,Res):-
               X is N/2,
               elements(1,X,Y),
               X1 is X+1,
               elements(X1,N,Z),
               opp(N,Y,Z,Res).

opp(_,[],[],[]).
opp(N,[X|S],[Y|Z],[W|Res]):-
                   roundName(N,A),
                   member(E,[Y|Z]),
                   W = game(X,E,A),
                   delete([Y|Z],E,R),
                   opp(N,S,R,Res).

schedule_rounds(1,[]).
schedule_rounds(N,[S|Res]):-
        N >=2,
        N1 is N/2,
        schedule_round(N,S),
        schedule_rounds(N1,Res).

game(S1,S2,_RN):-
                 S1 < S2.

elements(S,S,[S]).
elements(S,E,[S|Res]) :-
    S =< E,
    S1 is S+1,
    elements(S1,E,Res).

tournament(N,D,S):-
        schedule_rounds(N,X),
        helperr(D,X,S).

helperr(0,[],[]).
helperr(D,[H|T],S):-
        divide(D,Dl,H,Lp),
        helperr(Dl,T,Lp2),
        append(Lp,Lp2,S).
divide(D,D,[],[]).

divide(D,Dl,List,RR):-
     member(X,List),
     delete(List,X,R),
     Lp = [[X]],
     divide(D,DD,R,Res),
     append(Lp,Res,RR),
     Dl is DD - 1 .

divide(D,Dl,List,RR):-
        member(X,List),
        delete(List,X,R),
        member(Y,R),
        ((X \= game(1,_,_));(X = game(1,_,_),Y\=game(2,_,_))),
        X @< Y ,
        delete(R,Y,FF),
        Lp = [[X,Y]],
        divide(D,DD,FF,Res),
        append(Lp,Res,RR),
        Dl is DD - 1.

divide(D,Dl,List,RR):-
        member(X,List),
        delete(List,X,R),
        member(Y,R),
        ((X \= game(1,_,_));(X = game(1,_,_),Y\=game(2,_,_))),
        X @< Y ,
        delete(R,Y,Z),
        member(F,Z),
        Y @< F ,
        delete(Z,F,ZZ),
        Lp = [[X,Y,F]],
        divide(D,DD,ZZ,Res),
        append(Lp,Res,RR),
        Dl is DD - 1.























