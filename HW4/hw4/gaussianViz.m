% visualize a Gaussian filter
sigma = 5;
h = fspecial ('gaussian', 31, sigma);
mesh(h);
pause;
imagesc(h);  % matrix -> image (use surf for image -> matrix)
pause;