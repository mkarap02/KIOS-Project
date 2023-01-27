clc;
clear all;

reinfections=readtable("reinfections.csv");
%reinfections.csv here is the file with the data after 08/05/2022 deleted.
cleared_reinfections=reinfections;
sz1=height(reinfections);
cases=readtable("ClearedCasesData.csv");
sz2=height(cases);

%Clear Bad Data from Reinfections file

for i=1:sz1
    %Remove data that have the same old_id and reinfection_id
    if (reinfections.ReinfectionID(i) == reinfections.OldCaseID(i))
        cleared_reinfections(i,:)=[];
    end
end

cleared2_reinfections=cleared_reinfections;
newsize=height(cleared_reinfections);

for i=1:newsize
    for j=1:sz2
        %Remove data that the reinfection date is not the same in two files
        if ((cleared_reinfections.ReinfectionID(i) == cases.CaseID(j)) && (cleared_reinfections.DateOfFirstSampling(i) ~= cases.FirstSampling(j)))
            cleared2_reinfections(i,:)=[];
        end
    end
end
