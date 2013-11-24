function [finalTextArray, wordList] = readFilesFromDirectory(directory)
%READFILESFROMDIRECTORY processes all text files in a given directory
%   Author: Josh Jacobson

    numFilesToIgnore = 0;
    filesToIgnore = zeros(1,5);
    wordList = cell(0);
    
    % Read the inputs
    files = dir(directory);
    filenames = {files.name};
    fileCount = length(filenames);
    textArray = cell(1,fileCount);
    
    cd(directory);
    for i = 1:fileCount
        filename = filenames{i};
        if filename(1) == '.' || strcmpi(filename, 'cmds') % ignore ., .., .DS_STORE and cmds
            numFilesToIgnore = numFilesToIgnore + 1;
            filesToIgnore(numFilesToIgnore) = i;
        else
            % Find the end of the header
            id = fopen(filename);
            text = textscan(id, '%s', 'Delimiter', '\n');
            textLines = text{1};
            fclose(id);
            [~,dividingLine] = ismember('', textLines);
            
            % Read in the input file word by word, skipping the header
            id = fopen(filename);
            text = textscan(id, '%s', 'HeaderLines', dividingLine);
            text = text{1};
            fclose(id);
            
            textArray{i} = text;
            wordList = [wordList;text]; % Append this file's words to the word list
        end
    end
    cd('../');
    
    % Remove empty elements from the array (from ignored files)
    finalTextArray = cell(1, fileCount - numFilesToIgnore);
    i = 1;
    for j = 1:fileCount
        if ~ismember(j, filesToIgnore)
            finalTextArray{i} = textArray{j};
            i = i + 1;
        end
    end
    
    % Make the wordlist unique
    wordList = unique(wordList);

end
