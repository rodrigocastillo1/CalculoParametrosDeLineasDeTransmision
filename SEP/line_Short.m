%Programa que calcula los niveles de tensión y corriente de la línea en
%el extremo transmisor de la línea, utilizando los parámetros de la línea
%corta.

function LS = line_Short(V_op, I_op, Z)
    LS = lineMatrix(1, Z, 0, 1, V_op, I_op);