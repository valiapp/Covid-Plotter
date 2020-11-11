function loadData
%% Data dowloading
fprintf('Downloading data from COVID-19 Data Repository by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University.\nUrl: https://github.com/CSSEGISandData/COVID-19\n')

url1 = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/';

% Cases and deaths globally
global_cases_filename = 'time_series_covid19_confirmed_global.csv'; url = [url1,global_cases_filename]; websave(global_cases_filename,url);
global_deaths_filename = 'time_series_covid19_deaths_global.csv';    url = [url1,global_deaths_filename]; websave(global_deaths_filename, url);

fprintf('Downloading finished \n')

%% Load data to covid_data cell
covid_data = cell(0);

global_cases = readtable('time_series_covid19_confirmed_global.csv');
global_deaths = readtable('time_series_covid19_deaths_global.csv');

[rows, columns] = size(global_cases);

covid_data(1, 1) = {'Country'};
covid_data(1, 2) = {'State'};

for i = 3 : columns - 2
    covid_data(1, i) = cellstr(string(global_cases{1, i + 2}));
end 

% Countries
covid_data(2:rows-1, 1) = global_cases{2:rows-1, 2};

% States
covid_data(2:rows-1, 2) = global_cases{2:rows-1, 1};

for i = 2 : rows
    for j = 5 : columns
        covid_data{i, j-2}(1) = str2double(cell2mat(global_cases{i, j}));
        covid_data{i, j-2}(2) = str2double(cell2mat(global_deaths{i, j}));
    end

end
save('covid_data.mat', 'covid_data')
end
