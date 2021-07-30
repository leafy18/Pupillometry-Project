%% patch separation code
%function code_1= patch_separation_p10
    load('Experiment_P20foraging_2017-06-26.mat')
    ss= {bhvmat.UserVars.rwrd};
    s_1=[ss{:}];                % reward values in stay trials( leave trials have 0 values)
    d=find(cellfun(@isempty,ss));  
    vv= find(~cellfun(@isempty,ss)); 
    patch={};
    patch_1={};
    for j= 1:length(vv)-1
        if vv(j+1)-vv(j)~= 1
            patch=[patch,vv(j)];
            patch_1=[patch_1,vv(j+1)];
        end
    end
    pp=[patch{:}];
    pp_1=[patch_1{:}];
    next={};
    all_patches={};
    for i= 1:length(pp)-1
        patch1= 1:pp(1)+1;
        next= [next,pp_1(i):pp(i+1)+1];
        last= pp_1(length(pp_1)):length(ss);
    end
    all_patches= [all_patches,patch1,next,last];

%end     
%% error bar plot
all_patches;
var={};
for i= 1:length(all_patches)
    var=[var,bhvmat.ReactionTime(all_patches{:,i})];
end
%plot(all_patches{:,1},var{:,1},'*');
%% patch changes
final_points_mat={};
final_points={};
for i= 1:length(all_patches)
    first= var{:,i}(1);
    last= var{:,i}(length(var{:,i}));
    x = 1:length(var{:,i});
    y= var{:,i};
    xx = linspace(1,length(var{:,i}),length(var{:,i})*10);
    %pp= csapi(x,y);
    %xx(1:10)=NaN;
    %plot(xx,csapi(x,var{:,1},xx),'k-',x,y,'ro');
    point= csapi(x,var{:,i},xx);
    div=length(point)-(length(point)/length(var{:,i}));
    interval= fix(div/10);
    interp_points=[];
    for k= 1:10
        interp_points= [interp_points,point(interval*k)];
    end
    final_points=[first,interp_points,last];
    final_points_mat=[final_points_mat,final_points];
end
baseline_shifted={};
for n= 1:length(all_patches)
    baseline_shifted= [baseline_shifted,final_points_mat{1,n}-final_points_mat{1,n}(length(final_points_mat{1,n}))];
end
%plot(final_points_1,'*','Linewidth',10);
file= zeros(length(all_patches),12);         % all_patches is the total number of patches we have
plot_var={baseline_shifted{1},baseline_shifted{2},baseline_shifted{3},baseline_shifted{4},baseline_shifted{5},baseline_shifted{6},baseline_shifted{7},baseline_shifted{8},baseline_shifted{9},baseline_shifted{10},baseline_shifted{11},baseline_shifted{12},baseline_shifted{13},baseline_shifted{14},baseline_shifted{15},baseline_shifted{16},baseline_shifted{17},baseline_shifted{18},baseline_shifted{19},baseline_shifted{20},baseline_shifted{21},baseline_shifted{22},baseline_shifted{23},baseline_shifted{24},baseline_shifted{25},baseline_shifted{26},baseline_shifted{27},baseline_shifted{28},baseline_shifted{29},baseline_shifted{30},baseline_shifted{31},baseline_shifted{32},baseline_shifted{33},baseline_shifted{34},baseline_shifted{35},baseline_shifted{36},baseline_shifted{37},baseline_shifted{38},baseline_shifted{39},baseline_shifted{40},baseline_shifted{41},baseline_shifted{42},baseline_shifted{43}};
% trial wise points are saved in plot_var
for i= 1:length(plot_var)
    file(i,:)= plot_var{:,i};
end
avv={};
for j= 1:12
    avv= [avv,mean(file(:,j))];
end
plot([avv{:}])
final_plot= [avv{:}];
y_er= final_plot;
x_er= 1:length(avv);
%SD = (std(final_plot))*0.05;
%err= SD*ones(size(y_er));
err_rt=[];
for i= 1:length(final_plot)
    err_rt= [err_rt,(std(file(:,i))*sqrt(length(bhvmat.AnalogData)-length(final_plot)))/(sqrt(length(final_plot)*(length(bhvmat.AnalogData)-1)))];
end
subplot(2,1,1);
errorbar(x_er,y_er,err_rt)
%plot(final_plot,'o','Linewidth',5)
%plot(errorbar)
title('interpolation of reaction time p20')
xlabel('trial number');
ylabel('avg of pupil data');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('interpolation_p20.mat');
Mean_plot={};
for i=1:length(interpolation_p20(1,:))
    Mean_plot=[Mean_plot,mean(interpolation_p20(:,i))];
end
final_plot= [Mean_plot{:}];
y_er= final_plot;
x_er= 1:length(interpolation_p20(1,:));
%SD = (std(final_plot))*0.05;
%err= SD*ones(size(y_er));
err=[];
for i= 1:length(final_plot)
    err= [err,(std(interpolation_p20(:,i))*sqrt(length(bhvmat.AnalogData)-length(final_plot)))/(sqrt(length(final_plot)*(length(bhvmat.AnalogData)-1)))];
end
subplot(2,1,2);
errorbar(x_er,y_er,err)
%plot(final_plot,'o','Linewidth',5)
%plot(errorbar)
title('interpolation p20')
xlabel('trial number');
ylabel('avg of pupil data');
core_mat_p20= corrcoef(final_plot(:),final_points(:));
rho_p20= partialcorri(final_plot(:),final_points(:));






