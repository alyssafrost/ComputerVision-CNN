% 673 Hough homework

%% -----------------------------------------------------------------------------
% edge detection

img = imread(fullfile('input', 'square2x2.png'));

%% TODO: compute edge image img_edges

% Using Canny edge detection 
img_edges = edge(img, 'canny');

imwrite(img_edges, fullfile('output', 'square_edges.png'));

figure, imshow (img_edges), title ('edges')
fprintf('Program paused. Press enter to continue.\n');
pause;

%% -----------------------------------------------------------------------------
% accumulator array
%[H_img, theta, rho] = hough(img_edges); 

[H_img, theta, rho] = hough_lines_acc (img_edges);         % see `hough_lines_acc.m`
%% TODO: build H_img, an image of your accumulator array (Matlab has a function)

figure
imshow(H_img, [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit');
title('Accumulator array (maybe)');
xlabel('\theta')
ylabel('\rho');
axis on, axis normal;

imwrite (H_img, fullfile ('output', 'square_acc.png'));

figure, imshow (H_img), title ('accumulator array')
fprintf('Program paused. Press enter to continue.\n');
pause;

%% -----------------------------------------------------------------------------
% peaks

peaks = hough_peaks(H, 10);                                  % see associated fn
draw_highlighted_peaks (H_img, peaks, theta, rho);           % see associated fn
print (fullfile ('output', 'square_peaks.png'),'-dpng'); % outputs displayed img



fprintf('Program paused. Press enter to continue.\n');
pause;

%% -----------------------------------------------------------------------------
% lines

hough_lines_draw (img, fullfile('output', 'square_lines.png'),peaks,rho,theta);



fprintf('Program paused. Press enter to continue.\n');
pause;

%% -----------------------------------------------------------------------------
% this completes Part 1