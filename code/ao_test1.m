% Alternating optimization 
% Test Example
% * wrong solution
x0 = 1;
y0 = 1;
a = 0.1;
max_itr = 1000;
for itr = 1: max_itr
      opt = x0*y0;
       cvx_begin quiet
            variable x nonnegative
            x + y0 <= 10
            maximize x*y0 - opt
       cvx_end
       
       x0 = (1-a) * x0 + a*x;
       cvx_begin quiet
            variable y nonnegative
            x0 + y <= 10
            maximize y*x0 - opt
       cvx_end
       y0 = (1-a)*y0  + a*y;
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