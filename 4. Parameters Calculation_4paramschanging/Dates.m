function [Trajectories] = Dates(Trajectories,date1,date2)

    infmt='dd/MM/yyyy';
    datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')

    toDelete = Trajectories.Dates<date1;
    Trajectories(toDelete,:) = [];
   
    toDelete = Trajectories.Dates>date2;
    Trajectories(toDelete,:) = [];
end

