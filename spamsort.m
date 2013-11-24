function filenames = spamsort(mail_directory, spam_directory, ham_directory, dictionary_filename, spam_prior_probability) 

%SPAMSORT sorts email files into spam and ham (i.e., not spam).
%   The input mail_directory indicates file paths in which to look for 
%   ASCII text files. The dictionary_filename specifies where to find a
%   dictionary file. Using the information in the dictionary file, this
%   function moves all files from the mail directory into either the
%   spam_directory or the ham_directory, based on a naïve Bayesian
%   classifier.
%
%   Author: Josh Jacobson
%   Default run: spamsort('emails', 'classified_as_spam', 'classified_as_ham', 'dictionary.txt', 0.5) 
    
    % Read the email files from the given directory
    [emails, ~, filenames] = readFilesFromDirectory(mail_directory);
    emailCount = length(emails);
    
    
    % Read the dictionary file
    [dictionaryWords, spamProb, hamProb] = readDictionary('dictionary.txt');
    
    % Calculate Bayesians and sort the email files
    for i = 1:emailCount
        filename = strcat(mail_directory,'/',filenames{i});
        message = unique(emails{i}); % Consider only unique instances of words
        
        % Initialize variables for Baysian computations:
        spamValue = spam_prior_probability;
        hamValue = 1 - spam_prior_probability;
        
        % Add up the sums in the Baysians
        for j = 1:length(message)
            word = message{j};
            [~,location] = ismember(word,dictionaryWords); % Find the word's location in the dictionary
            if location ~= 0
                spamValue = spamValue + log10(spamProb(location));
                hamValue = hamValue + log10(hamProb(location));
            end
        end
        
        if spamValue > hamValue
            movefile(filename, spam_directory); % move to spam directory
        else
        movefile(filename, ham_directory); % move to ham directory
        end
    end

end