clc;
clear all;

% Import the csv file in table
latest = readtable('latest_combined.csv');

j=2;
countC1=0; countC2=0; countC3=0; countC4=0; countC5=0; countC6=0; countC7=0;

%Initialization of the table that records the Policy Changes
Date=zeros(1,1);
C1_SchoolClosing=zeros(1,1);                    
C2_WorkplaceClosing=zeros(1,1);                 
C3_CancelPublicEvents=zeros(1,1);               
C4_RestrictionsOnGatherings=zeros(1,1);         
C5_ClosePublicTransport=zeros(1,1);             
C6_StayAtHomeRequirements=zeros(1,1);           
C7_RestrictionsOnInternalMovement=zeros(1,1);   

Changes=table(Date,C1_SchoolClosing,C2_WorkplaceClosing,C3_CancelPublicEvents,C4_RestrictionsOnGatherings,C5_ClosePublicTransport,C6_StayAtHomeRequirements,C7_RestrictionsOnInternalMovement);

%First row of Policy changes table 
Changes.Date(1)=latest.Date(1);
Changes.C1_SchoolClosing(1)=latest.C1_SchoolClosing(1);
Changes.C2_WorkplaceClosing(1)=latest.C2_WorkplaceClosing(1);
Changes.C3_CancelPublicEvents(1)=latest.C3_CancelPublicEvents(1);
Changes.C4_RestrictionsOnGatherings(1)=latest.C4_RestrictionsOnGatherings(1);
Changes.C5_ClosePublicTransport(1)=latest.C5_ClosePublicTransport(1);
Changes.C6_StayAtHomeRequirements(1)=latest.C6_StayAtHomeRequirements(1);
Changes.C7_RestrictionsOnInternalMovement(1)=latest.C7_RestrictionsOnInternalMovement(1);

for i=2:918
    
    if ((abs(latest.C1_SchoolClosing(i)-latest.C1_SchoolClosing(i-1))>=0.5) || (abs(latest.C2_WorkplaceClosing(i)-latest.C2_WorkplaceClosing(i-1))>=0.5)|| (abs(latest.C3_CancelPublicEvents(i)-latest.C3_CancelPublicEvents(i-1))>=0.5) || (abs(latest.C4_RestrictionsOnGatherings(i)-latest.C4_RestrictionsOnGatherings(i-1))>=0.5) || (abs(latest.C5_ClosePublicTransport(i)-latest.C5_ClosePublicTransport(i-1))>=0.5) || (abs(latest.C6_StayAtHomeRequirements(i)-latest.C6_StayAtHomeRequirements(i-1))>=0.5) || (abs(latest.C7_RestrictionsOnInternalMovement(i)-latest.C7_RestrictionsOnInternalMovement(i-1))>=0.5))
        
        Changes.Date(j) = latest.Date(i);
        
        Changes.C1_SchoolClosing(j) = latest.C1_SchoolClosing(i);
        Changes.C2_WorkplaceClosing(j) = latest.C2_WorkplaceClosing(i);
        Changes.C3_CancelPublicEvents(j) = latest.C3_CancelPublicEvents(i);
        Changes.C4_RestrictionsOnGatherings(j) = latest.C4_RestrictionsOnGatherings(i);
        Changes.C5_ClosePublicTransport(j) = latest.C5_ClosePublicTransport(i);        
        Changes.C6_StayAtHomeRequirements(j) = latest.C6_StayAtHomeRequirements(i);        
        Changes.C7_RestrictionsOnInternalMovement(j) = latest.C7_RestrictionsOnInternalMovement(i);        
                
        if (abs(latest.C1_SchoolClosing(i)-latest.C1_SchoolClosing(i-1))>=0.5)
            countC1=countC1+1;
        end
        if (abs(latest.C2_WorkplaceClosing(i)-latest.C2_WorkplaceClosing(i-1))>=0.5)
            countC2=countC2+1;
        end
        if (abs(latest.C3_CancelPublicEvents(i)-latest.C3_CancelPublicEvents(i-1))>=0.5)
            countC3=countC3+1;        
        end
        if (abs(latest.C4_RestrictionsOnGatherings(i)-latest.C4_RestrictionsOnGatherings(i-1))>=0.5)
            countC4=countC4+1;
        end
        if (abs(latest.C5_ClosePublicTransport(i)-latest.C5_ClosePublicTransport(i-1))>=0.5)
            countC5=countC5+1;
        end
        if (abs(latest.C6_StayAtHomeRequirements(i)-latest.C6_StayAtHomeRequirements(i-1))>=0.5)
            countC6=countC6+1;
        end
        if (abs(latest.C7_RestrictionsOnInternalMovement(i)-latest.C7_RestrictionsOnInternalMovement(i-1))>=0.5)
            countC7=countC7+1;
        end
        
        j=j+1;
    end
    
end

countChanges=countC1+countC2+countC3+countC4+countC5+countC6+countC7;
