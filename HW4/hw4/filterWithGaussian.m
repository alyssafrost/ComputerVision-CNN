function filterWithGaussian (im)

for sigma = 1:3:10
  filter = fspecial ('gaussian', 31, sigma); % build filter
  smoothed_im = imfilter (im, filter);       % apply filter
  imshow (smoothed_im);
  pause;
end