clear;clc;

polygon=load('PNE.basin');

fid=fopen('llh.out','r');
blh=textscan(fid,'%s %f %f %f');
fclose(fid);

plot(polygon(:,1),polygon(:,2));
hold on
% load coast;
% plot(long,lat,'color',[0,0,0],'LineWidth',2);

in=inpolygon(blh{3},blh{2},polygon(:,1),polygon(:,2));
index=find(in==1);

hold on
plot(blh{3}(in),blh{2}(in),'or');
set(gca,'xlim',[-128 -108],'ylim',[40 50]);

for i=1:length(index)
    if ~exist(['GPS/' char(blh{1}(index(i)))  '.tenv3'],'file')
        wget=['wget -r -c -np -nd -P GPS http://geodesy.unr.edu/gps_timeseries/tenv3/IGS14/' char(blh{1}(index(i)))  '.tenv3'];
        system(wget);
    end
end