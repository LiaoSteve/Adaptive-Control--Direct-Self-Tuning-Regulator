%%
%Direct STR,d0=1
clear,clc ;
format long;
m=100;%time(sec) ,sampling time=0.5(sec)
r0=-0.11;
r1=-0.11;
s0=-0.055;
s1=0;
theta(1,1)=r0;
theta(2,1)=r1;
theta(3,1)=s0;
theta(4,1)=s1;
phi(1,1)=0;
phi(1,2)=0;
phi(1,3)=0;
phi(1,4)=0;
uc(1:50)=1;
uc(51:99)=-1;
uc=[uc uc uc uc uc];
uc=[uc uc uc uc uc];
uc=[uc uc];
p=[100 0 0 0 ;0 100 0 0; 0 0 1 0; 0 0 0 1];
lambda=1;
%desired system:Am 
am1=-1.3205;
am2=0.4966; 
i=1;
y(1)=0;
u(1)=0.5;
t0=1+am1+am2;
for k=0:0.5:(m-0.5)     
    %RLS:R,S
    [p ,theta(:,i+1)]=rls_forgetting(p,theta(:,i),phi(i,:),y(i),lambda) ;    
    r0=theta(1,i+1);
    r1=theta(2,i+1);
    s0=theta(3,i+1);
    s1=theta(4,i+1);    
    draw1(i)=r1/r0;
    draw2(i)=t0/r0;
    draw3(i)=s0/r0;
    draw4(i)=s1/r0;
    if i==1        
        uf(i)=u(i)-am1*0-am2*0;
        yf(i)=y(i)-am1*0-am2*0;
        phi(i+1,1)=uf(i);
        phi(i+1,2)=0;
        phi(i+1,3)=yf(i);
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*0; 
        y(i+1)=1.6065*y(i)-0.6065*0+0.1065*u(i)+0.0902*0; %measured y
    end
    if i==2
        uf(i)=u(i)-am1*uf(i-1)-am2*0;
        yf(i)=y(i)-am1*yf(i-1)-am2*0;
        phi(i+1,1)=uf(i);
        phi(i+1,2)=uf(i-1);
        phi(i+1,3)=yf(i);
        phi(i+1,4)=yf(i-1);
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y  
    end    
    if i>=3
        uf(i)=u(i)-am1*uf(i-1)-am2*uf(i-2);
        yf(i)=y(i)-am1*yf(i-1)-am2*yf(i-2);
        phi(i+1,1)=uf(i);
        phi(i+1,2)=uf(i-1);
        phi(i+1,3)=yf(i);
        phi(i+1,4)=yf(i-1);
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y  
    end    
    i=i+1;
end
figure(1)
subplot(211)
plot(0:0.5:m,y);
hold on
plot(0:0.5:m,uc(1:2*m+1));
title('Direct STR d0=1')
xlabel('Time')
text(51, -0.08197,' y')
text(21, -1,'uc')
axis([-inf, inf, -1.5, 1.5])
subplot(212)
stairs(0:0.5:m,u);
xlabel('Time')
text(65, 1,' u')
axis([-inf, inf, -4.5, 4.5])

figure(2)
o=90;
stairs(0:0.5:o,draw1(1:o*2+1)),hold on
stairs(0:0.5:o,draw2(1:2*o+1),'--'),hold on
stairs(0:0.5:o,draw3(1:2*o+1),'-.'),hold on
stairs(0:0.5:o,draw4(1:2*o+1),':')
title('estimated parameter'),xlabel('Time')
text(o-5, 0.85,' r1/r0'),text(o-5, 1.65,' t0/r0')
text(o-5, 2.68,'s0/r0'),text(o-5, -1.03,' s1/r0')

%%
%Direct STR,d0=2
clear,clc ;
format long;
m=100;%time(sec) ,sampling time=0.5(sec)
r0=-0.11;
r1=-0.11;
s0=-0.055;
s1=0;
theta(1,1)=r0;
theta(2,1)=r1;
theta(3,1)=s0;
theta(4,1)=s1;
phi(1,1)=0;
phi(1,2)=0;
phi(1,3)=0;
phi(1,4)=0;
uc(1:49)=1;
uc(50:99)=-1;
uc=[uc uc uc uc uc];
uc=[uc uc uc uc uc];
p=[100 0 0 0 ;0 100 0 0; 0 0 1 0; 0 0 0 1];
lambda=1;
%desired system:Am 
am1=-1.3205;
am2=0.4966; 
i=1;
y(1)=0;
u(1)=0.5;
t0=1+am1+am2;
for k=0:0.5:(m-0.5)     
    %RLS:R,S
    [p ,theta(:,i+1)]=rls_forgetting(p,theta(:,i),phi(i,:),y(i),lambda) ;    
    r0=theta(1,i+1);
    r1=theta(2,i+1);
    s0=theta(3,i+1);
    s1=theta(4,i+1);    
    draw1(i)=r1/r0;
    draw2(i)=t0/r0;
    draw3(i)=s0/r0;
    draw4(i)=s1/r0;
    if i==1        
        uf(i)=u(i)-am1*0-am2*0;
        yf(i)=y(i)-am1*0-am2*0;
        phi(i+1,1)=0;
        phi(i+1,2)=0;
        phi(i+1,3)=0;
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*0; 
        y(i+1)=1.6065*y(i)-0.6065*0+0.1065*u(i)+0.0902*0; %measured y
    end
    if i==2
        uf(i)=u(i)-am1*uf(i-1)-am2*0;
        yf(i)=y(i)-am1*yf(i-1)-am2*0;
        phi(i+1,1)=uf(i-1);
        phi(i+1,2)=0;
        phi(i+1,3)=yf(i-1);
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y  
    end    
    if i>=3
        uf(i)=u(i)-am1*uf(i-1)-am2*uf(i-2);
        yf(i)=y(i)-am1*yf(i-1)-am2*yf(i-2);
        phi(i+1,1)=uf(i-1);
        phi(i+1,2)=uf(i-2);
        phi(i+1,3)=yf(i-1);
        phi(i+1,4)=yf(i-2);
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y  
    end     
    i=i+1;
