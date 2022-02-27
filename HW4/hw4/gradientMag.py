import cv2 as cv
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.image as im
from statistics import mean as mean
import numpy as np
from math import sqrt


def gradientMag(image, thresh):
    """Filter the edges of an image by the angle "direction"
    Params: image (ndarray): An image
    thresh (int): Minimum gradient mag for bitmap
    Displays: Pyplot of four gmag visuals
    """

    gmag = image

    gaussian = cv.GaussianBlur(image, (3, 3), 0)
    print("Max gmag", np.max(gmag))
    print("Mean gmag", np.mean(gmag))
    s_horizontal = cv.Sobel(image, cv.CV_8U, 1, 0, ksize=5)
    s_vertical = cv.Sobel(image, cv.CV_8U, 0, 1, ksize=5)

    gmag_thresh = gmag <= thresh

    fig, axs = plt.subplots(2, 2)
    fig.suptitle("")

    axs[0, 0].imshow(gmag, cmap="gray")

    axs[0, 1].imshow(((s_horizontal + 4) / 8), cmap="gray")

    axs[1, 0].imshow(s_vertical / (4 * sqrt(2)), cmap="gray")

    axs[1, 1].imshow(gmag_thresh, cmap="gray")

    plt.show()


if __name__ == "__main__":
    image = im.imread("graypeppers.jpg")
    gradientMag(image, 1)
