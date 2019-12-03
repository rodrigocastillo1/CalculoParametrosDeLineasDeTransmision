function Ybus_pu = GetYbus(TablaLineas, Sbase, Vbase)
    numLinea = TablaLineas{1:end, {'numLinea'}};
    NodoA = TablaLineas{1:end, {'NodoA'}};
    NodoB = TablaLineas{1:end, {'NodoB'}};
    R = TablaLineas{1:end, {'R'}};
    XL = TablaLineas{1:end, {'XL'}};
    %XC = Tabla{1:end, {'BC'}};
    
    Z = R + 1i*XL;
    Zbase = (Vbase^2)/Sbase;
    Zpu = Z./Zbase;
    
    %Y = 1./R + 1i*(1./XL);
    Ypu = 1./Zpu;
    
    a = size(numLinea);
    
    Ybus_pu = zeros(a(1), a(1));
    for j = 1:size(numLinea)
        Ybus_pu(NodoA(j), NodoB(j)) = Ypu(j);
        Ybus_pu(NodoB(j), NodoA(j)) = Ypu(j);
    end
    
    Ybus_pu = diag(sum(Ybus_pu, 2)) - Ybus_pu;
end