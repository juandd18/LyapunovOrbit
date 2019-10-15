function root = newtonMethod(f,df,x0,nmax,tol)
%newtonMethod Computes the newton method
x = x0;
n=0;
dx = f(x)/df(x);

while((dx > tol) && (f(x)>tol)) || (n>nmax)
   n= n+1;
   x=x-dx;
   dx=f(x)/df(x);
   
end

root = x;
end




