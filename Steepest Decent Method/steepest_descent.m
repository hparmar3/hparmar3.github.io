function steepest_descent(A, b, x0, max_iter)
    % A: Coefficinet matrix (must be symmetric positive definite)
    % b: Linear term vector
    % x0: Initial guess
    % max_iter: Number of iterations

    % Ensure A is symmetric positive definite
    if ~isequal(A, A') || min(eig(A)) <= 0
        error('Matrix A must be symmetric and positive definite.');
    end

    x_k = x0; % Initialize x
    iter_vals = [5, 10, 15]; % Store results at these iterations

    fprintf('Iteration Results:\n');
    fprintf('-------------------\n');

    for k = 1:max_iter
        grad_f = A * x_k + b; % Compute gradient

        % Compute optimal step size
        alpha_k = (grad_f' * grad_f) / (grad_f' * A * grad_f);

        % Update x
        x_k = x_k - alpha_k *grad_f;

        % Compute function value
        f_k = 0.5 * x_k' * A * x_k + b' * x_k;

        % Print results and specified iterations
        if any(k == iter_vals)
            fprintf('Iteration %d: (x) = (%.4f, %.4f), f(x) = %.4f\n', ...
                k, x_k(1), x_k(2), f_k);
        end
    end
end




