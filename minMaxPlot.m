% List that contains the abbreviations of the populations, used as indication on the X-axis
pops={'CHB' 'JPT' 'CHS' 'CDX' 'KHV' 'CEU' 'TSI' 'FIN' 'GBR' 'IBS' 'YRI' 'LWK' 'GWD' 'MSL' 'ESN' 'ASW' 'ACB' 'MXL' 'PUR' 'CLM' 'PEL' 'GIH' 'PJL' 'BEB' 'STU' 'ITU'};

% List of population lists, e.g. CLM=[259  201 ... ];
popLists={CHB JPT CHS CDX KHV CEU TSI FIN GBR IBS YRI LWK GWD MSL ESN ASW ACB MXL PUR CLM PEL GIH PJL BEB STU ITU};

figure
hold on
k=1;

for i=popLists
   bar(k, mean(i{1}(:)))
   errorbar(k,mean(i{1}(:)), min(i{1}), max(i{1}))
   k=k+1;
end;

set(gca, 'XTickLabel',pops, 'XTick',1:numel(pops))
