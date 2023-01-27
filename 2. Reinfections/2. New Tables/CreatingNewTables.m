clear all;
clc;

Reinfections = readtable('Reinfections_ClearResults.csv');
reinfect=height(Reinfections);
CasesData = readtable('ClearedCasesData.csv');
data=height(CasesData);

NewCasesDataTable = CasesData;

for i=1:reinfect
    for j=1:data
        if (Reinfections.ReinfectionID(i) == CasesData.CaseID(j))

            %Table with the full info about the re-infected case:
            NewReinfectionsTable(i,:)=CasesData(j,:);
            
        end
    end
end
