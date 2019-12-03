function [Jac_P, Jac_Q] = GetJacobian(P, Q, P_list, Q_list) 
    
    Jac_P = jacobian(P, P_list);
    Jac_Q = jacobian(Q, Q_list);
end