function [Trajectories] = Dates(Trajectories,d1,d2)

    infmt='dd/MM/yyyy';
    datetime.setDefaultFormats('defaultdate','dd/MM/yyyy')

    toDelete = Trajectories.Dates<d1;
    Trajectories(toDelete,:) = [];
   
    toDelete = Trajectories.Dates>d2;
    Trajectories(toDelete,:) = [];
end

