%%
% Example 0.6a --- Computing and saving angles and corresponding sine values
%% 
theta=0:3:360; % angles from 0 to 360 degrees in intervals of 3 degrees
thetay=sintable(theta);
save sine.mat thetay  