       %%
       % Example 9.24 --- Deconvolution
       %%
       clear all
       x=ones(1,100);
       y=[1 zeros(1,100)]; 			% case (a), correct h
       %y=[1 zeros(1,99)]; 		% case (b), wrong h
       [h,r]=deconv(y,x);
