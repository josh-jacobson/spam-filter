function rename_files(spam_directory, ham_directory)
%RENAME_FILES simply gives human-readable names to files for testing
%purposes
%   Author: Josh Jacobson
    
    % Read the inputs
    spam_files = dir(spam_directory);
    spam_filenames = {spam_files.name};
    spam_filecount = length(spam_filenames);
    
    ham_files = dir(ham_directory);
    ham_filenames = {ham_files.name};
    ham_filecount = length(ham_filenames);
    
    for i = 1:spam_filecount
        filename = spam_filenames{i}
        if filename(1) ~= '.' && ~strcmpi(filename, 'cmds') % ignore ., .., .DS_STORE and cmds
            current_path = fullfile(spam_directory, spam_filenames{i})
            new_path = fullfile(spam_directory, strcat('spam', num2str(i)))
            movefile(current_path, new_path);
        end
    end
    
    for i = 1:ham_filecount
        filename = ham_filenames{i}
        if filename(1) ~= '.' && ~strcmpi(filename, 'cmds') % ignore ., .., .DS_STORE and cmds
            current_path = fullfile(ham_directory, ham_filenames{i})
            new_path = fullfile(ham_directory, strcat('ham', num2str(i)))
            movefile(current_path, new_path);
        end
    end
    
end

