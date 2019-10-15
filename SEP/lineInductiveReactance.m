%La función lineInductiveReactance calcula la reactancia inductiva total por fase de
%una línea de transmisión de CA en Ohms. Para el cálculo debe recibir como 
%parámetros de entrada:
%- La frecuencia de operación de la línea en Hz
%- La longitud total de la línea en km
%- El diámetro medio geométrico del arreglo en m
%- El radio medio geométrico del conductor en m

function XL_L = lineInductiveReactance(f, d, DMG_L, RMG_L)
    l = (2*10^(-7))*log(DMG_L/RMG_L);   %inductividad por unidad de longitud en H/m
    L = l*d*1000;                       %inductividad de la línea total en H
    XL_L = 2*pi*f*L;                    %Reactancia de la línea en Ohms