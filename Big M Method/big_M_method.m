function [x_opt, z_opt] = big_M_method(A, b, c)
    % BIG_M_METHOD Solves the linear program using the Big M method:
    %   min c'x
    %   s.t. Ax = b, x >= 0
    %
    % Inputs:
    %   A - Constraint matrix (m x n)
    %   b - RHS vector (m x 1)
    %   c - Cost vector (n x 1)
    % Outputs:
    %   x_opt - Optimal solution vector
    %   z_opt - Optimal objective function value

    [m, n] = size(A); % Number of constraints (m) and variables (n)

    % Ensure b is non-negative
    for i = 1:m
        if b(i) <= 0
            A(i, :) = -A(i, :);
            b(i) = -b(i);
        end
    end

    % Set a large M value
    M = 100 * max(norm(A, 'fro'), norm(b));

    % Create identity matrix for slack variables
    I_m = eye(m);

    % Create artificial variables (one for each constraint)
    A_ext = [A, I_m, b];  % Extended constraint matrix (A | I | b)
    
    % Cost vector with artificial variables penalized by M
    cost = [c'; zeros(m, 1); 0]; % Append M for artificial variables and 0 for RHS
    
    % Identify basic variables (artificial variables initially)
    x_B = (n + 1):(n + m);

    % Compute initial Zj - Cj row
    Zj = M * [sum(A, 1), zeros(1, m), sum(b)];
    % Compute sum for artificial variables
    Cj = cost';
    ZjCj = Zj - Cj; % Compute reduced costs

    % Print Initial Tableau
    tableau = [A_ext; ZjCj];
    fprintf('Initial Tableau:\n');
    disp(tableau);

    pivot_rows = false(m, 1);

    % Start Iteration
    RUN = true;
    while RUN
        % Finding the Entering Variable (Most Positive Zj - Cj)        
        ZC = ZjCj(1:end-1);

        if all(ZC(1:end - length(I_m)) <= 0) % If all are negative, we are optimal
            fprintf('Current Basic Feasible Solution is Optimal.\n');
            break;
        end
        
        % Choose entering variable (Bland's Rule: smallest index if tie)
        [~, pvt_col] = max(ZC);
        fprintf('Entering Column = %d\n', pvt_col);

        % Finding the Leaving Variable (Minimum Ratio Test)
        sol = A_ext(:, end); % Rightmost column (b values)
        Column = A_ext(:, pvt_col);
        
        ratio = inf(m, 1);
        for i = 1:m
            if Column(i) > 0
                ratio(i) = sol(i) / Column(i);
            end
        end
        
        % If all ratios are infinite, the problem is unbounded
        if all(isinf(ratio))
            error('Solution is Unbounded!');
        end

        % Choose the smallest ratio
        [~, pvt_row] = min(ratio);
        fprintf('Leaving Row = %d\n', pvt_row);

        % Pivot Operation
        pvt_key = A_ext(pvt_row, pvt_col);
        A_ext(pvt_row, :) = A_ext(pvt_row, :) / pvt_key; % Normalize pivot row

        for i = 1:m  % Only iterate over valid rows
            if i ~= pvt_row
                A_ext(i, :) = A_ext(i, :) - A_ext(i, pvt_col) * A_ext(pvt_row, :);
            end
        end
        
        % Update Cj
        while Cj(pvt_col) ~= 0
            Cj = Cj - Cj(pvt_col) * A_ext(pvt_row, :);
        end

        % Update basic variables
        x_B(pvt_row) = pvt_col;
        pivot_rows(pvt_row) = true;

        % Update ZjCj
        Zj = sum(A_ext(~pivot_rows, :), 1);
        Zj(x_B) = 0;
        ZjCj = M * Zj - Cj;

        % Print Updated Tableau
        tableau = [A_ext; ZjCj];
        fprintf('Updated Tableau:\n');
        disp(tableau);
    end

    % Extract optimal solution //Fix this
    x_opt = zeros(n, 1);
    for i = 1:m
        if x_B(i) <= n
            x_opt(x_B(i)) = A_ext(i, end);
        end
    end
    
    % Extract optimal objective function value
    z_opt = tableau(end, end);

    fprintf('Optimal Solution x*:\n');
    disp(x_opt);
    fprintf('Optimal Objective Function Value:\n');
    disp(z_opt);
end

