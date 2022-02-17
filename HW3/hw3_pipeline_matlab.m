
subplot(2,2,4)
imshow(brightenByFour(grbg));
title("grbg")

% choose the best one for downstream processing (hint: use the shirt)
% write your chosen Bayer pattern choice to 'hw3_pipeline_22sp73.txt' and to the screen

%imwrite()

% write the associated brightened quarter-resolution image to 'best_bayer.jpg'

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

ww = cat(3, new_c(red_channel, avg_g, avg_r), green_channel, new_c(blue_channel, avg_g, avg_b));
gw = cat(3, new_c(red_channel, max_g, max_r), green_channel, new_c(blue_channel, max_g, max_b));

subplot(2,1,1)
imshow(ww);
title("White World")

subplot(2,1,2)
imshow(gw);
title("Grey World")

% white-balance the Bayer mosaic using the white-world assumption:
% 1) find the maximum of each channel
% 2) inject back into a new mosaic called im_ww

% display the white-balanced images, with labels 'grey-world' and 'white-world',
% as a 2x1 grid;


% write them to 'grey_world.jpg' and 'white_world.jpg'

%imwrite()

fprintf('Program paused. Press enter to continue.\n');
pause;

subplot(2,1,1)
imshow(brightenByFour(ww));
title("White World (Brightened)")

subplot(2,1,2)
imshow(brightenByFour(gw));
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