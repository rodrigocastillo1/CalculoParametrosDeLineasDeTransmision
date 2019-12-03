function [EqSystem, SymsListEq, FullEqSystem, FullSymsListEq] = GetPQ(Y_dato, V_mag, V_ang, Pdato, Qdato, num)  
    N = num;  % Número de nodos
    
    % -- Matrices simbólicas para la vectorización de la ecuación de P ---
    syms V          [N 1];
    syms G          [N N];
    syms B          [N N];
    syms Y          [N N];
    syms Theta      [N N];
    syms Delta      [N 1];
    
    syms P          [N 1];
    syms Q          [N 1];
    
    % Datos de entrada: Conocidos tienen valor, los desconocidos son cero
    %Y_dato = [0.1+0.1i, Inf, 0.3+0.3i; 0.1+0.1i, 0.2+0.2i, Inf; 0.1+0.1i, Inf, 0.3+0.3i];
    %V_dato = [1+1i; 0.5+0.5i; Inf];
    
    % Actualizar los valores de G y B obtenidos desde Y_bus
    Y_re = real(Y_dato); Y_im = imag(Y_dato);
    
    P_index = find(Pdato ~= Inf);    %Se encuentran los índices de los valores conocidos
    
    if size(P_index)~= 0
        for j = 1:size(P_index)
            P = subs(P, P(P_index(j)), Pdato(P_index(j)));
        end
    end
    
    Q_index = find(Qdato ~= Inf);    %Se encuentran los índices de los valores conocidos
    
    if size(Q_index)~= 0
        for j = 1:size(Q_index)
            Q = subs(Q, Q(Q_index(j)), Qdato(Q_index(j)));
        end
    end
    
    Y_index = find(~isnan(Y_re));    %Se encuentran los índices de los valores conocidos
    
    if size(Y_index)~= 0
        for j = 1:size(Y_index)
            G = subs(G, G(Y_index(j)), Y_re(Y_index(j)));
            B = subs(B, B(Y_index(j)), Y_im(Y_index(j)));
        end
    end
    
    % Actualizar los valores de Y y B obtenidos desde Y_dato y V_dato
    Y_mag = abs(Y_dato); Y_ang = angle(Y_dato);
    %V_mag = abs(V_dato); V_ang = angle(V_dato);
    
    Y_index = find(~isnan(Y_mag));
    V_index = find(V_mag ~= Inf);
    Delta_index = find(V_ang ~= Inf);
    
    if size(Y_index) ~= 0
        for j = 1:size(Y_index)
            Y = subs(Y, Y(Y_index(j)), Y_mag(Y_index(j)));
            Theta = subs(Theta, Theta(Y_index(j)), Y_ang(Y_index(j)));
        end
    end
    
    if size(V_index) ~= 0
        for j = 1:size(V_index)
            V = subs(V, V(V_index(j)), V_mag(V_index(j)));
        end
    end
    
    if size(Delta_index) ~= 0
        for j = 1:size(Delta_index)
            Delta = subs(Delta, Delta(Delta_index(j)), V_ang(Delta_index(j)));
        end
    end
    
    G_diag = diag(diag(G));
    Delta2 = repmat(Delta, 1, N);
    Delta1 = Delta2.';
    Angle_mat = Theta + Delta1 - Delta2;
    Adjust_mat = (repmat(V, 1, N)) - diag(diag(repmat(V, 1, N)));
    % --------------------------------------------------------------------

    % -- Matrices simbólicas para la vectorización de la ecuación de Q ---
    B_diag = diag(diag(B));
    % --------------------------------------------------------------------

    % ----------- Matrices simbólicas de las ecuaciones P y Q ------------
    %P = G_diag*(V.^2) + (Adjust_mat.*cos(Angle_mat).*Y)*V;
    %Q = -B_diag*(V.^2) - (Adjust_mat.*sin(Angle_mat).*Y)*V;
    
    
    %eq1 = 0 == -P + G_diag*(V.^2) + (Adjust_mat.*cos(Angle_mat).*Y)*V;
    %eq2 = 0 == -Q - B_diag*(V.^2) - (Adjust_mat.*sin(Angle_mat).*Y)*V;
    
    eq1 = -P + G_diag*(V.^2) + (Adjust_mat.*cos(Angle_mat).*Y)*V;
    eq2 = -Q - B_diag*(V.^2) - (Adjust_mat.*sin(Angle_mat).*Y)*V;
    
    FullEqSystem = [eq1; eq2];
    FullSymsListEq = symvar(FullEqSystem);
    % --------------------------------------------------------------------
    
    Pvar_index = find(Pdato == Inf);    %Se encuentran los índices de los valores desconocidos
    Qvar_index = find(Qdato == Inf);    %Se encuentran los índices de los valores desconocidos
    
    if size(Pvar_index)~= 0                        %Pvar_index contiene los índices de los valores desconocidos de P
        for j = 1:size(Pvar_index)
            eq1(Pvar_index(j)) = 0;                    % Se eliminan las filas que contengan ecuaciones con valores desconocidos de P
        end
    end
    eq1(eq1 == 0) = [];
    
    if size(Qvar_index)~= 0                        %Qvar_index contiene los índices de los valores desconocidos de Q
        for j = 1:size(Qvar_index)
            eq2(Qvar_index(j)) = 0;                    % Se eliminan las filas que contengan ecuaciones con valores desconocidos de Q
        end
    end
    eq2(eq2 == 0) = [];
    
    EqSystem = [eq1; eq2];
    
    SymsListEq = symvar(EqSystem);  %Devolvemos una lista de las variables simbólicas del sistema de ecuaciones
    
%     syms V_     [N 1];
%     syms Y_     [N N];
%     V_VarList = V_;
%     Y_VarList = Y_;
end

% Ejemplo: eq1 = zeros(2) == [1 2; 3 4]*X;

