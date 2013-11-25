% This is a driver fundtion to test the spam filter using 5-fold
% cross-validation on 1,000 input files, of which 500 are spam and 500 are
% ham. The files are pre-sorted into folders hami, spami, and testmaili for
% folds i = 1:5. The hami and spami folders contain files to be used for
% training, while the testmaili folders contain files to be used for
% validation. The files are split up in cross-validation fashion.
%
%   Author: Josh Jacobson

%{

makedictionary('spam1', 'ham1', 'dictionary1.txt');
makedictionary('spam2', 'ham2', 'dictionary2.txt');
makedictionary('spam3', 'ham3', 'dictionary3.txt');
makedictionary('spam4', 'ham4', 'dictionary4.txt');
makedictionary('spam5', 'ham5', 'dictionary5.txt');





spamsort('testmail1', 'classified_as_spam1', 'classified_as_ham1', 'dictionary1.txt', 0.5);
spamsort('testmail2', 'classified_as_spam2', 'classified_as_ham2', 'dictionary2.txt', 0.5);
spamsort('testmail3', 'classified_as_spam3', 'classified_as_ham3', 'dictionary3.txt', 0.5);
spamsort('testmail4', 'classified_as_spam4', 'classified_as_ham4', 'dictionary4.txt', 0.5);
spamsort('testmail5', 'classified_as_spam5', 'classified_as_ham5', 'dictionary5.txt', 0.5);

%}



spam_directories = {'classified_as_spam1', 'classified_as_spam2', 'classified_as_spam3', 'classified_as_spam4', 'classified_as_spam5'};
ham_directories = {'classified_as_ham1', 'classified_as_ham2', 'classified_as_ham3', 'classified_as_ham4', 'classified_as_ham5'};

error = zeros(5,1);

for i = 1:5
    files = dir(spam_directories{i});
    filenames = {files.name};
    fileCount = length(filenames);
    for j = 1:fileCount
        filename = filenames{j};
        if filename(1) == 'h' % misclassified as ham
            error(i) = error(i) + 1;
        end
    end

    files = dir(ham_directories{i});
    filenames = {files.name};
    fileCount = length(filenames);
    for j = 1:fileCount
        filename = filenames{j};
        if filename(1) == 's' %misclassified as spam
            error(i) = error(i) + 1;
        end
    end
end

error = error / 20;

fold = 1:5;
plot(fold, error);
title('Error over Five Folds');
xlabel('Fold');
ylabel('Proportion of Misclassified Emails');


