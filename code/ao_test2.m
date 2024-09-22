% Initialize CVX
% chatgpt result is wrong
%cvx_solver('sedumi');  % You can choose any other solver supported by CVX
max_iter = 100;         % Maximum number of iterations
tolerance = 1e-6;       % Convergence tolerance

% Initialize x and y
x = 1;  % Initial guess for x
y = 1;  % Initial guess for y

for iter = 1:max_iter
    % Step 1: Fix y, optimize x
    cvx_begin quiet
        variable x_nonnegative
        maximize( x_nonnegative * y )
        subject to
            x_nonnegative + y <= 10
            x_nonnegative >= 0
    cvx_end
    
    x = x_nonnegative;
    
    % Step 2: Fix x, optimize y
    cvx_begin quiet
        variable y_nonnegative
        maximize( x * y_nonnegative )
        subject to
            x + y_nonnegative <= 10
            y_nonnegative >= 0
    cvx_end
    
    y = y_nonnegative;
    
    % Check for convergence
    if abs(x * y - cvx_optval) < tolerance
        break;
    end
end

% Display results
fprintf('Optimal x: %f\n', x);
fprintf('Optimal y: %f\n', y);
fprintf('Optimal product x*y: %f\n', x * y);
