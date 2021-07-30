%% left align data %
var={};
var_1={};
for i= 1:length(all_patches)
    var=[var,bhvmat.ReactionTime(all_patches{:,i})];
end
a={};
for i= 1:length(all_patches)
    a= [a,length(var{1,i})];
end
fina= max([a{:}]); % max length of variable in var
%% . baseline shifting
baseline_shifted={};
backup={};
for n= 1:length(all_patches)
    baseline_shifted= [baseline_shifted,var{1,n}-var{1,n}(length(var{1,n}))];
    backup= [backup,var{1,n}-var{1,n}(length(var{1,n}))];% backup of baseline shifted values 
end

for h= 1:length(all_patches)
     baseline_shifted{h}=[baseline_shifted{h},zeros(1,fina-length(baseline_shifted{h}))];
end
%plot(final_points_1,'*','Linewidth',10);
left_align= zeros(length(all_patches),fina);         % all_patches is the total number of patches we have
plot_var={baseline_shifted{1},baseline_shifted{2},baseline_shifted{3},baseline_shifted{4},baseline_shifted{5},baseline_shifted{6},baseline_shifted{7},baseline_shifted{8},baseline_shifted{9},baseline_shifted{10},baseline_shifted{11},baseline_shifted{12},baseline_shifted{13},baseline_shifted{14},baseline_shifted{15},baseline_shifted{16},baseline_shifted{17},baseline_shifted{18},baseline_shifted{19},baseline_shifted{20},baseline_shifted{21},baseline_shifted{22},baseline_shifted{23},baseline_shifted{24},baseline_shifted{25},baseline_shifted{26},baseline_shifted{27},baseline_shifted{28},baseline_shifted{29},baseline_shifted{30},baseline_shifted{31},baseline_shifted{32},baseline_shifted{33},baseline_shifted{34},baseline_shifted{35},baseline_shifted{36},baseline_shifted{37},baseline_shifted{38},baseline_shifted{39},baseline_shifted{40},baseline_shifted{41},baseline_shifted{42},baseline_shifted{43}};
% trial wise points are saved in plot_var
for i= 1:length(plot_var)
    left_align(i,:)= plot_var{:,i};
end
avv={};
for j= 1:fina
    avv= [avv,mean(left_align(:,j))];
end
%plot([avv{:}]);
final_plot= [avv{:}];
final_plot(final_plot == 0)= NaN;
y_er= final_plot;
x_er= 1:length(avv);
%SD = (std(final_plot))*0.05;
%err= SD*ones(size(y_er));
err=[];
for i= 1:length(final_plot)
    err= [err,(std(left_align(:,i))*sqrt(length(bhvmat.AnalogData)-length(final_plot)))/(sqrt(length(final_plot)*(length(bhvmat.AnalogData)-1)))];
end
subplot(2,1,1);
errorbar(x_er,y_er,err)
%plot(final_plot,'o','Linewidth',5)
%plot(errorbar)
title('Left Alignment for Reaction time')
xlabel('trial number');
ylabel('avg of pupil data');
%% right aligned data plot
right_align= zeros(length(all_patches),fina); 

for i= 1:length(all_patches)
    right_align(i,((fina+1)-length(var{i})):fina)= backup{i};
end
avv_right={};
for j= 1:fina
    avv_right= [avv_right,mean(right_align(:,j))];
end
%plot([avv_right{:}]);
final_plot_right= [avv_right{:}];
final_plot_right(final_plot_right == 0)= NaN;
y_er= final_plot_right;
x_er= 1:length(avv_right);
%SD = (std(final_plot))*0.05;
%err= SD*ones(size(y_er));
err=[];
for i= 1:length(final_plot_right)
    err= [err,(std(right_align(:,i))*sqrt(length(bhvmat.AnalogData)-length(final_plot_right)))/(sqrt(length(final_plot_right)*(length(bhvmat.AnalogData)-1)))];
end
subplot(2,1,2);
errorbar(x_er,y_er,err)
%plot(final_plot,'o','Linewidth',5)
%plot(errorbar)
title('Right Alignment plot for Reaction Time data')
xlabel('trial number');
ylabel('avg of pupil data');