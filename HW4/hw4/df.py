import numpy as np
import cv2 as cv
import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.image as im


def df(image):
    """Apply the Sobel and Prewitt filters
    Params: image (ndarray): An image to run the provided filters on
    Displays: A 2x2 matplotlib image of the filters run on an image
    """

    # Make the image grayscale if it isn't; change blurred image to image_is_gray
    # image_is_gray = cv.cvtColor(image, cv.COLOR_BGR2GRAY)

    # Gaussian Blur used for filters
    gaussian = cv.GaussianBlur(image, (3, 3), 0)

    # Define a kernel (magnitude) for Prewitt's x and y directions
    # X is 111, 000, -1-1-1
    # Y is 10-1, 10-1, 10-1
    kx = np.array([[1, 1, 1], [0, 0, 0], [-1, -1, -1]])
    ky = np.array([[1, 0, -1], [1, 0, -1], [1, 0, -1]])

    # Create the 3x3 filter that fspecial in Matlab uses for vertical gradient
    # Transpose the filter to emphasize the edges
    p_horizontal = cv.filter2D(gaussian, -1, kx)
    p_vertical = cv.filter2D(gaussian, -1, ky)

    s_horizontal = cv.Sobel(gaussian, 0, 1, 0, ksize=5)
    s_vertical = cv.Sobel(gaussian, 0, 0, 1, ksize=5)
    # s_vertical = np.transpose(s_horizontal, [0, 1])  # Has some strange behavior? Resolved by calling Sobel for vertical too

    fig, axs = plt.subplots(2, 2)
    fig.suptitle("Prewitt and Sobel filters")

    # Individual test cases used for diagnostic
    # cv.imshow("Prewitt Horizontal", p_horizontal)
    # cv.waitKey(0)
    # cv.imshow("Prewitt Vertical", p_vertical)
    # cv.waitKey(0)

    # cv.imshow("Sobel Horizontal", s_horizontal)
    # cv.waitKey(0)
    # cv.imshow("Sobel Veritcal", s_vertical)
    # cv.waitKey(0)

    axs[0, 0].imshow(p_horizontal, cmap="gray")
    axs[0, 1].imshow(p_vertical, cmap="gray")
    axs[1, 0].imshow(s_horizontal, cmap="gray")
    axs[1, 1].imshow(s_vertical, cmap="gray")

    plt.show()
    # cv.destroyAllWindows()


if __name__ == "__main__":
    image = im.imread("graypeppers.jpg")
    df(image)
