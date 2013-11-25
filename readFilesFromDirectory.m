function [finalTextArray, wordList, finalFilenames] = readFilesFromDirectory(directory)
%READFILESFROMDIRECTORY processes all text files in a given directory
%   The output finalTextArray is a cell array in which each entry corresponds
%   to a file in the directory and is itself a cell array of words taken 
%   from one of the input files. wordList is a list of all unique words
%   encountered in all files in the directory, and this is in alphabetical
%   order. finalFilenames is just a cell array containing the filenames,
%   and this information is used in spam filtering to be able to move the
%   files.
%
%   A significant amount of text sanitization is appplied through the
%   process of reading files from a directory. Many delimiters are removed,
%   including normal punctuation. HTML tags are also removed by treating
%   any line starting with "<" as a comment. The entire header of every
%   email file is also removed.
%
%   Author: Josh Jacobson

    numFilesToIgnore = 0;
    filesToIgnore = zeros(1,5);
    wordList = cell(0);
    
    % Read the inputs
    files = dir(directory);
    filenames = {files.name};
    fileCount = length(filenames);
    textArray = cell(1,fileCount);
    
    for i = 1:fileCount
        filename = filenames{i};
        filepath = strcat(directory,'/',filename);
        if filename(1) == '.' || strcmpi(filename, 'cmds') % ignore ., .., .DS_STORE and cmds
            numFilesToIgnore = numFilesToIgnore + 1;
            filesToIgnore(numFilesToIgnore) = i;
        else
            % Find the end of the header
            id = fopen(filepath);
            text = textscan(id, '%s', 'Delimiter', '\n');
            textLines = text{1};
            fclose(id);
            [~,dividingLine] = ismember('', textLines);
            
            % Read in the input file word by word, skipping the header
            id = fopen(filepath);
            text = textscan(id, '%s', 'Delimiter', ' ,.;!:''0123456789<>?(){}[]"=+*/\n', 'MultipleDelimsAsOne',1, 'HeaderLines', dividingLine, 'CommentStyle', '<');
            text = text{1};
            text = lower(text);
            fclose(id);
            
            textArray{i} = text;
            wordList = [wordList;text]; % Append this file's words to the word list
        end
    end
    
    % Remove empty elements from the array (from ignored files)
    finalTextArray = cell(1, fileCount - numFilesToIgnore);
    finalFilenames = cell(1, fileCount - numFilesToIgnore);
    i = 1;
    for j = 1:fileCount
        if ~ismember(j, filesToIgnore)
            finalTextArray{i} = textArray{j};
            finalFilenames{i} = filenames{j};
            i = i + 1;
        end
    end
    
    % Ignore case and make the wordlist unique
    wordList = lower(wordList);
    wordList = unique(wordList);

end

