function [tab] = Dates(date1,date2)

    infmt='dd/MM/yyyy';
    datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')
    
    tab = readtable('CasesData-Copy.csv');
    tab = sortrows(tab,'FirstSampling','ascend');

    toDelete = tab.FirstSampling<date1;
    tab(toDelete,:) = [];
   
    toDelete = tab.FirstSampling>date2;
    tab(toDelete,:) = [];
end

