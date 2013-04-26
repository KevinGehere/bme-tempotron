function preprocessing_for_tempotron
%%load Raman Lab's data from either PNAP or PNOO.
%%The preprocessed data in the variable 'data' contains the first 20
%%trials of either dataset, each in a separate cell. Each row of the cell 
%%contains a spike train input to a single synapse; the number of rows 
%%equals the number of features, i.e. synapses.

close all;
clear;
clc;

label = 'AP';
% label = 'OO';

%load and preprocess data
if strcmp(label, 'AP')
    load RamanPNdata_AP;
    dataset = PNAP;
    t0 = 15001;
elseif strcmp(label, 'OO')
    load RamanPNdata_OO;
    dataset = PNOO;
    t0 = 2001;  
end

Nneuron = size(dataset, 2);
twin = 500;
ntbin = 8000/twin;
data = cell(1,20);

for j = 1:20
	stdata = [];
	for i = 1:Nneuron
		if i == 20 && strcmp(label, 'AP'), continue, end;
		sndata = reshape(dataset{i}(t0:t0+8000-1, j), twin, ntbin)';
		stdata = [stdata; sndata];
	end
	data{1,j} = stdata;
end

end

