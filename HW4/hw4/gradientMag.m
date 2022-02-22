function gradientMag (im,thresh)         % viz grad magnitude of grayscale image

  % im: float over [0,1]: use `im=double(imread(fn))/255.;`
  % thresh: min gradient magnitude for bitmap (e.g., .5)

  if strcmp(class(im), 'uint8') || (max(im(:)) > 1)
      fprintf('please, I want a float [0,1] image\n')
      return
      end
      
  [gx gy] = imgradientxy (im, 'sobel');     % Cartesian components of gradient
                                            % see other options in documentation
  [gmag gdir] = imgradient (gx, gy);        % polar components of gradient
  fprintf("max gmag: %f\n", max(gmag(:)));
  fprintf("mean gmag: %f\n", mean(gmag(:)));
  gmag_thresh = gmag >= thresh;
    	      
  
  subplot (2,2,1); imshow (im);                         % over [0,1]
                   title ('I');
  subplot (2,2,2); imshow ((gx+4)/8);                   % over [-4,4] 
		   title ('df/dx');                     % why [-4,4] if Sobel?
		                                        % alt: imshow(gx,[-4,4])
  subplot (2,2,3); imshow (gmag / (4*sqrt(2)));         
                   title ('gradient magnitude');        
  subplot (2,2,4); imshow (gmag_thresh);                % over [0,1] (a bitmap)
                   title ('thresholded gmag');
  

