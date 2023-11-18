%Lectura de datos:
include "./PUEnTeGUIFuentes/parametros.dzn";
include "ide/vis.mzn";
int: J;
int: K;
array[1..J] of int: E;
array[1..J] of float: A;
array[1..J] of int: G;
array[1..J] of int: F;
array[1..J] of float: V;
array[1..J] of int: piso;
array[1..J] of int: techo;
array[1..J] of int: Sup;
array[1..J] of int: Inf;
array[1..J] of int: P;
array[1..K] of int: D;
array[1..K] of int: R;


%Variables:
array[1..J,1..K] of var int: p;
array[1..J,1..K] of var 0..1: w;
array[1..J,1..K] of var 0..1: e;
array[1..J,1..K] of var 0..1: a;

%Restricciones:

%
constraint forall(k in 1..K)(
  forall(j in 1..J)(p[j,k]>=0)
);

%1
constraint forall(k in 1..K)(
    forall(j in 1..J)((p[j,k] >= 0 /\ p[j,k] <= 0) \/  (p[j,k] >= piso[j]))
);

%2

constraint forall(k in 1..K)(
  forall(j in 1..J)(p[j,k]<=techo[j])
);

%3

constraint forall(k in 2..K)(
  forall(j in 1..J)(if p[j,k] > 0 /\ p[j,k-1] > 0 then  (p[j,k] - p[j,k-1]) <= Sup[j] else true endif ) 
);

%4

constraint forall(k in 2..K)(
  forall(j in 1..J)( if p[j,k] > 0 /\ p[j,k-1] > 0 then   ( p[j,k-1] - p[j,k-1]) <= Inf[j] else true endif  )  
);

%5

constraint forall(k in 1..K)(
  sum(j in 1..J)(p[j,k]) = D[k]
);

%6

constraint forall(k in 1..K)(
  sum(j in 1..J)(techo[j] * w[j,k]) >= (D[k] + R[k])
);

%7 y 8
constraint forall(k in 1..K)(
  forall(j in 1..J)(if (p[j,k] > 0) then w[j,k] = 1 else w[j,k] = 0 endif)
);


%9       if (pjk-1=0) and  (pjk>0) entonces (ejk=1 )  else (ejk=0 )
constraint forall(k in 2..K)(
  forall(j in 1..J)(if (p[j,k-1] = 0 /\ p[j,k]  > 0) then e[j,k] = 1 else e[j,k] = 0 endif)
);

%10   if (pjk-1>0) and  (pjk=0)  entonces (ajk=1)  else (ajk=0) 
constraint forall(k in 2..K)(
  forall(j in 1..J)(if (p[j,k-1] > 0 /\ p[j,k] = 0) then a[j,k] = 1 else a[j,k] = 0 endif)
);



%11

constraint forall(k in 1..1)(
  forall(j in 1..J)(if ( G[j] = 0 /\ p[j,k]  > 0) then e[j,k] = 1 else e[j,k] = 0 endif)
);

%12

constraint forall(k in 1..1)(
  forall(j in 1..J)(if ( G[j] = 1 /\ p[j,k]  = 0) then a[j,k] = 1 else a[j,k] = 0 endif)
);

%13

constraint forall(k in 1..1)(
  forall(j in 1..J)(if ( G[j] = 1 /\ p[j,k]  > 0 /\ P[j]  > 0) then p[j,k]  - P[j] <= Sup[j] else true endif)
);

%14

constraint forall(k in 1..1)(
  forall(j in 1..J)(if ( G[j] = 1 /\ p[j,k]  > 0 /\ P[j]  > 0) then  P[j] - p[j,k]  <= Inf[j] else true endif)
);



var float: costo_total;

constraint costo_total = sum(k in 1..K)(
    sum(j in 1..J)(F[j]*w[j,k] + V[j]*p[j,k] + E[j]*e[j,k] +  A[j]*a[j,k])
);

solve minimize costo_total;



output["\(costo_total);"];
output["\(p);"];