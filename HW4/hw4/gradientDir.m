function gradientDir (im,thresh,amin,amax) % filter edges by angle
  % im: grayscale float over [0,1]: use `im=double(im2gray(imread(fn)))/255.;`
  % thresh: min gradient magnitude for bitmap
  % amin<=amax: desired angle range (in degrees), both in [-180,180]

  [gmag gdir] = imgradient (imgradientxy(im,'sobel'));
  im_dir = gmag >= thresh & gdir >= amin & gdir <= amax;
  imshow (im_dir); title ('thresholded gdir');
