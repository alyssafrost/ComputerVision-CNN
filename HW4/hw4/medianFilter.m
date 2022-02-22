function medianFilter (im)

im_noisy = imnoise (im, 'salt & pepper', 0.02);
im_filt = medfilt2 (im_noisy);
imshow(im_noisy);
pause;
imshow(im_filt);
