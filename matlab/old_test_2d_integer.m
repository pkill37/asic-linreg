m = 3;
n = 3;

X = [1,2,5; 1,3,6; 1,4,7];
Y = [0;1;2];
theta = [1;2;2];
alpha = 3;

s = 2048;
X = fix(X*s);
Y = fix(Y*s);
theta = fix(theta*s);
alpha = fix(alpha*s);

for i = 1:5
    hypothesis = bitshift(X*theta, -11);
    err = fix(hypothesis - Y);
    tmp1 = bitshift(X' * err, -11);
    scalar = fix((alpha/m));
    tmp2 = bitshift(tmp1 * scalar, -11);
    theta = fix(theta - tmp2)
end

%for i = 1:5
%    hypothesis = (X*theta);
%    err = (hypothesis - Y);
%    tmp1 = (X' * err);
%    scalar = ((alpha/m));
%    tmp2 = (tmp1 * scalar);
%    theta = (theta - tmp2)
%end
