
clear all
load('T.mat');
P=0;
Tq=[T(:,1),T(:,4),T(:,7),T(:,10)];
Pq=0;
for k=1:4 
    Pq=Pq+T(:,k)'*T(:,k);
end
Pq=Pq/4;
for k=1:12 
    P=P+T(:,k)'*T(:,k);
end
P=P/(400*12);
Z1=[T,T,T];
Z1q=[Tq,Tq,Tq,Tq,Tq];
T=[T,T,T,T,T,T,T,T]+0.00001*randn(400,8*12);
Tq=[Tq,Tq,Tq,Tq,Tq,Tq,Tq,Tq]+0.1*randn(400,8*4);
lb=[1,1,1,2,2,2,3,3,3,4,4,4];
lbq=[1,2,3,4];
lb1=[lb,lb,lb];
lb1q=[lbq,lbq,lbq,lbq,lbq];
lb=[lb,lb,lb,lb,lb,lb,lb,lb];
lbq=[lbq,lbq,lbq,lbq,lbq,lbq,lbq,lbq];
T=abs(T);
%Tq=abs(Tq);
[L,Det]=lmnn(Tq,lbq,'quiet',1);
%load L;
%load Det;
isnr=0;
Nexp=50;
for snr=-50:3:0
 
    isnr=isnr+1;
 
    error1(isnr)=0;
 
    error2(isnr)=0;
 
    error3(isnr)=0;
    
 
    for nex=1:Nexp
 
        sig=sqrt(P*10^(-snr/10));
 
        x=sig*randn(400,3*12);
 
        y(1,3*12)=x(1,3*12);
 
        for k=2:400
 
            y(k,:)=x(k,:)-0.5*y(k-1,:);
 
        end
 
        ex=ceil(rand(20,1)*400);
 
        Z1q(ex,1)=Z1q(ex,1)+1000*P;
Z=(Z1q+sig*randn(400,5*4));
 
 
 
enerr=energyclassify(L,Tq,lbq,Z,lb1q,7);
knnerrL=knnclassify(L,Tq,lbq,Z,lb1q,7);
knnerrI=knnclassify(eye(size(L)),Tq,lbq,Z,lb1q,7);
 
 
% clc;
% fprintf('Bal data set:\n');
% fprintf('3-NN Euclidean training error: %2.2f\n',knnerrI(1)*100);
% fprintf('3-NN Euclidean testing error: %2.2f\n',knnerrI(2)*100);
% fprintf('3-NN Malhalanobis training error: %2.2f\n',knnerrL(1)*100);
% fprintf('3-NN Malhalanobis testing error: %2.2f\n',knnerrL(2)*100);
% fprintf('Energy classification error: %2.2f\n',enerr*100);
% fprintf('Training time: %2.2fs\n (As a reality check: My desktop needs 20.53s)\n\n',Det.time);
error1(isnr)=error1(isnr)+knnerrI(2);
error2(isnr)=error2(isnr)+knnerrL(2);
error3(isnr)=error3(isnr)+enerr;
end
 
    error1(isnr)=error1(isnr)/Nexp;
 
    error2(isnr)=error2(isnr)/Nexp;
 
    error3(isnr)=error3(isnr)/Nexp;
 
    %error4(isnr)=error4(isnr)/Nexp;
end
 
    load T;
 
    T=T+0.5*randn(400,12);
isnr=0;
Nexp=150;
for snr=-50:3:0
 
    isnr=isnr+1;
  
 
    error4(isnr)=0;
 
    for nex=1:Nexp
 
        sig=sqrt(P*10^(-snr/10));
 
        xs=sig*randn(400,1);
 
        ys(1,1)=xs(1,1);
 
        for k=2:400
 
            ys(k,:)=xs(k,:)-0.5*ys(k-1,:);
 
        end
 
        ex=ceil(rand(20,1)*400);
 
        for kc=1:3:12
 
            Z1s=T(:,kc);
 
        Z1s(ex,:)=Z1s(ex,:)+1000*P;
Zs=(Z1s+sig*randn(400,1));
 
 
 
dmin=1e32;
for k=1:3:12
 
    d=(Zs-(T(:,k)))'*(Zs-(T(:,k)));
 
    if d < dmin
 
        dmin =d;
 
        ic =ceil(k/3);
end
end
 
        if ic ~=ceil(kc/3)
 
            error4(isnr)=error4(isnr)+1;
 
        end
 
        end
 
        end
 
        error4(isnr)=error4(isnr)/(Nexp*4);
end
clf
snr=-50:3:0;
plot(snr,error1)
hold
plot(snr,error2,'+')
plot(snr,error3,'--')
plot(snr,error4,'o')
