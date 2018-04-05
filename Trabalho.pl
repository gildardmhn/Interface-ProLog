


:- use_module(library(pce)).


%fatos

feminino(audhumla).
feminino(bestla).
feminino(frigg).
feminino(terra).
feminino(grid).
feminino(sif).
feminino(nanna).
feminino(skadi).
feminino(freya).
feminino(idun).
feminino(sigyn).
feminino(angrboda).
feminino(hel).



masculino(ymir).
masculino(buri).
masculino(bor).
masculino(vili).
masculino(ve).
masculino(thor).
masculino(vidar).
masculino(modi).
masculino(baldr).
masculino(forseti).
masculino(hoder).
masculino(njord).
masculino(freyr).
masculino(hermod).
masculino(bragi).
masculino(tyr).
masculino(heimdall).
masculino(loki).
masculino(narvi).
masculino(vali).
masculino(sleipnir).
masculino(fenrir).
masculino(jormungand).
masculino(gigante).
masculino(magni).
masculino(odin).



paiOuMae(ymir,gigante).
paiOuMae(audhumla,buri).
paiOuMae(buri,bor).
paiOuMae(gigante,bestla).
paiOuMae(gigante,loki).
paiOuMae(bor,vili).
paiOuMae(bor,ve).
paiOuMae(bor,odin).
paiOuMae(bestla,vili).
paiOuMae(bestla,ve).
paiOuMae(bestla,odin).
paiOuMae(odin,baldr).
paiOuMae(odin,hoder).
paiOuMae(odin,njord).
paiOuMae(odin,hermod).
paiOuMae(odin,bragi).
paiOuMae(odin,tyr).
paiOuMae(odin,heimdall).
paiOuMae(frigg,baldr).
paiOuMae(frigg,hoder).
paiOuMae(frigg,njord).
paiOuMae(frigg,hermod).
paiOuMae(frigg,bragi).
paiOuMae(frigg,tyr).
paiOuMae(frigg,heimdall).
paiOuMae(odin,thor).
paiOuMae(odin,vidar).
paiOuMae(terra,thor).
paiOuMae(grid,vidar).
paiOuMae(thor,magni).
paiOuMae(thor,modi).
paiOuMae(sif,magni).
paiOuMae(sif,modi).
paiOuMae(baldr,forseti).
paiOuMae(nanna,forseti).
paiOuMae(njord,freya).
paiOuMae(njord,freyr).
paiOuMae(skadi,freyr).
paiOuMae(skadi,freya).
paiOuMae(loki,hel).
paiOuMae(loki,sleipnir).
paiOuMae(loki,fenrir).
paiOuMae(loki,jormungand).
paiOuMae(loki,narvi).
paiOuMae(loki,vali).
paiOuMae(sigyn,narvi).
paiOuMae(sigyn,vali).
paiOuMae(angrboda,hel).
paiOuMae(angrboda,sleipnir).
paiOuMae(angrboda,fenrir).
paiOuMae(angrboda,jormungand).


conjugue(bor,bestla).
conjugue(bestla,bor).
conjugue(odin,frigg).
conjugue(frigg,odin).
conjugue(odin,terra).
conjugue(terra,odin).
conjugue(odin,grid).
conjugue(grid,odin).
conjugue(thor,sif).
conjugue(sif,thor).
conjugue(baldr,nanna).
conjugue(nanna,baldr).
conjugue(njord,skadi).
conjugue(skadi,njord).
conjugue(bragi,idun).
conjugue(idun,bragi).
conjugue(loki,sigyn).
conjugue(sigyn,loki).
conjugue(loki,angrboda).
conjugue(angrboda,loki).


%regras

pai(X,Y):- masculino(X), paiOuMae(X,Y).

mae(X,Y):- feminino(X), paiOuMae(X,Y).

filho(X,Y):- masculino(X), paiOuMae(Y,X).

filha(X,Y):- feminino(X), paiOuMae(Y,X).

filhos(X,Y):- paiOuMae(Y,X).

