function [spam, ham, wordList] = makedictionary( spam_directory, ham_directory, dictionary_filename) 
%MAKEDICTIONARY constructs a dictionary file for use in spam filtering.
%   The inputs spam_directory and ham_directory are the filepaths to two 
%   folders, each of which contains one or more ASCII text files. This
%   function constructs a space delimited dictionary file in the current 
%   directory, with filename dictionary_filename. 
%
%   Each line of the dictionary file has the following format: 
%   [word] [P(word|spam)] [P(word|ham)]
%
%   Author: Josh Jacobson
%   Default run: [spam, ham, wordList] = makedictionary('smallspam', 'smallham', 'dictionary.txt');

    % Read the spam and ham files from the input directories
    [spam, spamWords, ~] = readFilesFromDirectory(spam_directory);
    [ham, hamWords, ~] = readFilesFromDirectory(ham_directory);
    
    spamCount = length(spam);
    hamCount = length(ham);
    
    % Create the output dictionary file
    fid = fopen(dictionary_filename, 'w');
    
    wordList = [spamWords;hamWords];
    wordList = unique(wordList);
    
    for i = 1:length(wordList)
        word = wordList(i);
        
        % Compute P(word|spam)
        spamProb = 0;
        for j = 1:spamCount
            if ismember(word, spam{j})
                spamProb = spamProb + 1;
            end
        end
        spamProb = spamProb + 1; % add 1 for pseudocount
        spamProb = spamProb / (spamCount+1);
        
        % Compute P(word|ham)
        hamProb = 0;
        for j = 1:hamCount
            if ismember(word, ham{j})
                hamProb = hamProb + 1;
            end
        end
        hamProb = hamProb + 1; % add 1 for pseudocount
        hamProb = hamProb / (hamCount+1); 
        
        % Print to the dictionary file
        fprintf(fid, '%s %f %f\n', wordList{i}, spamProb, hamProb);
        
    end

end

