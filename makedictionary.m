function [spam, ham] = makedictionary( spam_directory, ham_directory, dictionary_filename) 
%MAKEDICTIONARY constructs a dictionary file for use in spam filtering.
%   The inputs spam_directory and ham_directory are the filepaths to two 
%   folders, each of which contains one or more ASCII text files. This
%   function constructs a space delimited dictionary file in the current 
%   directory, with filename dictionary_filename. Each line of the 
%   dictionary file has the following format: 
%   [word] [P(word|spam)] [P(word|ham)]

    % To do: set up regex or other method of parsing html, removing header

    % Read the inputs
    spam_files = dir('spam');
    spam_filenames = {spam_files.name};
    spamCount = length(spam_filenames);
    spam = cell(1,spamCount);
    
    ham_files = dir('ham');
    ham_filenames = {ham_files.name};
    hamCount = length(ham_filenames);
    ham = cell(1,spamCount);
    
    
    cd('spam');
    for i = 4:spamCount % Need to remedy this with a regex to handle ., .., ds_store
        id = fopen(spam_filenames{i});
        text = textscan(id, '%s');
        spam{i} = text{1};
        fclose(id);
    end
    
    cd('../ham');
    for i = 4:hamCount % Need to remedy this with a regex to handle ., .., ds_store
        id = fopen(ham_filenames{i});
        text = textscan(id, '%s');
        ham{i} = text{1};
        fclose(id);
    end
    cd('../');
    
    % Create the output dictionary file
    fid = fopen(dictionary_filename, 'w');
    
    a = 0.5;
    b = 0.9;
    fprintf(fid, '%s %f %f', 'word', a, b);


end

