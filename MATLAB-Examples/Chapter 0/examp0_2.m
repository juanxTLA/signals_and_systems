%%
% Example 0.2 -- Rectangular--polar conversion
%%
m=z+v
[theta,r]=cart2pol(real(m),imag(m));	% rectangular into polar form
disp(' magnitude of m');  r 			% display text in '  ' followed by r
disp(' phase of m');  theta  
[x,y]=pol2cart(theta,r)


% 	m = 17.0000 + 1.0000i
% 	magnitude of m
% 	r = 17.0294
% 	phase of m
% 	theta = 0.0588
% 	x = 17
% 	y = 1.0000