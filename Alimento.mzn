% Carga los datos iniciales desde el archivo .dzn
%include "./alimento1.dzn";

% Parámetros



% Variables de decisión
var float: X; 
var float: Y; 
var float: C;

% Restricciones
constraint CoeficienteX * X + CoeficienteY * Y >= LimiteRestriccion1;
constraint CoeficienteX2 * X + CoeficienteY2 * Y >= LimiteRestriccion2;
constraint X >= 0;
constraint Y >= 0;
constraint C = CoeficienteX3 * X + CoeficienteY3 * Y;

% Función objetivo
solve minimize C;

% Salida
output [show(X), ", ", show(Y), ", ", show(C)];
