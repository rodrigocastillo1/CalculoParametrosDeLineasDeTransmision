%Programa que devuelve una matriz de 2x3, donde la primera fila corresponde
%a los valores de tensión en la terminar de transmisión, la segunda
%corresponde a los valores de corriente de la terminal de transmisión.
%La primera columna corresponde a los valores calculados con parámetros de
%línea corta, la segunda con parámetro de línea media y la tercera con
%parámetros de línea larga.


function T = trasmision_Results(d, secc_trans, t1, t2, f, DMG, RMG, V, P, fp)

    R = tempFunctionRes(getRca(d, secc_trans, 5), t1, t2);
    
    r_L = lineInductiveReactance(f, d, DMG, RMG);
    XL = r_L(1);
    
    s_C = lineCapacitiveSusceptance(f, d, DMG, RMG);
    BC = s_C(1);
    
    Z = R + (1i*XL);
    Y = 1i*BC;
    
    V_op = V/sqrt(3);
    I_op = operationCurrent(V, P, fp);
    
    s = line_Short(V_op, I_op, Z);
    m = line_Medium(V_op, I_op, Z, Y);
    l = line_Long(V_op, I_op, Z, Y);
    
    T = [s, m, l];