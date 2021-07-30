load('left_align_pupil.mat')
Mean_plot={};
for i=1:length(left_align(1,:))
    Mean_plot=[Mean_plot,mean(left_align(:,i))];
end
final_plot= [Mean_plot{:}];
y_er= final_plot;
x_er= 1:length(left_align(1,:));
%SD = (std(final_plot))*0.05;
%err= SD*ones(size(y_er));
err_pupil=[];
for i= 1:length(final_plot)
    err_pupil= [err_pupil,(std(left_align(:,i))*sqrt(length(bhvmat.AnalogData)-length(final_plot)))/(sqrt(length(final_plot)*(length(bhvmat.AnalogData)-1)))];
end
subplot(2,1,1);
errorbar(x_er,y_er,err_pupil)
%plot(final_plot,'o','Linewidth',5)
%plot(errorbar)
title('pupil left align p20')
xlabel('trial number');
ylabel('avg of pupil data');
%%%%%%%%%%
load('right_align_pupil.mat')
Mean_plot={};
for i=1:length(right_align(1,:))
    Mean_plot=[Mean_plot,mean(right_align(:,i))];
end
final_plot= [Mean_plot{:}];
final_plot(final_plot == 0)= NaN;
y_er= final_plot;
x_er= 1:length(right_align(1,:));
%SD = (std(final_plot))*0.05;
%err= SD*ones(size(y_er));
err_pupil=[];
for i= 1:length(final_plot)
    err_pupil= [err_pupil,(std(right_align(:,i))*sqrt(length(bhvmat.AnalogData)-length(final_plot)))/(sqrt(length(final_plot)*(length(bhvmat.AnalogData)-1)))];
end
subplot(2,1,2);
errorbar(x_er,y_er,err_pupil)
%plot(final_plot,'o','Linewidth',5)
%plot(errorbar)
title('pupil right align p20')
xlabel('trial number');
ylabel('avg of pupil data');

