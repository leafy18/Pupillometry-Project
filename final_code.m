% Only pre-prcessing code %
% Leafy Behera & Peeusa Mitra%

%% concat%%
c=[];
s=[];
p=[];
t=[];
stack={};
comb_f={};
comb=[];
for i = 1:length(bhvmat.AnalogData)
    c(i)= max(size(bhvmat.AnalogData{i}.General.Gen1));
    
end
 
 m=max(c);
 for i= 1:length(bhvmat.AnalogData)
    s(i)= m-c(i);
    
 end
 
 stack=[stack,s];
 
 for i = 1:length(bhvmat.AnalogData)
     p= bhvmat.AnalogData{1,i}.General.Gen1;
     t= zeros(s(i),1);
     comb= cat(1,p,t);
     i=i+1;
     comb_f= [comb_f,comb];
 end
 
 see= vertcat(comb_f{:});
 plot(see)
 for i= 1:length(see)
    if see(i) == 0
        see(i)= NaN;
        
    end
 end
%% chunks%%
%n= 1000;
%N= length(see);
%p= fix(N/n)*n;
%q= see(p+1:end);
%s= fix(N/n);


%x = reshape(see(1:p),n,s);

%j=0;
%for i = 1:s
%   if sum(x(:,i))== 0
%      x(:,i)= NaN;
%   end
%end

%% resample%%
y= resample(see,1,5);
fs= 1000;
t1= 0:1/fs:1;
t2= 5*(t1);
p1= (1:length(see(1:length(t1))))/fs;
p2= (1:length(y(1:length(t1))))/200;
%% mva %%
%smooth=[];
%t={};
%N= 1001 ;
%for i = 1:N
%   f= mean(see(i:i+51));
 %   i=i+1;
  %  t=[t,f];
%end
%smooth= vertcat(t{:});
%smooth_f= conv(see,smooth);
%% hanning wndw%%
a=see;
N =128 ;

for i=1:N
  w(i) = 0.5 - 0.5*cos(2*pi*(i-1)/N);
end
y1= conv(a,w);
plot(y1,'r');
% velocity%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%v={};
%v_f={};
%v_prof=[];


%t1= 0:1/998:1;
%T= y1;
%for i= 1:length(T)-1
    %dx= (T(i+1)-T(i))*100;
    
    %v_f=[v_f,dx];
%end

%v_prof=vertcat(v_f{:});


%plot(v_prof)


%title('velocity profile')
% cubic spline%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%p=[];
%for i = 1:length(x(:,3))
    %if y1(i)< -108
       %y1(i)= NaN;
    %end
%end                                    % this is specifically for x(:,3)

%plot(y1,'r');
%h= -106.7:-0.0014492:-107 ;
%j= 98:1:305 ;
%xx= 98:1:305;
%t= spline(j,h,xx);
%plot(y1,'r');
%hold on
%plot(xx,t,'bl')
%hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,1)
plot(t1,see(1:length(t1)))
title('datapoint')

subplot(2,2,3)

plot(t1,y(1:length(t1)))
title('resample')
subplot(2,2,4)
plot(t1,smooth_f(1:length(t1)))
title('moving avg')

subplot(2,2,2)
plot(t1,y1(1:length(t1)))
title('hanning window')


xlabel('Time (s)')
ylabel('Signal')
