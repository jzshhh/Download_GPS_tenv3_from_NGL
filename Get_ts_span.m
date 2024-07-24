clc;clear;
udir='GPS';
form='*.pos';

fid=fopen('llh.out','r');
blh=textscan(fid,'%s %f %f %f');
fclose(fid);

start_ymd=20080101;
end_ymd  =20231231;

numdays=datenum(datevec(num2str(end_ymd),'yyyymmdd'))-datenum(datevec(num2str(start_ymd),'yyyymmdd'));
files=GetFiles(udir,form);
[n,p]=size(files);
sites = files(:,p-23:p-20);
fid1 =fopen('sites.all','wt');
for i=1:n
    fid=fopen(files(i,:),'r');
    tmp=textscan(fid,'%*s %s %*f %*f %*f %*f  %*f %*f %f %*f  %f %*f  %f %*f %f %f %f %*f %*f %*f %*f %*f %*f','headerLines',1);
    fclose(fid);
    times =str2num(datestr(datevec(char(tmp{1}),'yymmmdd'),'yyyymmdd'));
    data = [times tmp{3} tmp{2} tmp{4} tmp{6} tmp{5} tmp{7}];
    data(:,2:7)= data(:,2:7)*1000;
    data(:,2:4)= data(:,2:4)-mean(data(:,2:4));
    ok=find(data(:,1)>=start_ymd & data(:,1)<=end_ymd);
    if length(ok)>365*1
        data(ok,2:4)= data(ok,2:4)-mean(data(ok,2:4));
        fid=fopen(['./GPS1/' sites(i,:) '.pos'],'w');
        fprintf(fid,'%8d %6.2f  %6.2f  %6.2f  %5.2f %6.2f %6.2f\n',data(ok,:)');
        fclose(fid);
        plot_gps_ts(data(ok,:),sites(i,:));
        for j=1:size(blh{1})
            if strcmpi(sites(i,:),char(blh{1}(j,:)))
                if blh{3}(j)<-180
                    blh{3}(j)=blh{3}(j)+360;
                end
                fprintf(fid1,'%4s %14.9f %15.9f %12.7f\n',sites(i,:),blh{3}(j),blh{2}(j),blh{4}(j));
                break;
            end
        end
    end
end
fclose(fid1);