end
figure(3)
subplot(211)
plot(0:0.5:m,y);
title('Direct STR d0=2')
xlabel('Time')
text(51, -0.08197,' y')
hold on
plot(0:0.5:m,uc(1:2*m+1));
text(21, -1,'uc')
axis([-inf, inf, -1.5, 1.5])
subplot(212)
stairs(0:0.5:m,u);
xlabel('Time')
text(65, 1,' u')
axis([-inf, inf, -4.5, 4.5])

figure(4)
o=20;
stairs(0:0.5:o,draw1(1:o*2+1)),hold on
stairs(0:0.5:o,draw2(1:2*o+1),'--'),hold on
stairs(0:0.5:o,draw3(1:2*o+1),'-.'),hold on
stairs(0:0.5:o,draw4(1:2*o+1),':')
title('estimated parameter'),xlabel('Time')
text(o-5, -0.337,' r1/r0'),text(o-5, 0.52,' t0/r0')
text(o-5, 1.2,'s0/r0'),text(o-5, -0.67,' s1/r0')
%%
%Direct STR,d0=3
clear,clc ;
format long;
m=100;%time(sec) ,sampling time=0.5(sec)
r0=-0.11;
r1=-0.11;
s0=-0.055;
s1=0;
theta(1,1)=r0;
theta(2,1)=r1;
theta(3,1)=s0;
theta(4,1)=s1;
phi(1,1)=0;
phi(1,2)=0;
phi(1,3)=0;
phi(1,4)=0;
uc(1:49)=1;
uc(50:99)=-1;
uc=[uc uc uc uc uc];
uc=[uc uc uc uc uc];
p=[100 0 0 0 ;0 100 0 0; 0 0 1 0; 0 0 0 1];
lambda=1;
%desired system:Am 
am1=-1.3205;
am2=0.4966; 
i=1;
y(1)=0;
u(1)=0.5;
t0=1+am1+am2;
for k=0:0.5:(m-0.5)     
    %RLS:R,S
    [p ,theta(:,i+1)]=rls_forgetting(p,theta(:,i),phi(i,:),y(i),lambda) ;    
    r0=theta(1,i+1);
    r1=theta(2,i+1);
    s0=theta(3,i+1);
    s1=theta(4,i+1);    
    draw1(i)=r1/r0;
    draw2(i)=t0/r0;
    draw3(i)=s0/r0;
    draw4(i)=s1/r0;
    if i==1        
        uf(i)=u(i)-am1*0-am2*0;
        yf(i)=y(i)-am1*0-am2*0;
        phi(i+1,1)=0;
        phi(i+1,2)=0;
        phi(i+1,3)=0;
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*0; 
        y(i+1)=1.6065*y(i)-0.6065*0+0.1065*u(i)+0.0902*0; %measured y
    end
    if i==2
        uf(i)=u(i)-am1*uf(i-1)-am2*0;
        yf(i)=y(i)-am1*yf(i-1)-am2*0;
        phi(i+1,1)=0;
        phi(i+1,2)=0;
        phi(i+1,3)=0;
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y  
    end    
    if i==3
        uf(i)=u(i)-am1*uf(i-1)-am2*uf(i-2);
        yf(i)=y(i)-am1*yf(i-1)-am2*yf(i-2);
        phi(i+1,1)=uf(i-2);
        phi(i+1,2)=0;
        phi(i+1,3)=yf(i-2);
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y
    end
    if i>=4
        uf(i)=u(i)-am1*uf(i-1)-am2*uf(i-2);
        yf(i)=y(i)-am1*yf(i-1)-am2*yf(i-2);
        phi(i+1,1)=uf(i-2);
        phi(i+1,2)=uf(i-3);
        phi(i+1,3)=yf(i-2);
        phi(i+1,4)=yf(i-3);
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y  
    end     
    i=i+1;
