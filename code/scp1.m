% successive convex relaxation optimization 
% Test Example
% producing correct resilt
x0 = 1;
y0 = 1;
alpha = 0.1;
max_itr = 1000;

for itr = 1: max_itr
       opt = x0*y0;
       cvx_begin quiet
          variable x nonnegative
          variable y nonnegative
          x + y <= 10
         % maximize x0*y0 + (x-x0)*y0 + (y-y0)*x0
          maximize x*y0 + y*x0 - x0*y0
       cvx_end
       x0 = (1-alpha)*x0 + alpha * x;
       y0 = (1-alpha)*y0 + alpha*y;
       disp([itr, x0, y0])
       if abs(opt - x0*y0) <= 1e-6
           break
       end
end

cvx_begin quiet
variable x nonnegative
variable y nonnegative
maximize log(x)+log(y)
x + y <= 10
cvx_end
disp([x,y])