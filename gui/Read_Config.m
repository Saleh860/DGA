function [Methods,Datasets]=Read_Config()
    [NUM, TXT, RAW]=xlsread('Config.xlsx', 'Methods');    
    Methods = TXT(2:length(TXT(:,2)),1:4);
    
    [NUM, TXT, RAW]=xlsread('Config.xlsx', 'Datasets');
    Datasets = TXT(2:length(TXT(:,2)),1:4);
end