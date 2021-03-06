function [H, theta, rho] = hough_lines_acc (BW, varargin)

    % Build Hough accumulator array for finding lines.
    %
    % Matlab documentation for hough(), which you are simulating:
    % http://www.mathworks.com/help/images/ref/hough.html
    %
    % Coordinate system of H
    % rows of H correspond to values of rho
    % cols of H correspond to values of theta
    %
    % Params:
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): diff between successive rho values, in pixels
    % ThetaResolution (optional): diff between successive theta values, in deg
    % 
    %
    % Returns:
    % H: accumulator array (nRho x nTheta)
    % theta: angle values, correspond to columns of H [so our binning choice]
    % rho: distance values, correspond to rows of H

    % --------------------------------------------------------------------------
    % Parse input arguments 
    % (you have not seen optional arguments before: observe how it is done)
    p = inputParser();
    addParameter (p, 'RhoResolution', 1);               % add with default value
    addParameter (p, 'ThetaResolution', 1);
    parse (p, varargin{:});                               % [populate p.Results]
    rhoStep   = p.Results.RhoResolution;
    thetaStep = p.Results.ThetaResolution;
    % --------------------------------------------------------------------------
    %% ADD YOUR CODE HERE
   
    % https://www.mathworks.com/help/images/ref/hough.html
    % H_img would be the hough transform matrix of size nrho*ntheta 
    % (rho, theta) = (xcos(theta) + ysin(theta), theta)
    
     rhoResolution = 1;
     thetaResolution = 1;

     [numofRows, numofColumns] = size(BW);
     d = sqrt((numofRows - 1)^2 + (numofColumns - 1)^2);
     nRho = 2*(ceil(d/rhoResolution)) + 1;
   
     % rho: distance values, correspond to rows of H
     rho = linspace(-nRho * rhoResolution, nRho * rhoResolution, nRho);
     % -diagonal to +diagonal
     

     % the range of theta is -90 < 0 < 90, and the angle is theta+90 w/
     % respect to the x-axis
     % theta: angle values, correspond to columns of H
     theta = linspace(-90, 90, ceil(90/thetaResolution + 1));
     %define some legnth of the two for your hough transform matrix of rho
     %* theta
     H_matrix = (length(rho)); length(theta); % do these need to be inti as zeros?

    for y = 1:numofRows % for some increment in the range of your rows
        for x = 1:numofColumns % and for some increment in the range of all of your columns,
            % if your image is (y, x) (down, then right)
            if BW(y , x)
                x0 = (x - 1) * cos(theta * pi/180) + (y - 1) * sin(theta * pi/180);
                x0 = round(x0/rhoStep) + nRho + 1;
                for i = 1:length(theta * pi/180)
                    H_matrix(x0(i), i) = H_matrix(x0(i), i) + 1;
                end
            end
        end
    end
end
