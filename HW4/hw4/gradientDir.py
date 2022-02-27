import numpy as np
import cv2 as cv
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.image as im


def gradientDir(image, thresh, amin, amax):
    """Filter the edges of an image by the angle "direction"
    Params: image (ndarray): An image
    thresh (int): Minimum gradient mag for bitmap
    amin (int): Desired angle range -180
    amax (int): Desired angle range 180
    Displays: A thresholded gdir
    """

    sobelx = cv.Sobel(image, 0, 1, 0, ksize=5)
    sobely = cv.Sobel(image, 0, 0, 1, ksize=5)

    # image_direction = gradient_magnitude >= thresh and gradient_direction >= amin and gradient_direction <= amax:

    cv.imshow("Thresholded gradient direction", (((sobelx + sobely))))
    cv.waitKey(0)
    cv.destroyAllWindows()


if __name__ == "__main__":
    image = im.imread("graypeppers.jpg")
    gradientDir(image, 1, -180, 180)
