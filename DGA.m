%This script prepares the search path then launches the DGA GUI
%

%find the folder where this script is located in the file system and add it
%and all its subfolders to the search path
old_path=addpath(genpath(fileparts(which('DGA'))));

%For Octave compatibility
if ~exist('xlsread')
  pkg load io
end

%invoke the gui
DGALab
