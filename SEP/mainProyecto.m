clear; clc;

% Y = |Y|ang(Theta);  V = |V|ang(Delta)
%Y_dato = [0.1+0.1i, 0.2+0.2i, 0.3+0.3i; 0.1+0.1i, 0.2+0.2i, Inf; 0.1+0.1i, 0.2+0.2i, 0.3+0.3i];
%V_dato = [1+1i; 0.5+0.5i; Inf];
Y_dato = [inf inf inf; inf inf inf; inf inf inf];
V_dato = [inf inf inf];
num = size(V_dato);

[P, Q, VarListP, VarListQ, V_VarList, Y_VarList] = GetPQ(Y_dato, V_dato, num(1));   %Se obtienen las ecuaciones Pi, Qi y sus listas de variables
[Jac_P, Jac_Q] = GetJacobian(P, Q, VarListP, VarListQ);                             %Se obtienen las matrices jacobianas de las ecuaciones Pi y Qi 

evalJac_P = Jac_P;
evalJac_Q = Jac_Q;

    % Para el método de Newton Raphson, los valores iniciales de magnitudes
    % deben ser 1, para los ángulos deben ser 0.
for j = 1:size(VarListP')                                           %Se evaluan las variables de la lista del jacobiano de Pi
    if find(V_VarList == VarListP(j) | Y_VarList == VarListP(j))    %Si la variable que se está iterando es una magnitud de voltaje o de admitancia:
        evalJac_P = subs(evalJac_P, VarListP(j), 1);                %Se evalúa dicha variable en 1
    else
        evalJac_P = subs(evalJac_P, VarListP(j), 0);                %Se evalúa dicha variable en 0
    end
end

for j = 1:size(VarListQ')                                           %Se evaluan las variables de la lista del jacobiano de Pi
    if find(V_VarList == VarListQ(j) | Y_VarList == VarListQ(j))    %Si la variable que se está iterando es una magnitud de voltaje o de admitancia:
        evalJac_Q = subs(evalJac_Q, VarListQ(j), 1);                %Se evalúa dicha variable en 1
    else
        evalJac_Q = subs(evalJac_Q, VarListQ(j), 0);                %Se evalúa dicha variable en 0
    end
end
