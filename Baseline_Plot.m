patch_separation_p20;
%% All trials of patch 1
all_trials={};
for i=1:length(all_patches{1})
    all_trials= [all_trials,all_patches{1}(i)];     
end
all_trials_array= [all_trials{:}];     % all trials from the first patch
%% code numbers on 4 th event for all trials %%%%%
h_all_array={};
for o_all_array= all_trials_array
    for p_all_iter= 1:length(bhvmat.CodeNumbers{1,o_all_array})
        if bhvmat.CodeNumbers{1,o_all_array}(p_all_iter)/4 == 1
            h_all_array=[h_all_array,p_all_iter];
        end
    end
end
index_4_all= [h_all_array{:}];    % stores the index of leave trials at 4 th event
%% codetimes for each all trial
c=[];
s=[];
p=[];
t=[];
stack={};
comb_f_time_all={};
comb_time_stay=[];
N_2= all_trials_array;
for i_1 = N_2
    c(i_1)= max(size(bhvmat.CodeTimes{1,i_1}));
    
end
 
 m_time_all=max(c);
 for i_2= N_2
    s(i_2)= m_time_all-c(i_2);
    
 end
 

 
 for i_3 = N_2
     
     p= bhvmat.CodeTimes{1,i_3};
     t= zeros(s(i_3),1);
     comb_time_all= cat(1,p,t);
     i_3=i_3+1;
     comb_f_time_all= [comb_f_time_all,comb_time_all];
 end
 
 see_all= vertcat(comb_f_time_all{:});
 
 for i_4= 1:length(see_all)
    if see_all(i_4) == 0
        see_all(i_4)= NaN;
        
    end
 end
 see_f_all= fix(see_all);                     % codetimes of all stay trials 
 %% Codetimes of all trials at 4 th event
 times_all={};
 times_9_all={};
 time_f_all={};
 for i_5= 1:length(N_2)-1
     time_1_all= see_f_all(index_4_all(1));
     times_all= [times_all,see_f_all((i_5*m_time_all)+index_4_all(i_5+1))];
    
 end
 times_9_all= vertcat([times_all{:}]);
 time_f_all= [time_f_all,time_1_all,times_9_all];
 codetime_all= [time_f_all{:}];
 %% Pupil data for all the trials of patch 1 (concatenation)
c=[];
s=[];
p=[];
t=[];
stack={};
comb_f_data_all={};
comb_data_all=[];
N=length(bhvmat.AnalogData);
for i = N_2
    c(i)= max(size(bhvmat.AnalogData{i}.General.Gen1));
    
end
 
 m_data_all=max(c);
 for i= N_2
    s(i)= m_data_all-c(i);
    
 end
 

 
 for i = N_2
     
     p= bhvmat.AnalogData{1,i}.General.Gen1;
     t= zeros(s(i),1);
     comb_data_all= cat(1,p,t);
     i=i+1;
     comb_f_data_all= [comb_f_data_all,comb_data_all];
 end
 
 see_1_all= vertcat(comb_f_data_all{:});
 
 for i= 1:length(see_1_all)
    if see_1_all(i) == 0
        see_1_all(i)= NaN;
        
    end
 end

y_all= see_1_all;                 % stores all pupil size data from all stay trials of the patch
%% smoothing data
N = 128;

for i=1:N
  w(i) = 0.5 - 0.5*cos(2*pi*(i-1)/N);
  
end
% subplot(2,2,3);
% plot(n,w);
y1_all= conv(y_all,w);
%% Extraction of 4000 data points
t_all={};
for e= 0:length(N_2)-1
    t_all= [t_all,y1_all(((e*m_data_all)+codetime_all(e+1))-2000:((e*m_data_all)+codetime_all(e+1))+2000)];
end
t_1_all= [t_all{:}];
t_2_all= t_1_all(:);
%% Extraction of 1500 data points
gg_1={};
for mi= 1:length(N_2)
    gg=t_1_all(:,mi);
    gg(1:250)= NaN;
    gg(end-2250:end)= NaN;
    gg_1=[gg_1,gg];
