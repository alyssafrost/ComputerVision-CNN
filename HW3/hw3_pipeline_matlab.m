% 22sp73 Computer Vision and CNN, Johnstone
% simulating the image processing pipeline on a raw image

% please use the following variable names for images at intermediate stages:
% raw:       raw image
% im_linear: linearized image
% im_zoom:   zoomed image showing Bayer pattern
% im_bggr, im_rggb, im_grbg, im_gbrg: brightened quarter-resolution RGB images
%                                     (for the 4 Bayer pattern candidates)
% im_gw, im_ww: white-balanced images under grey and white assumptions
% im_rgb:       demosaicked RGB image
% im_final:     final image

clear; close all; clc

% read the image (raw.tiff) as-is
% write its width, height, and type to the file 'hw3_pipeline_22sp73.txt'
% write its min and max values to the file
% display the image (before casting to double); use the title 'raw image'
% cast the image to double

% Reads the image in
raw = imread("raw.tiff");

% Defines the image data 
img_w = width(raw(1,:));
img_h = height(raw(:,1));
type = class(raw);
img_max = max(raw(:));
img_min = min(raw(:));

% Writes image data to txt file
fileID = fopen("hw3_pipeline.txt", 'w');
printString = "width:  %i\nheight: %i\ntype:  %s\nminimum pixel: %i\nmaximum pixel: %i\n";

fprintf(fileID, printString, img_w, img_h, type, img_max, img_min);
fclose(fileID);

% This displays the raw image
imshow(raw);
title("raw image");

% Cast image to double
raw2 = double(raw)/255;
% double(raw);

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% linearize: map black to 0 and white to 1, then clamp to [0,1]

% display the new image with the title 'linearized'
% and write to 'linearized.jpg'

% if less or = b, make 0 black
% if greater than or = to s, make 1 white
% if a pixel < 2047, then pixel = 0
% else if pixel > 13584, then pixel = 1
% else pixel = (pixel-2047)/(13584-2047)
% (pixel-b)/(s-b)

% im_linear = arrayfun(@lin,raw);
% im_linear = lin(raw);
% im_linear = normalize(raw, 'range', [0,1]); ?

b = 2047;
s = 13584;
im_linear = max(min(double((raw - b)/(s-b)), 1),0); 

imshow(im_linear), title("linearized");
imwrite(im_linear, "linearized.jpg");

% function l = lin(x)
%     b = 2047;
%     s = 13584;
%     if x < b
%         l = double(0);
%     elseif x > s 
%         l = double(1);
%     else 
%         l = double((x - b)/(s - b));
%     end 
% end 

% title("linearized");
% im_linear 
% b = 2047
% s = 13584

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 3. visualize the Bayer mosaic

% extract the 100x100 patch with top-right corner at (1000,1000)
% display a zoomed version of this image with the title
% 'visualizing the Bayer mosaic' and write to 'zoomed.jpg'

im_zoom = im_linear(1000:1100,1000:1100);

% im_2 = brighten(im_zoom);

imshow(im_zoom, 'InitialMagnification',1000);


fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 4. discover the Bayer pattern

% extract quarter-resolution images from the linearized image
% suggested variable names: top_left, top_right, bot_left, bot_right

% build 4 quarter-resolution RGB images, one per Bayer mosaic candidate
% hint: given a Bayer candidate, which subimage represents red? (draw a 2x2 box)

% cat(3, img_red, img_green, img_blue) %ensure consistent size

% display 4 brightened quarter-resolution RGB images, 
% labeled by their mosaic 4-tuple (e.g., bggr) in a 2x2 grid

% choose the best one for downstream processing (hint: use the shirt)
% write your chosen Bayer pattern choice to 'hw3_pipeline_22sp73.txt' and to the screen

% write the associated brightened quarter-resolution image to 'best_bayer.jpg'

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 5. white balance

% extract the red, blue, and green channels from the original Bayer mosaic
% (using your choice of the underlying Bayer pattern)

% white-balance the Bayer mosaic under the grey-world assumption:
% 1) find the mean of each channel
% 2) inject the white-balanced red/blue channels back into a new mosaic;
%    inject the original green channels (both of them) back too;
% call the new Bayer mosaic image im_gw 

% white-balance the Bayer mosaic using the white-world assumption:
% 1) find the maximum of each channel
% 2) inject back into a new mosaic called im_ww

% display the white-balanced images, with labels 'grey-world' and 'white-world',
% as a 2x1 grid;
% write them to 'grey_world.jpg' and 'white_world.jpg'

% probably refer to imagesc() color map here

fprintf('Program paused. Press enter to continue.\n');
pause;

% function l = lin(x)
%     b = 2047;
%     s = 13584;
%     if x < b
%         l = double(0);
%     elseif x > s 
%         l = double(1);
%     else 
%         l = double((x - b)/(s - b));
%     end 
% end 

function m = brighten(y)
    m = min(1,50*y);
end