irma(X,Y):- feminino(X),paiOuMae(Z,X),paiOuMae(Z,Y), X\=Y.

irmao(X,Y):- masculino(X),paiOuMae(Z,X),paiOuMae(Z,Y), X\=Y.

irmaos(X,Y):- paiOuMae(Z,X), paiOuMae(Z,Y), X\=Y.

esposa(X,Y):- feminino(X), conjugue(X,Y).

marido(X,Y):- masculino(X), conjugue(X,Y).

tia(X,Y):- feminino(X), irma(X,Z), paiOuMae(Z,Y).

tio(X,Y):- masculino(X), irmao(X,Z), paiOuMae(Z,Y).

tios(X,Y):- irmaos(X,Z), paiOuMae(Z,Y).

avoM(X,Y):- masculino(X), pai(X,Z), paiOuMae(Z,Y).

avoF(X,Y):- feminino(X), mae(X,Z), paiOuMae(Z,Y).

avoMOuAvoF(X,Y):- paiOuMae(X,Z), paiOuMae(Z,Y).

neta(X,Y):- feminino(X), paiOuMae(Z,X), paiOuMae(Y,Z).

neto(X,Y):- masculino(X), paiOuMae(Z,X), paiOuMae(Y,Z).

netoOuNeta(X,Y):- filhos(X,Z), filhos(Z,Y).

primo(X,Y):- masculino(X), paiOuMae(Z,X),paiOuMae(W,Y), irmaos(Z,W).

prima(X,Y):- feminino(X), paiOuMae(Z,X), paiOuMae(W,Y), irmaos(Z,W).

primos(X,Y):- tios(A,X), paiOuMae(A,Y).



%interface Grafica

janela:- 
	new(D, dialog('Consulta unaria')),
	new(TB, text_item(consulta)),
	send(D, append, TB),
	send(D, append(button(pai_de,message(@prolog,pai_de,TB?selection)))),
	send(D, append(button(mae_de,message(@prolog,mae_de,TB?selection)),right)),
	send(D, append(button(filho_de,message(@prolog,filho_de,TB?selection)),below)),
	send(D, append(button(filha_de,message(@prolog,filha_de,TB?selection)),right)),
	send(D, append(button(filhos_de,message(@prolog,filhos_de,TB?selection)),below)),		
	send(D, append(button(irmaos_de,message(@prolog,irmaos_de,TB?selection)),right)),
	send(D, append(button(irmao_de,message(@prolog,irmao_de,TB?selection)),below)),
	send(D, append(button(irma_de,message(@prolog,irma_de,TB?selection)),right)),
	send(D, append(button(netos_de,message(@prolog,netos_de,TB?selection)),right)),	
	send(D, append(button(neto_de,message(@prolog,neto_de,TB?selection)),right)),
	send(D, append(button(neta_de,message(@prolog,neta_de,TB?selection)),below)),
	send(D, append(button(marido_de,message(@prolog,marido_de,TB?selection)),right)),
	send(D, append(button(esposa_de,message(@prolog,esposa_de,TB?selection)),right)),
	send(D, append(button(tios_de,message(@prolog,tios_de,TB?selection)),right)),
	send(D, append(button(tio_de,message(@prolog,tio_de,TB?selection)),right)),
	send(D, append(button(tia_de,message(@prolog,tia_de,TB?selection)),below)),
	send(D, append(button(primos_de,message(@prolog,primos_de,TB?selection)),right)),
	send(D, append(button(primo_de,message(@prolog,primo_de,TB?selection)),right)),
	send(D, append(button(prima_de,message(@prolog,prima_de,TB?selection)),right)),
	send(D, append(button(avos_de,message(@prolog,avos_de,TB?selection)),right)),
	send(D, append(button(avoM_de,message(@prolog,avoM_de,TB?selection)),right)),
	send(D, append(button(avoF_de,message(@prolog,avoF_de,TB?selection)),right)),
	get(D, confirm, Rval),
	Rval \== 0, 
	send(D, open).




