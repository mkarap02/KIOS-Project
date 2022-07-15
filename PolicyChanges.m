clc;
clear all;

% Import the csv file in table
latest = readtable('latest_combined.csv');

j=2;
countChanges=0; %Counter for counting the Policy Changes

%Initialization of the table that records the Policy Changes
Date=zeros(1,1);
C1_SchoolClosing=zeros(1,1);                    
C2_WorkplaceClosing=zeros(1,1);                 
C3_CancelPublicEvents=zeros(1,1);               
C4_RestrictionsOnGatherings=zeros(1,1);         
C5_ClosePublicTransport=zeros(1,1);             
C6_StayAtHomeRequirements=zeros(1,1);           
C7_RestrictionsOnInternalMovement=zeros(1,1);   
C8_InternationalTravelControls=zeros(1,1);      

tab=table(Date,C1_SchoolClosing,C2_WorkplaceClosing,C3_CancelPublicEvents,C4_RestrictionsOnGatherings,C5_ClosePublicTransport,C6_StayAtHomeRequirements,C7_RestrictionsOnInternalMovement,C8_InternationalTravelControls);

%First row of Policy changes table 
tab.Date(1)=latest.Date(1);
tab.C1_SchoolClosing(1)=latest.C1_SchoolClosing(1);
tab.C2_WorkplaceClosing(1)=latest.C2_WorkplaceClosing(1);
tab.C3_CancelPublicEvents(1)=latest.C3_CancelPublicEvents(1);
tab.C4_RestrictionsOnGatherings(1)=latest.C4_RestrictionsOnGatherings(1);
tab.C5_ClosePublicTransport(1)=latest.C5_ClosePublicTransport(1);
tab.C6_StayAtHomeRequirements(1)=latest.C6_StayAtHomeRequirements(1);
tab.C7_RestrictionsOnInternalMovement(1)=latest.C7_RestrictionsOnInternalMovement(1);
tab.C8_InternationalTravelControls(1)=latest.C8_InternationalTravelControls(1);


for i=2:918
    
    if (abs(latest.C1_SchoolClosing(i)-latest.C1_SchoolClosing(i-1))>=0.5) || (abs(latest.C2_WorkplaceClosing(i)-latest.C2_WorkplaceClosing(i-1))>=0.5) || (abs(latest.C3_CancelPublicEvents(i)-latest.C3_CancelPublicEvents(i-1))>=0.5) || (abs(latest.C4_RestrictionsOnGatherings(i)-latest.C4_RestrictionsOnGatherings(i-1))>=0.5) || (abs(latest.C5_ClosePublicTransport(i)-latest.C5_ClosePublicTransport(i-1))>=0.5) || (abs(latest.C6_StayAtHomeRequirements(i)-latest.C6_StayAtHomeRequirements(i-1))>=0.5) || (abs(latest.C7_RestrictionsOnInternalMovement(i)-latest.C7_RestrictionsOnInternalMovement(i-1))>=0.5) || (abs(latest.C8_InternationalTravelControls(i)-latest.C8_InternationalTravelControls(i-1))>=0.5)
        
        tab.Date(j) = latest.Date(i);
        
        tab.C1_SchoolClosing(j) = latest.C1_SchoolClosing(i);
        tab.C2_WorkplaceClosing(j) = latest.C2_WorkplaceClosing(i);
        tab.C3_CancelPublicEvents(j) = latest.C3_CancelPublicEvents(i);
        tab.C4_RestrictionsOnGatherings(j) = latest.C4_RestrictionsOnGatherings(i);
        tab.C5_ClosePublicTransport(j) = latest.C5_ClosePublicTransport(i);        
        tab.C6_StayAtHomeRequirements(j) = latest.C6_StayAtHomeRequirements(i);        
        tab.C7_RestrictionsOnInternalMovement(j) = latest.C7_RestrictionsOnInternalMovement(i);        
        tab.C8_InternationalTravelControls(j) = latest.C8_InternationalTravelControls(i);        
        
        countChanges=countChanges+1;
        j=j+1;
    end
    
end
