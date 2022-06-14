verify(S, P, _) :- atomic(P), holds(S, P).
verify(S, neg(P), Path) :- not verify(S, P, Path).
verify(S, or(P, Q), Path) :- verify(S, P, Path).
verify(S, or(P, Q), Path) :- verify(S, Q, Path).
verify(S, x(P), Path) :- member(trans(S, S1), Path), verify(S1, P, Path).


verify(_, true, _).
%verify(S, f(P), Path) :- verify(S, u(true, P), Path).
verify(S, f(P), Path) :- verify(S, P, Path).
verify(S, f(P), Path) :- member(trans(S, S1), Path), verify(S1, P, Path).

verify(S, g(P), Path) :- coverify(S, g(P), Path).

coverify(S, g(P), Path) :- verify(S, and(P, x(g(P))), Path).
verify(S, and(P, Q), Path) :- verify(S, P, Path), verify(S, Q, Path).

verify(S, P) :- co_path(S, Path), verify(S, P, Path).

not_atomic(and(_,_)).
not_atomic(or(_,_)).
not_atomic(f(_)).
not_atomic(g(_)).
not_atomic(x(_)).
atomic(X) :- not not_atomic(X).



co_path(S, P) :-
    co_path(S, [], P).
    %reverse(P, P1).

co_path(S, V, [trans(S, S1)|V]) :- trans(S, S1), member_state(S1, V).

co_path(S, V, P) :-
      trans(S, S1),
      has_trans(S1),
      not member_state(S1, V),
      co_path(S1, [trans(S, S1)|V], P).

reverse(List, R) :-
     reverse(List, [], R).

reverse([H|T], P, R) :-
       reverse(T, [H|P], R).

reverse([], P, P).

member(H, [H|_]).
member(H, [X|T]) :- H \= X, member(H, T).


member_state(S, [trans(S, _)|_]).
member_state(S, [trans(_, S)|_]).
member_state(S, [trans(S1, S2)|T]) :- S \= S1, S \= S2, member_state(S, T).

has_trans(S) :- trans(S, _).


trans(s1, s2).
trans(s2, s3).
trans(s3, s4).
trans(s4, s2).
trans(s4, s1).

holds(s2, p).
holds(s3, p).
holds(s4, p).


?- verify(s2, g(p)).
?- verify(s1, f(g(p))).	