filho_de(X):- 
	findall(Y,filho(Y,X),L),
	atomics_to_string(L,', ',S),
	new(D, dialog('filho')),
	send(D,append, text(S)),	
	send(D, open).

filha_de(X):- 
	findall(Y,filha(Y,X),L),
	atomics_to_string(L,', ',S),
	new(D, dialog('filha')),
	send(D,append, text(S)),	
	send(D, open).

filhos_de(X):- 
	findall(Y,filhos(Y,X),L),
	atomics_to_string(L,', ',S),
	new(D, dialog('filhos')),
	send(D,append, text(S)),	
	send(D, open).

pai_de(X):- 
	pai(Y,X),
	new(D, dialog('pai')),
	send(D, size, size(250, 100)),
	send(D, display, text('pai:'), point(0, 20)),
	send(D, display, text(Y),point(30,20)),	
	send(D, open).

mae_de(X):- 
	mae(Y,X),
	new(D, dialog('mae')),
	send(D, size, size(250, 100)),
	send(D, display, text('mae:'), point(0, 20)),
	send(D, display, text(Y),point(30,20)),
	send(D, open).

pais_de(X):-	
	findall(Y,filho(X,Y),L),
	atomics_to_string(L,', ',S),
	new(D, dialog('pais')),
	send(D,append, text(S)),	
	send(D, open).

irmaos_de(X):-	
	findall(Y,irmaos(X,Y),L),
	sort(L,L2),	
	atomics_to_string(L2,', ',S),
	new(D, dialog('irmaos')),
	send(D,append, text(S)),	
	send(D, open).

