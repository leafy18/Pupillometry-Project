% Code-Revision %
% 30/05/2021 %
% Code written by Leafy Behera & Peeusa Mitra %

%% Step 1: concat %
c=[];
s=[];
p=[];
t=[];
stack={};
comb_f={};
comb=[];
for i = 1:length(bhvmat.AnalogData) % iterate over all the trials
    c(i)= max(size(bhvmat.AnalogData{i}.General.Gen1)); % find the maximum number of values in each trial
    
end
 
 m=max(c); % find the maximum in c (i.e the maximum number of values present across all trials)
for i= 1:length(bhvmat.AnalogData)
    s(i)= m-c(i);
    
end
 
stack=[stack,s];
for i = 1:length(bhvmat.AnalogData)
     p= bhvmat.AnalogData{1,i}.General.Gen1;
     t= zeros(s(i),1);
     comb= cat(1,p,t);
     i=i+1;
     comb_f= [comb_f,comb]; % concatenated data
end
 
see= vertcat(comb_f{:});
plot(see)
for i= 1:length(see)
   if see(i) == 0
       see(i)= NaN;
        
   end
end
%% Resampling & Chunk formation
% y= resample(see,1,5);
% time= length(y)/1000;
% t1=0:0.005:length(time);
 
 
%t2= 5*(t1);
%p1= (1:length(see(1:1001)))/fs;
%p2= (1:length(y(1:1001)))/200;
%subplot(2,1,1)
%plot(t1,see)
%title('original')
%subplot(2,1,2)
% plot(y);
% title('resampled')

% chunk %
% q={};
% n= 1000;
% N= length(y);
% p= fix(N/n)*n;
%  
% s= fix(N/n);
%  
%  
% x = reshape(y(1:p),n,s);
% r={};
% to check the sum of each column %%%%%%%%%%%%%%%%%%%%%
% for i = 1:s
%    R= fix(sum(x(:,i)));
%    i=i+1;
%    r= [r,R];
% end

%% Step 2: Data smoothing using hanning window %%%
a=see(:,1);
 
N = 128;
 
for i=1:N
  w(i) = 0.5 - 0.5*cos(2*pi*(i-1)/N);
  
end
% subplot(2,2,3);
% plot(n,w);
y1= conv(a,w);
 
%% Step 3: Velocity %
v_f={};
v_prof=[];
 
 
T= a;
for i= 1:length(T)-1
    dx= (T(i+1)-T(i))*100;
    i=i+1;
    v_f=[v_f,dx];
end
 
v_prof=vertcat(v_f{:});
 
 
plot(y1)
hold on 
plot(v_prof)
hold off

%% Step 4: Blink removal %
box=[];

l=[];
thres= input('enter you threshold:');  % user inserts a threshold using the velocity plot
p=  find(y1< thres);               
s= length(p);

for i= 1:s
    t= p(i)-100:p(i)+100;              % identification of blink
    box= t;
    
    for j= 1:length(y1)
        for j= box
            y1(j)= NaN;
        end
    end
    i=i+1;
end

plot(y1)
hold on 
%% We used interpolation later on (keep this code for refernce) %
% 
% t= isnan(y1);
% p= find(t==1);
% q= find(t==0);
% z_f={};
% z={};
% for i= 1:length(t)-1
%     if t(i)+t(i+1)== 1
%         z= [z,i];
%         i=i+1;
%     end
% end
% for j= 1:length(z)
%     z{1,j}= z{1,j}+1;
%     j=j+1;
% end
% w= [z{:}];
% c=1:2:length(w);
% t2_f={};
% t3_f={};
% xx={};
% for k= c(1:length(c)-1)
%     t2= w(k)-1;    % blink onset
%     t3= w(k+1);   % blink offset
%     t1= t2-1;
%     t4= t3+5;
%     xx= [t1,t2,t3,t4];
%     yy= y1(xx);
%     pp= linspace(t2,t3,(t3-t2));
%     p_1=spline(xx,yy,pp);
%     plot(pp,p_1)
% end
 
