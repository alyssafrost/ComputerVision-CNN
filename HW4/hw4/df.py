import numpy as np
import cv2 as cv
import matplotlib as mpl
import matplotlib.pyplot as plt


def df(n):
    """Show the Prewitt and Sobel derivatives.
    Params: im (grayscale image)
    Returns:
    """

    pass

    # % Prewitt and Sobel derivatives
    # % im: grayscale image

    # hp_horz = fspecial ('prewitt'); %df/dy: measure change vertically so horiz edge
    # hp_vert = hp_horz';
    # im_horz_prew = imfilter (im, hp_horz);
    # im_vert_prew = imfilter (im, hp_vert);

    # hs_horz = fspecial ('sobel'); %df/dy: measure change vertically so horiz edge
    # hs_vert  = hs_horz';
    # im_horz_sobel  = imfilter (im, hs_horz);
    # im_vert_sobel  = imfilter (im, hs_vert);

    # subplot (2,2,1); imshow (im_horz_prew); title ('Prewitt, horizontal edges');
    # subplot (2,2,2); imshow (im_vert_prew); title ('Prewitt, vertical edges');
    # subplot (2,2,3); imshow (im_horz_sobel); title ('Sobel, horizontal edges');
    # subplot (2,2,4); imshow (im_vert_sobel); title ('Sobel, vertical edges');