end
figure(5)
subplot(211)
plot(0:0.5:m,y);
title('Direct STR d0=3')
xlabel('Time')
text(51, -0.08197,' y')
hold on
plot(0:0.5:m,uc(1:2*m+1));
text(21, -1,'uc')
axis([-inf, inf, -1.5, 1.5])
subplot(212)
stairs(0:0.5:m,u);
xlabel('Time')
text(65, 1,' u')
axis([-inf, inf, -4.5, 4.5])

figure(6)
o=20;
stairs(0:0.5:o,draw1(1:o*2+1)),hold on
stairs(0:0.5:o,draw2(1:2*o+1),'--'),hold on
stairs(0:0.5:o,draw3(1:2*o+1),'-.'),hold on
stairs(0:0.5:o,draw4(1:2*o+1),':')
title('estimated parameter'),xlabel('Time')

%%
%Direct STR,d0=4
clear,clc ;
format long;
m=100;%time(sec) ,sampling time=0.5(sec)
r0=-0.11;
r1=-0.11;
s0=-0.055;
s1=0;
theta(1,1)=r0;
theta(2,1)=r1;
theta(3,1)=s0;
theta(4,1)=s1;
phi(1,1)=0;
phi(1,2)=0;
phi(1,3)=0;
phi(1,4)=0;
uc(1:49)=1;
uc(50:99)=-1;
uc=[uc uc uc uc uc];
uc=[uc uc uc uc uc];
p=[100 0 0 0 ;0 100 0 0; 0 0 1 0; 0 0 0 1];
lambda=1;
%desired system:Am 
am1=-1.3205;
am2=0.4966; 
i=1;
y(1)=0;
u(1)=0.5;
t0=1+am1+am2;
for k=0:0.5:(m-0.5)     
    %RLS:R,S
    [p ,theta(:,i+1)]=rls_forgetting(p,theta(:,i),phi(i,:),y(i),lambda) ;    
    r0=theta(1,i+1);
    r1=theta(2,i+1);
    s0=theta(3,i+1);
    s1=theta(4,i+1);    
    draw1(i)=r1/r0;
    draw2(i)=t0/r0;
    draw3(i)=s0/r0;
    draw4(i)=s1/r0;
    if i==1        
        uf(i)=u(i)-am1*0-am2*0;
        yf(i)=y(i)-am1*0-am2*0;
        phi(i+1,1)=0;
        phi(i+1,2)=0;
        phi(i+1,3)=0;
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*0; 
        y(i+1)=1.6065*y(i)-0.6065*0+0.1065*u(i)+0.0902*0; %measured y
    end
    if i==2
        uf(i)=u(i)-am1*uf(i-1)-am2*0;
        yf(i)=y(i)-am1*yf(i-1)-am2*0;
        phi(i+1,1)=0;
        phi(i+1,2)=0;
        phi(i+1,3)=0;
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y  
    end    
    if i==3
        uf(i)=u(i)-am1*uf(i-1)-am2*uf(i-2);
        yf(i)=y(i)-am1*yf(i-1)-am2*yf(i-2);
        phi(i+1,1)=0;
        phi(i+1,2)=0;
        phi(i+1,3)=0;
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y
    end
     if i==4
        uf(i)=u(i)-am1*uf(i-1)-am2*uf(i-2);
        yf(i)=y(i)-am1*yf(i-1)-am2*yf(i-2);
        phi(i+1,1)=uf(i-3);
        phi(i+1,2)=0;
        phi(i+1,3)=yf(i-3);
        phi(i+1,4)=0;
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y
     end
     if i>=5
        uf(i)=u(i)-am1*uf(i-1)-am2*uf(i-2);
        yf(i)=y(i)-am1*yf(i-1)-am2*yf(i-2);
        phi(i+1,1)=uf(i-3);
        phi(i+1,2)=uf(i-4);
        phi(i+1,3)=yf(i-3);
        phi(i+1,4)=yf(i-4);
        u(i+1)=-r1/r0*u(i)+t0/r0*uc(i)-s0/r0*y(i)-s1/r0*y(i-1);        
        y(i+1)=1.6065*y(i)-0.6065*y(i-1)+0.1065*u(i)+0.0902*u(i-1);  %measured y  
    end     
    i=i+1;
end
figure(7)
subplot(211)
plot(0:0.5:m,y);
title('Direct STR d0=4')
xlabel('Time')
text(51, -0.08197,' y')
hold on
plot(0:0.5:m,uc(1:2*m+1));
text(21, -1,'uc')
axis([-inf, inf, -1.5, 1.5])
subplot(212)
stairs(0:0.5:m,u);
xlabel('Time')
text(65, 1,' u')
axis([-inf, inf, -4.5, 4.5])

figure(8)
o=20;
stairs(0:0.5:o,draw1(1:o*2+1)),hold on
stairs(0:0.5:o,draw2(1:2*o+1),'--'),hold on
stairs(0:0.5:o,draw3(1:2*o+1),'-.'),hold on
stairs(0:0.5:o,draw4(1:2*o+1),':')
title('estimated parameter'),xlabel('Time')
