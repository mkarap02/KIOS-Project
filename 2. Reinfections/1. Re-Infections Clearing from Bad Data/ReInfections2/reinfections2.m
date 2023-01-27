load("workspace1.mat");

sz4=height(cleared2_reinfections);
%cleared3_reinfections=cleared2_reinfections;

%Remove Reinfection cases that are not included in CasesData file.
for i=1:sz4
    for j=1:sz2
        if (cleared2_reinfections.OldCaseID(i) == cases.CaseID(j))
            cleared3_reinfections(i,:)=cleared2_reinfections(i,:);
        end
    end
end