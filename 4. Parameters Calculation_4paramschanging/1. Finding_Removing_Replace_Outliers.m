%Findin, Removing and Replace Outliers.

A=cell2mat(cellParam(:,1));
B=cell2mat(cellParam1(:,1));
C=cell2mat(cellParam2(:,1));
D=cell2mat(cellParam3(:,1));

%Finding Outliers.
OutParam=isoutlier(A);
OutParam1=isoutlier(B);
OutParam2=isoutlier(C);
OutParam3=isoutlier(D);

%Finding the outliers values.
%ind=find(OutParam);

%Remove outliers.
RmParam=rmoutliers(A);
RmParam1=rmoutliers(B);
RmParam2=rmoutliers(C);
RmParam3=rmoutliers(D);

%Removing and Filling Outliers.
FillParam=filloutliers(A,"nearest");
FillParam1=filloutliers(B(129:z,1),"nearest");
FillParam2=filloutliers(C(129:z,1),"nearest");
FillParam3=filloutliers(D(129:z,1),"nearest");
