% This is a driver fundtion to test the spam filter using 5-fold
% cross-validation on 1,000 input files, of which 500 are spam and 500 are
% ham. The files are pre-sorted into folders hami, spami, and testmaili for
% i = 1:5. The hami and spami folders contain files to be used for
% training, while the testmaili folders contain files to be used for
% validation. The files are split up in cross-validation fashion.
%
%   Author: Josh Jacobson

