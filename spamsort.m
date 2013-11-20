function filenames = spamsort(mail_directory, spam_directory, ham_directory, dictionary_filename, spam_prior_probability) 

%SPAMSORT sorts email files into spam and ham (i.e., not spam).
%   The input mail_directory indicates file paths in which to look for 
%   ASCII text files. The dictionary_filename specifies where to find a
%   dictionary file. Using the information in the dictionary file, this
%   function moves all files from the mail directory into either the
%   spam_directory or the ham_directory, based on a naïve Bayesian
%   classifier.

    % Read the emails
    files = dir(mail_directory);
    filenames = {files.name};
    fileCount = length(filenames);
    emails = cell(1,fileCount);
    
    % ****Todo: also need to handle ., .., and DS_STORE here. Regex?
    % move everything to the spam folder, for testing purposes
    for i = 4:fileCount
        filename = strcat(mail_directory,'/',filenames{i})
        movefile(filename, spam_directory)
    end

end

