% This is a driver fundtion to test the spam filter using 5-fold
% cross-validation on 1,000 input files, of which 500 are spam and 500 are
% ham. The files are pre-sorted into folders hami, spami, and testmaili for
% folds i = 1:5. The hami and spami folders contain files to be used for
% training, while the testmaili folders contain files to be used for
% validation. The files are split up in cross-validation fashion.
%
%   Author: Josh Jacobson

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