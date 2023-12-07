%Lectura de datos:
include "./PUEnTeGUIFuentes/parametros.dzn";
int: J;
int: K;
array[1..J] of int: E; %  el costo de encender la utpee j
array[1..J] of float: A; % el costo de apagar la utpee j.
array[1..J] of int: G; % el indicador de si la planta j terminó generando energía o no en el horizonte
array[1..J] of int: F; % el costo fijo de la operación de la utpee j.
array[1..J] of float: V; % el coeficiente para calcular el costo variable de encender la utpee j.
array[1..J] of int: piso; % el límite inferior de generación de potencia de la utpee j.
array[1..J] of int: techo;% el límite superior de generación de potencia de la utpee j.
array[1..J] of int: Sup;%  el límite superior de ampliación de potencia para la utpee j.
array[1..J] of int: Inf;%  el límite inferior de reducción de potencia para la utpee j.
array[1..J] of int: P;% P_0  la potencia generada por la utpee j justo antes de iniciar el horizonte de planificación.
array[1..K] of int: D;%  Representa la demanda global de energía para el periodo k.
array[1..K] of int: R;% la reserva especificada de energía para el periodo k.


%Variables:
array[1..J,1..K] of var int: p; % la potencia generada de la utpee j en el periodo k.
array[1..J,1..K] of var 0..1: w;% si se está generando energía la utpee j en el periodo k, toma valores de 0 o 1.
array[1..J,1..K] of var 0..1: e;% se encendió la utpee j en el periodo k, toma valores de 0 o 1.
array[1..J,1..K] of var 0..1: a;% se apagó la utpee j en el periodo k,toma valores de 0 o 1.

%Restricciones:

%
constraint forall(k in 1..K)(
  forall(j in 1..J)(p[j,k]>=0)
);

%LIMITE INFERIOR Y SUPERIOR
%1
constraint forall(k in 1..K)(
    forall(j in 1..J)((p[j,k] >= 0 /\ p[j,k] <= 0) \/  (p[j,k] >= piso[j]))
);

%2

constraint forall(k in 1..K)(
  forall(j in 1..J)(p[j,k]<=techo[j])
);


% LIMITE EN EL INCREMETO Y EL DECREMETO DE UNA UTPEE (Enteras)
%3 

constraint forall(k in 2..K)(
  forall(j in 1..J)(if p[j,k] > 0 /\ p[j,k-1] > 0 then  (p[j,k] - p[j,k-1]) <= Sup[j] else true endif ) 
);

%4

constraint forall(k in 2..K)(
  forall(j in 1..J)( if p[j,k] > 0 /\ p[j,k-1] > 0 then   ( p[j,k-1] - p[j,k]) <= Inf[j] else true endif  )  
);


%5 DEMANDA GLOBAL PARA UN PERIODO (Enteras)

constraint forall(k in 1..K)(
  sum(j in 1..J)(p[j,k]) = D[k]
);

%6 DEMANDA DE RESERVA (Entera) 

constraint forall(k in 1..K)(
  sum(j in 1..J)(techo[j] * w[j,k]) >= (D[k] + R[k])
);

%7 y 8 SABER CUANDO LA UTPEE GENERA ENERGÍA (Entera y binaria) 
constraint forall(k in 1..K)(
  forall(j in 1..J)(if (p[j,k] > 0) then w[j,k] = 1 else w[j,k] = 0 endif)
);


%9  SABER CUANDO LA UTPEE SE ENCIENDE (Entera y binaria) 
constraint forall(k in 2..K)(
  forall(j in 1..J)(if (p[j,k-1] = 0 /\ p[j,k]  > 0) then e[j,k] = 1 else e[j,k] = 0 endif)
);

%10   SABER CUANDO LA UTPEE SE APAGA 
constraint forall(k in 2..K)(
  forall(j in 1..J)(if (p[j,k-1] > 0 /\ p[j,k] = 0) then a[j,k] = 1 else a[j,k] = 0 endif)
);



%11 SABAR SI ENCIENDE EN EL PERIODO 1  - k=1

constraint forall(k in 1..1)(
  forall(j in 1..J)(if ( G[j] = 0 /\ p[j,k]  > 0) then e[j,k] = 1 else e[j,k] = 0 endif)
);

%12 SABAR SI SE APAGA EN EL PERIODO 1  - k=1

constraint forall(k in 1..1)(
  forall(j in 1..J)(if ( G[j] = 1 /\ p[j,k]  = 0) then a[j,k] = 1 else a[j,k] = 0 endif)
);

%13 RESTRINGIR EL INCREMETO EN EL PERIODO 1, EN CASO DE QUE VENGA GENERANDO

constraint forall(k in 1..1)(
  forall(j in 1..J)(if ( G[j] = 1 /\ p[j,k]  > 0 /\ P[j]  > 0) then p[j,k]  - P[j] <= Sup[j] else true endif)
);

%14 RESTRINGIR EL DECREMENTO EN EL PERIODO 1, EN CASO DE QUE VENGA GENERANDO

constraint forall(k in 1..1)(
  forall(j in 1..J)(if ( G[j] = 1 /\ p[j,k]  > 0 /\ P[j]  > 0) then  P[j] - p[j,k]  <= Inf[j] else true endif)
);

% Programación Entera Mixta (MIP): un IP donde algunas de las
% variables son enteras y otras continuas
% MINLP: un MIP con funciones no lineales

var float: costo_total;

constraint costo_total = sum(k in 1..K)(
    sum(j in 1..J)(F[j]*w[j,k] + V[j]*p[j,k] + E[j]*e[j,k] +  A[j]*a[j,k])
);

solve minimize costo_total;



output["\(costo_total);"];
output["\(p)"];
