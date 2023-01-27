load("workspace2.mat");

sz5=height(cleared3_reinfections);

%Remove Reinfection cases that are not included in CasesData file.
for i=1:sz5
    for j=1:sz2
        if (cleared3_reinfections.ReinfectionID(i) == cases.CaseID(j))
            cleared4_reinfections(i,:)=cleared3_reinfections(i,:);
        end
    end
end