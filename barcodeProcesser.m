% Resets command window and figures on run
clc;
clear all;
close all;

% Read CSV data and plots data to figure 1
csvData = readmatrix('a.csv');
plot(csvData)

% Filter data using moving average with window size of 12
% Plots the averaged data to figure 1
ws = 12;
for i = 1:length(csvData)-(ws-1)
     dataAvg(i) = sum(csvData(i:i+(ws-1)))/ws;
end;
hold on
plot(dataAvg)


% Calculates the bar edges using discrete difference
% Plots the data to a new figure 2
for i = 1:length(dataAvg)-1
    dataDiff(i) = abs(dataAvg(i+1)-dataAvg(i));
end
figure;
hold on
plot(dataDiff)

% Filter differenced data using moving average with window size of 9
% Plots the averaged data to figure 2
ws = 9;
for i = 1:length(dataDiff)-(ws-1)
     dataAvgDiff(i) = sum(dataDiff(i:i+(ws-1)))/ws;
end;
hold on
plot(dataAvgDiff)

% Finds the peaks from the differenced data
[peaks, locations] = findpeaks(dataAvgDiff, 'MinPeakHeight', 1, 'MinPeakDistance', 10);
plot(locations, peaks, 'or');

% Calculates the width between each consecutive location
for i = 1:length(locations)-1
    widths(i) = locations(i+1)-locations(i);
end

% Finds the minimum value from widths
minWidth = widths(1);
for i = 2:length(widths)
    if widths(i) < minWidth
        minWidth = widths(i);
    end
end

% Corrects the widths to either 1 or 3
for i = 1:length(widths)
    widths(i) = widths(i)/minWidth;

    if widths(i) >= 2
        widths(i) = 3;
    else
        widths(i) = 1;
    end
end

% Removes spaces from  widths
filteredWidths = strrep(num2str(widths), ' ', '');

% Lookup Table
% Ascii code for capitalized letters start at 65 for 'A'
% Uses the table index + 64 to get the letter
LOOKUPTABLE = [
    311113113; %A
    113113113; %B
    313113111; %C
    111133113; %D
    311133111; %E
    113133111; %F
    111113313; %G
    311113311; %H
    113113311; %I
    111133311; %J
    311111133; %K
    113111133; %L
    313111131; %M
    111131133; %N
    311131131; %O
    113131131; %P
    111111333; %Q
    311111331; %R
    113111331; %S
    111131331; %T
    331111113; %U
    133111113; %V
    333111111; %W
    131131113; %X
    331131111; %Y
    133131111; %Z
]; 
barcode = str2num(filteredWidths);
index = find(LOOKUPTABLE == barcode);
letter = char(64+index);

% Prints the barcode and corresponding letter
fprintf('Barcode: %d\nLetter: %s\n', barcode, letter);