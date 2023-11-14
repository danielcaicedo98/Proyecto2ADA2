%Lectura de datos:
include "./parametros.dzn";
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
  forall(j in 1..J)((p[j,k] - p[j,k-1]) <= Sup[j]) 
);

%4

constraint forall(k in 2..K)(
  forall(j in 1..J)(( p[j,k-1] - p[j,k-1]) <= Inf[j]) 
);

%5

constraint forall(k in 1..K)(
  sum(j in 1..J)(p[j,k]) = D[k]
);

%6

constraint forall(k in 1..K)(
  sum(j in 1..J)(techo[j] * w[j,k]) >= (D[k] + R[k])
);

%7

constraint forall(k in 1..K)(
  forall(j in 1..J)(if (p[j,k] > 0) then w[j,k] = 1 else w[j,k] = 0 endif)
);

%8

%constraint forall(k in 1..K)(
%  forall(j in 1..J)(if (p[j,k] >= 0 /\ p[j,k] <= 0) then w[j,k] = 0 else true endif)
%);

%9

%constraint forall(k in 2..K)(
%  forall(j in 1..J)(if (p[j,k-1] >= 0 /\ p[j,k-1] <= 0) then (e[j,k] = 0 \/ e[j,k] = 1) else true endif)
%);


constraint forall(k in 2..K)(
  forall(j in 1..J)(if ((p[j,k-1] >= 0 /\ p[j,k-1] <= 0) /\ p[j,k] > 0) <= 0 then e[j,k-1] = 1 else e[j,k-1] = 0 endif)
);


%10

%constraint forall(k in 2..K)(
%  forall(j in 1..J)(if (p[j,k-1] > 0) then (a[j,k] = 1 \/ a[j,k] = 0) else true endif)
%);

constraint forall(k in 2..K)(
  forall(j in 1..J)(if ( p[j,k-1] > 0 /\ (p[j,k] >= 0 /\ p[j,k] <= 0 )) <= 0 then a[j,k] = 1 else a[j,k] = 0 endif)
);


var float: potencia;

constraint potencia = sum(k in 1..K)(
    sum(j in 1..J)(F[j] + V[j]*p[j,k] + E[j]*e[j,k] +  A[j]*a[j,k])
);

solve minimize potencia;

output["\(potencia);\(p)"];