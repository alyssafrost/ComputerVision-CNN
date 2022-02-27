import numpy as np
import cv2 as cv
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.image as im
from scipy import signal as sig
from skimage.util import random_noise as noise


def medianFilter(image):
    """Creates noise over an image, and then filters the image
    Params: image (ndarray) An image to run the provided filter
    Displays: An image given salt & pepper noise, then the image filtered with medianFilter
    """

    # Create light salt and pepper noise
    im_noisy = noise(image, mode="s&p", amount=0.1)
    im_filt = sig.medfilt(im_noisy)
    cv.imshow("Noisy image", im_noisy)
    cv.waitKey(0)
    cv.imshow("Filtered Image", im_filt)
    cv.waitKey(0)
    cv.destroyAllWindows()


if __name__ == "__main__":
    image = im.imread("graypeppers.jpg")
    medianFilter(image)
