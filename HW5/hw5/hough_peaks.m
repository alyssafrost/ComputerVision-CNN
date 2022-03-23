function peaks = hough_peaks (H, varargin)

    % Find peaks in a Hough accumulator array.
    %
    % Matlab documentation for houghpeaks(), which you are simulating:
    % http://www.mathworks.com/help/images/ref/houghpeaks.html
    %
    % Params:
    % H: accumulator array (nRho x nTheta)
    % Threshold (opt): Threshold at which vals of H are considered to be peaks
    % NHoodSize (optional): Size of the suppression neighborhood, [M N]
    %
    % Returns:
    % peaks: Qx2 matrix:
    % col 1 = row indices of maxima (rho);
    % col 2 = col indices of maxima (theta)

    % --------------------------------------------------------------------------

    %% Parse input arguments
    p = inputParser;
    addOptional (p, 'numpeaks', 1, @isnumeric);
    addParameter(p, 'Threshold', 0.5 * max(H(:)));
    addParameter(p, 'NHoodSize', floor(size(H) / 100.0) * 2 + 1);
                                                      % odd values >= size(H)/50
    parse(p, varargin{:});

    numpeaks  = p.Results.numpeaks;
    threshold = p.Results.Threshold;
    nHoodSize = p.Results.NHoodSize;

    % --------------------------------------------------------------------------
    % TODO: Your code here

end