irmao_de(X):-	
	findall(Y,irmao(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('irmao')),
	send(D,append, text(S)),	
	send(D, open).

irma_de(X):-	
	findall(Y,irma(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('irma')),
	send(D,append, text(S)),	
	send(D, open).

marido_de(X):- 
	marido(Y,X),
	new(D, dialog('marido')),
	send(D, size, size(250, 100)),
	send(D, display, text('marido:'), point(0, 20)),
	send(D, display, text(Y),point(50,20)),	
	send(D, open).

esposa_de(X):- 
	esposa(Y,X),
	new(D, dialog('esposa')),
	send(D, size, size(250, 100)),
	send(D, display, text('esposa:'), point(0, 20)),
	send(D, display, text(Y),point(50,20)),	
	send(D, open).

tios_de(X):-	
	findall(Y,tios(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('tios')),
	send(D,append, text(S)),	
	send(D, open).

tio_de(X):-	
	findall(Y,tio(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('tio')),
	send(D,append, text(S)),	
	send(D, open).

tia_de(X):-	
	findall(Y,tia(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('tia')),
	send(D,append, text(S)),	
	send(D, open).

primos_de(X):-	
	findall(Y,primos(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('primos')),
	send(D,append, text(S)),	
	send(D, open).

primo_de(X):-	
	findall(Y,primo(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('primo')),
	send(D,append, text(S)),	
	send(D, open).

prima_de(X):-	
	findall(Y,prima(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('prima')),
	send(D,append, text(S)),	
	send(D, open).


avos_de(X):-	
	findall(Y,avoMOuAvoF(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('avos')),
	send(D,append, text(S)),	
	send(D, open).

	
avoM_de(X):-	
	findall(Y,avoM(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('avoM')),
	send(D,append, text(S)),	
	send(D, open).

avoF_de(X):-	
	findall(Y,avoF(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('avoF')),
	send(D,append, text(S)),	
	send(D, open).

netos_de(X):-	
	findall(Y,netoOuNeta(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('netos')),
	send(D,append, text(S)),	
	send(D, open).

neto_de(X):-	
	findall(Y,neto(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('neto')),
	send(D,append, text(S)),	
	send(D, open).

neta_de(X):-	
	findall(Y,neta(Y,X),L),
	sort(L,L2),
	atomics_to_string(L2,', ',S),
	new(D, dialog('neta')),
	send(D,append, text(S)),	
	send(D, open).





consulta_booleana:-
	new(D, dialog('Verdadeiro ou Falso')),
	new(X, text_item(objeto_x)),
	new(Y, text_item(objeto_y)),
	send(D, append,X),
	send(D, append,Y),
	send(D, append(button(filho_x_y_,message(@prolog,filho_, X?selection, Y?selection)))),
	send(D, append(button(filha_x_y_,message(@prolog,filha_, X?selection, Y?selection)),right)),	
	send(D, append(button(irmao_x_y_,message(@prolog,irmao_, X?selection, Y?selection)),right)),
	send(D, append(button(irma_x_y_,message(@prolog,irma_, X?selection, Y?selection)),right)),	
	send(D, append(button(pai_x_y_,message(@prolog,pai_, X?selection, Y?selection)),below)),
	send(D, append(button(mae_x_y_,message(@prolog,mae_, X?selection, Y?selection)),right)),
	send(D, append(button(marido_x_y_,message(@prolog,marido_, X?selection, Y?selection)),right)),
	send(D, append(button(esposa_x_y_,message(@prolog,esposa_, X?selection, Y?selection)),right)),
	send(D, append(button(tio_x_y_,message(@prolog,tio_, X?selection, Y?selection)),below)),
	send(D, append(button(tia_x_y_,message(@prolog,tia_, X?selection, Y?selection)),right)),
	send(D, append(button(primo_x_y_,message(@prolog,primo_, X?selection, Y?selection)),right)),
	send(D, append(button(prima_x_y_,message(@prolog,prima_, X?selection, Y?selection)),right)),
	send(D, append(button(avoM_x_y_,message(@prolog,avoM_, X?selection, Y?selection)),below)),
	send(D, append(button(avoF_x_y_,message(@prolog,avoF_, X?selection, Y?selection)),right)),
	send(D, append(button(neto_x_y_,message(@prolog,neto_, X?selection, Y?selection)),right)),
	send(D, append(button(neta_x_y_,message(@prolog,neta_, X?selection, Y?selection)),right)),
	send(D, append(button(filhos_x_y,message(@prolog,filhos_, X?selection, Y?selection)),below)),
	send(D, append(button(primos_x_y,message(@prolog,primos_, X?selection, Y?selection)),right)),
	send(D, append(button(tios_x_y,message(@prolog,tios_, X?selection, Y?selection)),right)),
	send(D, append(button(netos_x_y,message(@prolog,netos_, X?selection, Y?selection)),right)),
	send(D, append(button(avos_x_y,message(@prolog,avos_,X?selection, Y?selection)),below)),
	send(D, append(button(irmaos_x_y,message(@prolog,irmaos_,X?selection, Y?selection)),right)),
	get(D, confirm, Rval),
	Rval \== 0,
	send(D,open).

filho_(X,Y):- 
	filho(X,Y),
	new(D, dialog('filho')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+filho(X,Y),
	new(D, dialog('filho')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

filha_(X,Y):- 
	filha(X,Y),
	new(D, dialog('filha')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+filha(X,Y),
	new(D, dialog('filha')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).


irmao_(X,Y):- 
	irmao(X,Y),
	new(D, dialog('irmao')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+irmao(X,Y),
	new(D, dialog('irmao')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

irma_(X,Y):- 
	irma(X,Y),
	new(D, dialog('irma')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+irma(X,Y),
	new(D, dialog('irma')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

pai_(X,Y):- 
	pai(X,Y),
	new(D, dialog('pai')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+pai(X,Y),
	new(D, dialog('pai')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

mae_(X,Y):- 
	mae(X,Y),
	new(D, dialog('mae')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+mae(X,Y),
	new(D, dialog('mae')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

marido_(X,Y):- 
	marido(X,Y),
	new(D, dialog('marido')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+marido(X,Y),
	new(D, dialog('marido')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).
esposa_(X,Y):- 
	esposa(X,Y),
	new(D, dialog('esposa')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+esposa(X,Y),
	new(D, dialog('esposa')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

tio_(X,Y):- 
	tio(X,Y),
	new(D, dialog('tio')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+tio(X,Y),
	new(D, dialog('tio')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

tia_(X,Y):- 
	tia(X,Y),
	new(D, dialog('tia')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+tia(X,Y),
	new(D, dialog('tia')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

primo_(X,Y):- 
	primo(X,Y),
	new(D, dialog('primo')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+primo(X,Y),
	new(D, dialog('primo')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

prima_(X,Y):- 
	prima(X,Y),
	new(D, dialog('prima')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+prima(X,Y),
	new(D, dialog('prima')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

avoM_(X,Y):- 
	avoM(X,Y),
	new(D, dialog('avoM')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+avoM(X,Y),
	new(D, dialog('avoM')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

avoF_(X,Y):- 
	avoF(X,Y),
	new(D, dialog('avoF')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+avoF(X,Y),
	new(D, dialog('avoF')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

neto_(X,Y):- 
	neto(X,Y),
	new(D, dialog('neto')),
	new(T, text_item('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+neto(X,Y),
	new(D, dialog('neto')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

neta_(X,Y):- 
	neta(X,Y),
	new(D, dialog('neta')),
	new(T, text('true')),
	send(D, append,T),
	send(D, open) 
	;
	\+neta(X,Y),
	new(D, dialog('neta')),
	new(T, text('false')),
	send(D, append,T),
	send(D, open).

filhos_x_y(X,Y):-
	filhos(X,Y),
	new(D, dialog('Filhos')),
	new(T, text('true')),
	send(D, append, T),
	send(D, open)
	;
	filhos(X,Y),
	new(D, dialog('Filhos')),
	new(T, text('false')),
	send(D, append, T),
	send(D, open).


primos_x_y(X,Y):-
	primos(X,Y),
	new(D, dialog('Primos')),
	new(T, text('true')),
	send(D, append, T),
	send(D, open)
	;
	primos(X,Y),
	new(D, dialog('Primos')),
	new(T, text('false')),
	send(D, append, T),
	send(D, open).

irmaos_x_y(X,Y):-
	irmaos(X,Y),
	new(D, dialog('Irmaos')),
	new(T, text('true')),
	send(D, append, T),
	send(D, open)
	;
	irmaos(X,Y),
	new(D, dialog('Irmaos')),
	new(T, text('false')),
	send(D, append, T),
	send(D, open).

tios_x_y(X,Y):-
	tios(X,Y),
	new(D, dialog('Tios')),
	new(T, text('true')),
	send(D, append, T),
	send(D, open)
	;
	tios(X,Y),
	new(D, dialog('Tios')),
	new(T, text('false')),
	send(D, append, T),
	send(D, open).

avos_x_y(X,Y):-
	avoMOuavoF(X,Y),
	new(D, dialog('Avos')),
	new(T, text('true')),
	send(D, append, T),
	send(D, open)
	;
	avoMOuavoF(X,Y),
	new(D, dialog('Avos')),
	new(T, text('false')),
	send(D, append, T),
	send(D, open).

netos_x_y(X,Y):-
	netoOuNeta(X,Y),
	new(D, dialog('Netos')),
	new(T, text('true')),
	send(D, append, T),
	send(D, open)
	;
	netoOuNeta(X,Y),
	new(D, dialog('Netos')),
	new(T, text('false')),
	send(D, append, T),
	send(D, open).


menu(Meu):- 
    	new(D,dialog('Menu')),
		send(D, append(button(consulta_unaria,message(@prolog,janela)))),  
    	send(D, append(button(consulta_booleana,message(@prolog,consulta_booleana)))),
    	send(D, append,button(fechar, message(D, destroy),below)),
		get(D, confirm, Rval),
    	Rval \== 0,
    	Meu = Rval,
    	send(D,open).



:-menu(X).
