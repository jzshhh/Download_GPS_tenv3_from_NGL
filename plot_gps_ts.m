function plot_gps_ts(data,sta_name)
figure(1)
subplot(3,1,1)
% data(:,2:4)=detrend(data(:,2:4));
data(:,1) =datenum(datevec(num2str(data(:,1)),'yyyymmdd'));
plot(data(:,1),data(:,2),'b.');
ylabel 'North (mm)';
datetick('x','yyyy')
% set(gca,'ylim',[-20 20]);
title(sta_name);
hold off;

subplot(3,1,2)
plot(data(:,1),data(:,3),'b.');
datetick('x','yyyy')
% set(gca,'ylim',[-20 20]);
ylabel 'East (mm)';
hold off;

subplot(3,1,3)
plot(data(:,1),data(:,4),'b.');
datetick('x','yyyy')
% set(gca,'ylim',[-30 30]);
ylabel 'Up (mm)';
xlabel('Time (year)');
hold off;
export_fig(['GPS1/' sta_name '.pdf']);
delete(figure(1));
