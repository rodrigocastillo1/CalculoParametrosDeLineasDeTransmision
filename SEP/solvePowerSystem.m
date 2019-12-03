function SP_solved = solvePowerSystem(FullEqSystem, FinalValues, Voltage_VarList, PS_Values)
    FullEqSystem = subs(FullEqSystem, Voltage_VarList, FinalValues');
    eq = 0 == FullEqSystem;
    eq = simplify(eq);
    eq(eq == false) = [];
    
    Power_VarList = symvar(FullEqSystem);
    max = size(Power_VarList, 2);
    Resultados = [];
    for j = 1:max
        Resultados = [Resultados; solve(eq(j), Power_VarList(j))];
    end
    
    Resultados = double(Resultados);
    
    VMag_pu = PS_Values(:,1);
    VAng_pu = PS_Values(:,2);
    P_pu = PS_Values(:,3);
    Q_pu = PS_Values(:,4);
    
    N = size(VMag_pu);
    syms V          [N 1];
    syms Delta      [N 1];
    syms P          [N 1];
    syms Q          [N 1];
    
    %v_vars = size(Voltage_VarList, 2);
    Vmag_index = find(VMag_pu == Inf);
    for index = Vmag_index'
        %VMag_pu(index) = FinalValues(find(Voltage_VarList == V(Vmag_index)));
        VMag_pu(index) = FinalValues(Voltage_VarList == V(index));
    end
    
    Vang_index = find(VAng_pu == Inf);
    for index = Vang_index'
        VAng_pu(index) = FinalValues(Voltage_VarList == Delta(index));
    end
    
    P_index = find(P_pu == Inf);
    for index = P_index'
        P_pu(index) = Resultados(Power_VarList == P(index));
    end
    
    Q_index = find(Q_pu == Inf);
    for index = Q_index'
        Q_pu(index) = Resultados(Power_VarList == Q(index));
    end
    
    SP_solved = [VMag_pu, VAng_pu, P_pu, Q_pu];
end