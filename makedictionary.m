function makedictionary( spam_directory, ham_directory, dictionary_filename) 
%MAKEDICTIONARY constructs a dictionary file for use in spam filtering.
%   The inputs spam_directory and ham_directory are the filepaths to two 
%   folders, each of which contains one or more ASCII text files. This
%   function constructs a space delimited dictionary file in the current 
%   directory, with filename dictionary_filename. Each line of the 
%   dictionary file has the following format: 
%   [word] [P(word|spam)] [P(word|ham)]


end

