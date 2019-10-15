function dydt = cr3bpdiff(~,z)
%circular restricted three body problem vector field with differential
%equations

global pdata


x  = z(1);
y  = z(2);
vx = z(3);
vy = z(4);
      

t2 = 1. - pdata.mu;
t3 = x + pdata.mu;
t4 = t3 ^ 2;
t5 = y ^ 2;
t6 = t4 + t5;
t7 = sqrt(t6);
t10 = t2 / t7 / t6;
t13 = x + pdata.mu - 1.;
t14 = t13 ^ 2;
t15 = t14 + t5;
t16 = sqrt(t15);
t19 = pdata.mu / t16 / t15;


zp(1) = vx;
zp(2) = vy;
zp(3) =  2. * vy + x - t10 * t3 - t19 * t13 ;
zp(4) = -2. * vx + y - t10 * y  - t19 * y   ;


      t46 = t6 ^ 2;
      t49 = t2 / t7 / t46;
      t50 = 4.D0 * t3 ^ 2;
      t52 = 0.3D1 / 0.4D1 * t49 * t50;
      t53 = t15 ^ 2;
      t56 = pdata.mu / t16 / t53;
      t57 = 4.D0 * t13 ^ 2;
      t59 = 0.3D1 / 0.4D1 * t56 * t57;

      t73 = 3.D0 * t49 * y * t3;
      t76 = 3.D0 * t56 * y * t13;

      t129 = 3.D0 * t49 * t5;
      t131 = 3.D0 * t56 * t5;
      

mat(1,1) = 0.D0;
mat(1,2) = 0.D0;
mat(1,3) = 1.D0;
mat(1,4) = 0.D0;

mat(2,1) = 0.D0;
mat(2,2) = 0.D0;
mat(2,3) = 0.D0;
mat(2,4) = 1.D0;

mat(3,1) = 1.D0 + t52 - t10 + t59 - t19;
mat(3,2) = t73 + t76 ;
mat(3,3) = 0.0d0;
mat(3,4) = 2.0D0 ;

mat(4,1) = t73 + t76 ;
mat(4,2) = 1.D0 + t129 - t10 + t131 - t19 ;
mat(4,3) = -2.D0 ;
mat(4,4) = 0.0d0;


zder=reshape(z(5:20),4,4)';


prod=(mat * zder);
dzp=reshape( prod' , 1,16);

dydt = [zp,dzp]';




end

                    




     


