% Arthur Bridi Guazzelli
% 15100720

/*
   Programacao Logica - Prof. Alexandre G. Silva - 30set2015

   RECOMENDACOES:

   - O nome deste arquivo deve ser 'programa.pl'

   - O nome do banco de dados deve ser 'desenhos.pl'

   - Dicas de uso podem ser obtidas na execucação:
     ?- menu.

   - Exemplo de uso:
     ?- load.
     ?- searchAll(id1).
*/

% Apaga os predicados 'xy' da memoria e carrega os desenhos a partir de um arquivo de banco de dados
load :-
    retractall(xy(_,_,_)),
    open('desenhos.pl', read, Stream),
    repeat,
        read(Stream, Data),
        (Data == end_of_file -> true ; assert(Data), fail),
        !,
        close(Stream).

% Ponto de deslocamento, se <Id> existente
new(Id,X,Y) :-
    xy(Id,_,_),
    assertz(xy(Id,X,Y)),
    !.

% Ponto inicial, caso contrario
new(Id,X,Y) :-
    asserta(xy(Id,X,Y)),
    !.

% Exibe opcoes de busca
search :-
    write('searchAll(Id).     -> Ponto inicial e todos os deslocamentos de <Id>'), nl,
    write('searchFirst(Id,N). -> Ponto inicial e os <N-1> primeiros deslocamentos de <Id>'), nl,
    write('searchLast(Id,N).  -> Lista os <N> ultimos deslocamentos de <Id>').

searchAll(Id) :-
    listing(xy(Id,_,_)).

searchFirst(Id, N) :-
    listPoints(Id, L),
    between(0, N, I),
        nth1(I, L, P),
        write(P),
        nl,
        false;true.

searchLast(Id, N) :-
    reverse(L, RL),
    listPoints(Id, L),
    between(0, N, I),
        nth1(I, RL, P),
        write(P),
        nl,
        false;true.

% Exibe opcoes de alteracao
change :-
    write('change(Id,X,Y,Xnew,Ynew).  -> Altera um ponto de <Id>'), nl,
    write('changeFirst(Id,Xnew,Ynew). -> Altera o ponto inicial de <Id>'), nl,
    write('changeLast(Id,Xnew,Ynew).  -> Altera o deslocamento final de <Id>').

change(Id, X, Y, Xnew, Ynew) :-
    listPoints(Id, L1),
    length(L1, Length),
    nth0(I, L1, [Id, X, Y], Temp),
    nth0(I, L2, [Id, Xnew, Ynew], Temp),
    retractall(xy(Id, _, _)),
    between(0, Length, Index),
        nth0(Index, L2, P),
        nth0(1, P, Xt),
        nth0(2, P, Yt),
        new(Id, Xt, Yt),
        false;true.

changeFirst(Id, Xnew, Ynew) :-
    retract(xy(Id, _, _)),
    !,
    asserta(xy(Id, Xnew, Ynew)).

changeLast(Id, Xnew, Ynew) :-
    removeLast(Id),
    assertz(xy(Id, Xnew, Ynew)).

% Exibe opcoes de remoção
remove :-
    write('remove(Id, X, Y).    -> Remove um ponto especifico de <Id>'),
    write('removeLast(Id).      -> Remove o último ponto de <Id>').

remove(Id, X, Y) :-
    retract(xy(Id, X, Y)).

removeLast(Id) :-
    listPoints(Id, L),
    last(L, Last),
    nth0(1, Last, Xt),
    nth0(2, Last, Yt),
    remove(Id, Xt, Yt).

% Desfaz o último ponto inserido
undo :-
    listPoints(_, L),
    last(L, Last),
    nth0(0, Last, Id),
    nth0(1, Last, X),
    nth0(2, Last, Y),
    remove(Id, X, Y).

% Grava os desenhos da memoria em arquivo
commit :-
    open('desenhos.pl', write, Stream),
    telling(Screen),
    tell(Stream),
    listing(xy),
    tell(Screen),
    close(Stream).

quadrado(Id, X, Y, Lado) :-
    N is (-1) * Lado,
    new(Id, X, Y),
    new(Id, Lado, 0),
    new(Id, 0, Lado),
    new(Id, N, 0).

figura(Id, X, Y) :-
    A is 50,
    Na is (-1)*A,
    new(Id, X, Y),
    new(Id, A, 0),
    new(Id, A, A),
    new(Id, 0, A),
    new(Id, Na, A),
    new(Id, Na, 0),
    new(Id, Na, Na),
    new(Id, 0, Na).

% replica(Id, N, Dx, Dy) :-

% Exibe menu principal
menu :-
    write('load.        -> Carrega todos os desenhos do banco de dados para a memoria'), nl,
    write('new(Id,X,Y). -> Insere um deslocamento no desenho com identificador <Id>'), nl,
    write('                (se primeira insercao, trata-se de um ponto inicial)'), nl,
    write('search.      -> Consulta pontos dos desenhos'), nl,
    write('change.      -> Modifica um deslocamento existente do desenho'), nl,
    write('remove.      -> Remove um determinado deslocamento existente do desenho'), nl,
    write('undo.        -> Remove o deslocamento inserido mais recentemente'), nl,
    write('commit.      -> Grava alteracoes de todos dos desenhos no banco de dados').

% Aux
listPoints(Id, L) :-
    findall(P,
            (xy(Id, X, Y), append([Id], [X], Temp), append(Temp, [Y], P)),
            L).
