import numpy as np
import cv2 as cv
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.image as im


def filterWithGaussian(image):
    """Apply the gaussian filter to an image
    Params: (ndarray): An image to run the provided filter
    Displays: An image to be blurred on each step through"""

    for sigma in range(1, 11, 3):
        smoothed_image = cv.GaussianBlur(image, [31, 31], sigma)
        cv.imshow("Smoothed", smoothed_image)
        cv.waitKey(0)


if __name__ == "__main__":
    image = im.imread("graypeppers.jpg")
    filterWithGaussian(image)
    cv.destroyAllWindows()
