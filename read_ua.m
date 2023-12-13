%% 批量读取中国强震数据ua格式文件中的可用信息
%% 变量data为读取结果
%% email：cleanchen@163.com
%% github：https://github.com/chen-kelin 

clear;clc
path = 'data\';
files = dir('data\*.dat');

n = 1;
DATA = struct;
for i = 1:3:length(files)
    file1_path = [path files(i).name];
    file2_path = [path files(i+1).name];
    file3_path = [path files(i+2).name];
    data1 = importdata(file1_path);
    s = data1.textdata;
    s_1 = regexp(s{2},' ','split');
    eqcode = s_1{1};
    eqtime = [s_1{2} ' ' s_1{3} ' ' s_1{4}];
    eqname = s{3};

    s_1 = regexp(s{4},'\d+(\.?)\d*','match');
    if length(s_1)==3
        lat_eqk = str2num(s_1{1});
        lon_eqk = str2num(s_1{2});
        depth = str2num(s_1{3});
    else
        lat_eqk = str2num(s_1{1});
        lon_eqk = str2num(s_1{2});
        depth = 0;
    end

    s_1 = regexp(s{5},'\d+(\.?)\d*','match');
    Mag = str2num(s_1{1});

    s_1 = regexp(s{6},':','split');
    s_2 = regexp(strtrim(s_1{2}),' ','split');
    staname =  s_2{1};
    s_1 = regexp([s_2{2:end}],'\d+(\.?)\d*','match');
    lat_sta = str2num(s_1{1});
    lon_sta = str2num(s_1{2});

    s_1 = regexp(s{7},':','split');
    site = s_1{2};

    s_1 = regexp(s{10},'\.','split');
    zb = strtrim(s_1{2});

    s_1 = regexp([s{12}],'\d+(\.?)\d*','match');
    eval(['number_' zb ' = str2num(s_1{1});'])
    dt = str2num(s_1{2});

    s_1 = regexp([s{13}],'(\-?)\d+(\.?)\d*','match');
    eval(['pga_' zb ' = str2num(s_1{1});'])

    eval([zb ' = data1.data;'])

    data2 = importdata(file2_path);
    s = data2.textdata;
    s_1 = regexp(s{10},'\.','split');
    zb = strtrim(s_1{2});
    s_1 = regexp([s{12}],'\d+(\.?)\d*','match');
    eval(['number_' zb ' = str2num(s_1{1});'])
    s_1 = regexp([s{13}],'(\-?)\d+(\.?)\d*','match');
    eval(['pga_' zb ' = str2num(s_1{1});'])
    eval([zb ' = data2.data;'])

    data3 = importdata(file3_path);
    s = data3.textdata;
    s_1 = regexp(s{10},'\.','split');
    zb = strtrim(s_1{2});
    s_1 = regexp([s{12}],'\d+(\.?)\d*','match');
    eval(['number_' zb ' = str2num(s_1{1});'])
    s_1 = regexp([s{13}],'(\-?)\d+(\.?)\d*','match');
    eval(['pga_' zb ' = str2num(s_1{1});'])
    eval([zb ' = data3.data;'])

    data.eqcode = eqcode;
    data.eqtime = eqtime;
    data.eqname = eqname;
    data.lat_eqk = lat_eqk;
    data.lon_eqk = lon_eqk;
    data.depth = depth;
    data.Mag = Mag;
    data.staname = staname;
    data.lat_sta = lat_sta;
    data.lon_sta = lon_sta;
    data.site = site;
    data.number_EW = number_EW;
    data.number_NS = number_NS;
    data.number_UD = number_UD;
    data.dt = dt;
    data.pga_EW = pga_EW;
    data.pga_NS = pga_NS;
    data.pga_UD = pga_UD;
    data.EW = reshape_(EW);
    data.NS = reshape_(NS);
    data.UD = reshape_(UD);

    na = ['data' num2str(n)];
    eval([na ' = data;'])

    eval(['DATA.' na ' = ' na])
    n = n + 1;
end
data=struct2cell(DATA); 
clearvars -except data

%% 
function f = reshape_(arr)
    f = [];
    for i = 1:size(arr,1)
        f = [f arr(i,:)];
    end
end

