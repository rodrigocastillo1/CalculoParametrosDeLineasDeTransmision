%Programa que devuelve una matriz de resultados en el orden que muestra la
%"figura" xD
%
%             _ mag_VT  Fase_VT mag_IT  Fase_IT mag_VL  Fase_VL Reg _
%línea corta  |                                                      |
%línea media  |                                                      |
%línea larga  |                                                      |
%             _                                                      _

function R = results(T, V)
    %Magnitud de VT
    V_T_mag_s = abs(T(1,1));
    V_T_mag_m = abs(T(1,2));
    V_T_mag_l = abs(T(1,3));
    V_T_mag = [V_T_mag_s; V_T_mag_m; V_T_mag_l];
    
    %Fase de VT
    V_T_ph_s = atand(iamg(T(1,1))/real(T(1,1)));
    V_T_ph_m = atand(iamg(T(1,2))/real(T(1,2)));
    V_T_ph_l = atand(iamg(T(1,3))/real(T(1,3)));
    V_T_ph = [V_T_ph_s; V_T_ph_m; V_T_ph_l];
    
    %Magnitud de IT
    I_T_mag_s = abs(T(2,1));
    I_T_mag_m = abs(T(2,2));
    I_T_mag_l = abs(T(2,3));
    I_T_mag = [I_T_mag_s; I_T_mag_m; I_T_mag_l];
    
    %Fase de IT
    I_T_ph_s = atand(iamg(T(2,1))/real(T(2,1)));
    I_T_ph_m = atand(iamg(T(2,2))/real(T(2,2)));
    I_T_ph_l = atand(iamg(T(2,3))/real(T(2,3)));
    I_T_ph = [I_T_ph_s; I_T_ph_m; I_T_ph_l];
    
    %Caída de tensión en la línea
    V_op = V/sqrt(3);
    Vl_s = T(1,1)-V_op;
    Vl_m = T(1,2)-V_op;
    Vl_l = T(1,3)-V_op;
    
    %Magnitud
    V_L_mag_s = abs(Vl_s);
    V_L_mag_m = abs(Vl_m);
    V_L_mag_l = abs(Vl_l);
    V_L_mag = [V_L_mag_s; V_L_mag_m; V_L_mag_l];
    
    %Fase
    V_L_ph_s = atand(iamg(Vl_s)/real(Vl_s));
    V_L_ph_m = atand(iamg(Vl_m)/real(Vl_m));
    V_L_ph_l = atand(iamg(Vl_l)/real(Vl_l));
    V_L_ph = [V_L_ph_s; V_L_ph_m; V_L_ph_l];
    
    %Porcentaje de regulación
    Reg_s = ((T(1,1)-V_op)/T(1,1))*100;
    %Faltan las otras regulaciones
    %Y la eficiencia
    
    Reg = [Reg_s; 0; 0];
    
    R = [V_T_mag, V_T_ph, I_T_mag, I_T_ph, V_L_mag, V_L_ph, Reg]