end
gg_f=[gg_1{:}];
plot(gg_f);
%% blink removal
 l=[];
 thres= input('enter you threshold:');  
 p=  find(gg_f< thres);               % enter threshold according to the velocity profile
 
 s= length(p);
 
 for i= 1:s
     box= p(i)-100:p(i)+100;              % identification of blink
     
     
     for j= 1:length(gg_f)
        for j= box
           gg_f(j)= NaN;
         end
     end
     i=i+1;
 end
 %plot(baseline_removed_data);

%% leave trial
leave_trial_patch_1= gg_f(:,4);
%% baseline 
baseline= mean(leave_trial_patch_1(251:750));
%% baseline removal
baseline_removed_data= gg_f-baseline;
plot(baseline_removed_data,'linewidth',2);
hold on
%% Avg calculation 

v={};
zz={};
for j= 1:1:4000
    for i= 1:length(t_all)
        v=[v,baseline_removed_data(:,i)];
        zz=[zz,v{:,i}(j)];
    end
end
qq={};
for k= 1:length(zz)
    qq=[qq,mean(zz{:,k})];
end
ff= [qq{:}];


q={};
n= length(t_all);
N_avg= length(ff(:));
p= fix(N_avg/n)*n;

s= fix(N_avg/n);


x = reshape(ff(1:p),n,s);
avg={};
for g= 1:length(x)
    avg= [avg,mean(x(:,g))];
end
Average=[avg{:}];
%% avg reconstruction
% t_3= isnan(Average);
% p= find(t_3==1);
% q= find(t_3==0);
% z_f={};
% z={};
% for i= 1:length(t_3)-1
%     if t_3(i)+t_3(i+1)== 1
%         z= [z,i];
%         i=i+1;
%     end
% end
% for j= 1:length(z)
%     z{1,j}= z{1,j}+1;
%     j=j+1;
% end
% w= [z{:}];
% c=2:2:length(w)-1;
% t2_f={};
% t3_f={};
% t1_f={};
% t4_f={};
% xx={};
% u={};
% for k= c(1:length(c))
%     t2= w(k)-1;    % blink onset
%     t3= w(k+1);   % blink offset
%     t1= t2-5;       % (t1,t4) points to generate a spline 
%     t4= t3+5;       
%     xx= [t1,t2,t3,t4];
%     yy= Average(xx);
%     pp= linspace(t2,t3,(t3-t2));
%     u=[u,spline(xx,yy,pp)];
%     
% end
% u_1=[u{:}];
% hold on 
% avg={};
% %plot(baseline_removed_avg)
% 
% for i= c(1:length(c))
%     avg= [avg,average(w(i):w(i+1))];
% end
% for k= 1:length(c)
%     [avg{:,k}]= u{:,k};
% end
% Average(w(2):w(3))= [avg{:,1}];
plot(Average,'Linewidth',5);
%% trend for all trials of a patch
baseline_removed_data(isnan(baseline_removed_data))= 0;
AVG={};
for a= 1:length(N_2)
    AVG=[AVG,mean(baseline_removed_data(:,a))];
end
trend_1=[AVG{:}];
%% spline
%plot(trend,'*','linewidth',5);
first= trend_1(1);
last= trend_1(length(N_2));
x = 1:length(N_2);
y= trend_1;
xx = linspace(1,length(N_2),length(N_2)*10);
%pp= csapi(x,y);
%xx(1:10)=NaN;
plot(xx,csapi(x,trend_1,xx),'k-',x,y,'ro');
point= csapi(x,trend_1,xx);
div=length(point)-(length(point)/length(N_2));
interval= fix(div/10);
interp_points=[];
for k= 1:10
    interp_points= [interp_points,point(interval*k)];
end
final_points_1=[first,interp_points,last];
plot(final_points_1,'*','linewidth',5);
%% Plot description
title('Baseline shift plot for patch 1');
xlabel('Time stamp');
ylabel('Pupil size');
legend({'stay trial 1','stay trial 2','stay trial 3','Leave trial','Average Plot'},'FontSize',14);
