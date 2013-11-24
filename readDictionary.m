function [words, spamProb, hamProb] = readDictionary(filename)
%READDICTIONARY is a custom function to read in a space-delimited dictionary file
%   Author : Josh Jacobson

    
    
    % Read in the input file word by word, skipping the header
    id = fopen(filename);
    text = textscan(id, '%s');
    text = text{1};
    wordCount = length(text) / 3;
    fclose(id);
    
    % initialize variables
    words = cell(wordCount,1);
    spamProb_cell = cell(wordCount,1);
    hamProb_cell = cell(wordCount,1);
    
    % Parse the text into separate vectors
    i = 1;
    for j = 1:3:length(text)
        words(i) = text(j);
        spamProb_cell(i) = text(j+1);
        hamProb_cell(i) = text(j+2);
        i = i+1;
    end
    
    spamProb = NaN(wordCount, 1);
    hamProb = NaN(wordCount, 1);
    
    % Convert from cell to floating point vectors
    for i = 1:wordCount
        spamProb(i) = str2num(spamProb_cell{i});
        hamProb(i) = str2num(hamProb_cell{i});
    end
    
    
    


end

