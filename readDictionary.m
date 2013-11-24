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
    spamProb = NaN(wordCount,1);
    hamProb = NaN(wordCount,1);
    
    % Parse the text into separate vectors
    i = 1;
    text
    for j = 1:3:length(text)
        text(j)
        words(i) = text(j);
        text(j+1)
        spamProb(i) = str2num(text(j+1));
        hamProb(i) = str2num(text(j+2));
        i = i+1;
    end
    


end

