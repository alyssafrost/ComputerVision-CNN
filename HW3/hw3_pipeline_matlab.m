% 22sp473 Computer Vision and CNN, Johnstone
% simulating the image processing pipeline on a raw image

% Alyssa Frost / 473

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
raw = double(raw);

% raw2 = double(raw)/255;
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

% testing the most viable solution for expected visibility 

b = 2047;
s = 13584;
im_linear = max(0, min((raw - b)/(s-b), 1));

% im_linear = normalize(raw, 'range', [0,1]);  
% too bright
% im_linear = max(min(double((raw - b)/(s-b)), 1),0);

% Shows the linearized image
imshow(im_linear), title("linearized");

% Writes it to a jpg
imwrite(im_linear, "linearized.jpg");

% before i figured out this was easier, but i will leave it in here
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

% Show the brightened Bayer Mosaic
im_2 = brighten(im_zoom); 
imshow(im_2, 'InitialMagnification',1000);
title("Brightened Bayer Visualization");

fprintf('Program paused. Press enter to continue.\n');
pause;

% Show the non-brightened Bayer Mosaic
imshow(im_zoom, 'InitialMagnification',1000);
title("Visualizing the Bayer Mosaic (Non-brightened)")

% Write the zoom to jpg
imwrite(im_2, "zoomed.jpg") 

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 4. discover the Bayer pattern

% conversion into grayscale grey = 0.2126R + 0.7152G + 0.0722*B

% extract quarter-resolution images from the linearized image
% suggested variable names: top_left, top_right, bot_left, bot_right

top_left = im_linear(1:2:end, 1:2:end);

top_right = im_linear(2:2:end, 1:2:end);

bot_left = im_linear(2:2:end, 1:2:end);

bot_right = im_linear(2:2:end, 2:2:end);

bggr = cat(3, top_left, top_right, bot_left);
rggb = cat(3, bot_left, top_right, top_right);
gbrg = cat(3, top_right, top_left, bot_left);
grbg = cat(3, top_right, bot_left, top_left);

% build 4 quarter-resolution RGB images, one per Bayer mosaic candidate
% hint: given a Bayer candidate, which subimage represents red? (draw a 2x2 box)

% display 4 brightened quarter-resolution RGB images, 
% labeled by their mosaic 4-tuple (e.g., bggr) in a 2x2 grid

subplot(2,2,1)
imshow(brightenByFour(bggr));
title("bggr")

subplot(2,2,2)
imshow(brightenByFour(rggb));
title("rggb")

subplot(2,2,3)
imshow(brightenByFour(gbrg));
title("gbrg")

subplot(2,2,4)
imshow(brightenByFour(grbg));
title("grbg")

% choose the best one for downstream processing (hint: use the shirt)
% write your chosen Bayer pattern choice to 'hw3_pipeline_22sp73.txt' and to the screen

fileApp = fopen("hw3_pipeline.txt", 'a');
printBayer = "Chosen Bayer Mosaic: rggb \n";
bfactor = "Brightening factor is by 4. (See function at bottom of matlab file.) \n";
fprintf(fileApp, printBayer);
fprintf(fileApp, bfactor);
fclose(fileApp);

% Write to the screen
fprintf("Chosen Bayer Pattern: rggb \n");

% write the associated brightened quarter-resolution image to 'best_bayer.jpg'
imwrite(brightenByFour(rggb), "best_bayer.jpg")

fprintf('Program paused. Press enter to continue.\n');
pause;
% -----------------------------------------------------------------------------
% 5. white balance

% extract the red, blue, and green channels from the original Bayer mosaic
% (using your choice of the underlying Bayer pattern)

% Choose the 'best' shirt choice from the four 

% white-balance the Bayer mosaic under the grey-world assumption:
% 1) find the mean of each channel
% 2) inject the white-balanced red/blue channels back into a new mosaic;
%    inject the original green channels (both of them) back too;
% call the new Bayer mosaic image im_gw 

red_channel = im_linear(1:2:end, 1:2:end);

green_1 = im_linear(2:2:end, 1:2:end);

green_2 = im_linear(2:2:end, 1:2:end);

green_channel = (green_1 + green_2)/2;

blue_channel = im_linear(2:2:end, 2:2:end);

avg_r = mean(red_channel);
avg_g = mean(green_channel);
avg_b = mean(blue_channel);

max_r = max(red_channel);
max_g = max(green_channel);
max_b = max(blue_channel);

%white world

im_ww = cat(3, new_c(red_channel, avg_g, avg_r), green_channel, new_c(blue_channel, avg_g, avg_b));
im_gw = cat(3, new_c(red_channel, max_g, max_r), green_channel, new_c(blue_channel, max_g, max_b));

% display the white-balanced images, with labels 'grey-world' and 'white-world',
% as a 2x1 grid;

subplot(2,1,1)
imshow(im_ww);
title("White World")

subplot(2,1,2)
imshow(im_gw);
title("Grey World")

% white-balance the Bayer mosaic using the white-world assumption:
% 1) find the maximum of each channel
% 2) inject back into a new mosaic called im_ww

% write them to 'grey_world.jpg' and 'white_world.jpg'

imwrite(im_ww, "white_world.jpg")
imwrite(im_gw, "grey_world.jpg")

fprintf('Program paused. Press enter to continue.\n');
pause;

subplot(2,1,1)
imshow(brightenByFour(im_ww));
title("White World (Brightened)")

subplot(2,1,2)
imshow(brightenByFour(im_gw));
title("Grey World (Brightened)")

% ------

function n = new_c(c, numerator, denominator)
    n = c * (numerator/ denominator);
end

function m = brighten(y)
    m = min(1,5*y);
end

function m = brightenByFour(y)
    m = min(1,4*y);
end