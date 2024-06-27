clear all

x = -0.00875:0.0025:0.00875;
y=x;
[X,Y] = meshgrid(x,y);
z=0.075;
R=sqrt(X.^2+Y.^2);
d = sqrt(R.^2+z^2)

imagesc(d)
