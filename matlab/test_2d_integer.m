m = 10;
n = 2;

theta = [
    1.01;
    2.02
];

X = [
    1, 2.34;
    1, 3.77;
    1, 4.54;
    1, 5.81;
    1, 6.12;
    1, 5.01;
    1, 3.09;
    1, 4.14;
    1, 1.48;
    1, 2.20
];

Y = [
    4.12;
    3.04;
    3.19;
    6.35;
    4.73;
    6.77;
    1.39;
    5.76;
    3.27;
    2.82
];

alpha = 0.11;

s = 2048;
X = fix(X*s);
Y = fix(Y*s);
theta = fix(theta*s);
alpha = fix(alpha*s);

%dec2hex(X)
%dec2hex(Y)
%dec2hex(theta)
%dec2hex(alpha)

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
%    theta = theta - tmp2
%end
