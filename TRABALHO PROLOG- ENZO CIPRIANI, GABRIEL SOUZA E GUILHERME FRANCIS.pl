/* ........................NOMES....................
 Enzo Gabriel Cipriani Pinto
 Gabriel Souza de Oliveira
 Guilherme Francis Caravalho*/


/*...................PRIMEIRA PARTE...........*/

/*........A.........*/

        adicionar_no_final([], N, [N]).
        adicionar_no_final([I|R], Y, [I|R1]) :-
        adicionar_no_final(R, Y, R1).
/* percorre a lista inteira ate encontrar o fim e insere o elemento*/


/*........B.........*/

        insira(X,0,Y, [X|Y]).
        insira(X,Z,[A|Y], [A|L1]) :-Z1 is Z-1,
        insira(X,Z1,Y,L1).
/* percorre ate encontrar a posição passada, e insere o elemento passado naquela posicao */


/*........C.........*/

        remove(1, [_|X], X).
        remove(A, [B|X], [B|Z]) :-
        remove(A, [X], Z).
/* percorre ate uma posição e remove o elemento dela*/

/*........D.........*/

        maior_valor([R],R).
        maior_valor([C|L],R) :- maior_valor(L,A), (A > C -> R = A; R = C).
/* percorre todos os numeros recebidos e retorna qual o maior numero*/


/*........E.........*/
        conc([ ], A, A).
        conc([C|B1], B2, [C|B3]) :-
        conc(B1, B2, B3).

        inverte([],[]).
        inverte([C|R], LI) :-
        inverte(R, B),
        conc(B, [C], LI).
/*percorre todos itens da lista e retorna todos no seu inverso usando concatenação */







/*...............................SEGUNDA PARTE.............................................*/

/* .............................DECLARACAO DE FATOS............................................ */

/* ..............................GENERO MASCULINO........................................... */
masculino(george).
masculino(philip).
masculino(kydd).
masculino(charles).
masculino(mark).
masculino(william).
masculino(harry).
masculino(peter).
masculino(james).
masculino(andrew).
masculino(edward).

/* ..............................GENERO FEMININO........................................... */

feminino(mum).
feminino(elizabeth).
feminino(margaret).
feminino(spencer).
feminino(diana).
feminino(anne).
feminino(zara).
feminino(sarah).
feminino(beatrice).
feminino(eugenie).
feminino(sohpie).
feminino(louise).

/* ..............................PROGENITORES........................................... */

progenitor(george, elizabeth).
progenitor(george, margaret).
progenitor(philip, charles).
progenitor(philip, anne).
progenitor(philip, andrew).
progenitor(philip, edward).
progenitor(spencer, diana).
progenitor(charles, william).
progenitor(charles, harry).
progenitor(mark, peter).
progenitor(mark, zara).
progenitor(andrew, beatrice).
progenitor(andrew, eugenie).
progenitor(edward, louise).
progenitor(edward, james).
progenitor(mum, elizabeth).
progenitor(mum, margeret).
progenitor(elizabeth, charles).
progenitor(elizabeth, anne).
progenitor(elizabeth, andrew).
progenitor(elizabeth, edward).
progenitor(kydd, diana).
progenitor(diana, william).
progenitor(diana, harry).
progenitor(anne, peter).
progenitor(anne, zara).
progenitor(sarah, beatrice).
progenitor(sarah, eugenie).
progenitor(sophie, louise).
progenitor(sophie, james).

/* ..............................CASAL........................................... */

casal(george,mum).
casal(philip,elizabeth).
casal(kydd,spencer).
casal(charles,diana).
casal(mark,anne).
casal(andrew,sarah).
casal(edward,sophie).


/* ..............................PREDICADOS........................................... */

/*  Para que uma pessoa qualquer(A) seja neto ou neta de uma pessoa (C), ela
precisa ser filho do filho de (C)
    que nesse caso seria, (C) eh pai de (B) e (B) precisa ser pai de (A), para que (A) seja neto ou neta */
        netoouneta(A,C) :- progenitor(C,B), progenitor(B,A).


/* Para que uma pessoa qualquer(D) seja bisavo de (C), essa pessoa precisa ser pai do avo de (C), ou seja, usando a logica do excercio anterior,
   basta acrescentarmos mais um progenitor, que seria o pai dos avos de (C)  */
        bisavo(D,C) :- progenitor(D,A), progenitor(A,B), progenitor(B,C).


/* (A) eh um ancestral de (C) se existe um (B), tal que,(A) seja genitor de (B) e (B) seja um descendente de (C). Nesse caso precisamos fazer o uso da regra recursiva,
   para que assim forneça todos os ancestrais e não uma forma direta de mostrar apenas o ultimo ancestral e sim em ordem ate chegar ao ultimo */
        ancestral(A,C) :-progenitor(A,C).
        ancestral(A,C) :-progenitor(B,C), ancestral(A,B).


/* Para que uma pessoal qualquer (A) seja irmao de uma pessoa qualquer (B) eh preciso que
   tenham os mesmos progenitores, e a pessoa (A) precisa ser do sexo masculino:*/
        irmao(A,B) :- progenitor(C,A),progenitor(C,B),masculino(A), not(A=B).


/* Para que uma pessoal qualquer (A) seja irma de uma pessoa qualquer (B) eh preciso que
   tenham os mesmos progenitores, e a pessoa (A) precisa ser do sexo feminino:*/
        irma(A,B) :- progenitor(C,A), progenitor(C,B), feminino(A), not(A=B).


/* Para que uma pessoa qualquer (A) seja filho de uma pessoa qualquer (B), a pessoa (B)
   precisa ser progenitor de (A), e a pessoa (A) precisa ser do sexo masculino:*/
        filho(A,B) :- progenitor(B,A), masculino(A).


/* Para que uma pessoa qualquer (A) seja filha de uma pessoa qualquer (B), a pessoa (B)
   precisa ser progenitor de (A), e a pessoa (A) precisa ser do sexo feminino:*/
        filha(A,B) :- progenitor(B,A), feminino(A).


/* Para que uma pessoa qualquer (A) seja primo de uma pessoa qualquer (B), precisam ter avos em comum,
   sendo que (A) e (B) nao podem ser a mesma pessoa e nao podem ser irmaos.*/
        primoirmao(A,B) :- netoouneta(A,C), netoouneta(B,C), masculino(A), not(A=B), not(irmao(A,B)).


/* Uma pessoa qualquer (A) eh cunhado de uma pessoa (C) por (A) ser casado com uma pessoa (B),
   e (B) ser irmao de (C). E tambem Uma pessoa qualquer (A) eh cunhado de uma pessoa (C) por (C)
   ser casado com uma pessoa (B),sendo (B) irmao da pessoa (A).*/
        cunhado(A,C) :- casal(B,C), irmao(A,B).
        


/* Para cunhadas:*/
        cunhada(A,C) :- casal(B,C), irma(A,B).
        


/* Para uma pessoa qualquer (A), ser tio de (B), ela precisa ser irmao dos progenitores de (B)*/
        tio(A,B):- irmao(A,C), progenitor(C,B).


/* Para uma pessoa qualquer (A), ser tia de (B), ela precisa ser irma dos progenitores de (B)*/
        tia(A,B):- irma(A,C), progenitor(C,B).
