#!/usr/bin/env python3
# CSx73 Computer Vision HW1 22sp
# Run this in anaconda to see the results with the special yaml.


"""
I declare that I have developed this code entirely on my own.
I have read the UAB Academic Integrity Code and understand that any breach
of this code may result in severe penalties, including failure of the class.
Digital signature (type your name): Alyssa Frost
"""

# all scalars are np.uint8
# you should add test calls, but please comment them out before submitting
# (leave them in as evidence of your thought process)

import numpy as np
import cv2 as cv
from typing import Tuple

# Helper functions listed here to keep the rest of the homework file readable.


def grayscale(b, g, r) -> int:
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def applyFunctionToImage(img: np.ndarray, funct, **kwargs) -> np.ndarray:

    for column in range(len(img)):
        for row in range(len(img[column])):
            img[column, row] = funct(*img[column, row], **kwargs)

    return img


def threshold(b, g, r, val=0) -> int:
    x = grayscale(b, g, r)
    return 255 if x > val else 0


def what5() -> np.ndarray:
    """Generate the image in what5.png (or as close to it as you can).

    Returns: (np.ndarray) simulation of what5.png
    """

    img = np.ones((1794, 598, 3), dtype=np.uint8)

    #  row      width   channel
    img[0:598, 0:598, 0] *= 255  # blue in this quadrant: where is it?
    img[598:1195, 0:598, 1] *= 255  # green in this quadrant
    img[1195:1794, 0:598, 2] *= 255  # red 598+

    # Extra color layer on channel 0
    # ---
    # img[:, :, :] *= 255 # placeholder square
    img[199:398, 299:598, 1] *= 255  # adding an additional 255, making cyan
    img[398:598, 299:598, 2] *= 255  # adding 225, but to make magenta

    # Extra color layer on channel 1
    # ---
    img[597:796, 299:598, 0] *= 255
    # img[:, :, :] *= 255 remains pure green, so no changes
    img[995:1194, 299:598, 2] *= 255  # adding 225, but to make magenta

    # Extra color layer on channel 2
    # ---
    img[1194:1393, 299:598, 0] *= 255  # placeholder square
    img[1393:1592, 299:598, 1] *= 255  # adding an additional 255, making cyan
    # img[398:597, 299:598, 2] *= 255 pure red, left out

    return img


# Test code to visualize the generated image
# ---
# resize = cv.resize(what5(), (299,897))
# cv.imshow("image coordinates",  resize)
# cv.waitKey()
# cv.destroyAllWindows()


def luminance(img: np.ndarray) -> np.ndarray:
    """Compute the luminance of a colour image using the ITU-R BT.709.6 formula.

    Params: img (np.ndarray) colour image
    Returns: (np.ndarray) grayscale image
    """
    # Translate into grayscale
    # gray = .2126 * red + .7152 * green + .0722 * blue

    # this is very slow lol

    return applyFunctionToImage(img, grayscale)


# Test to see what5 in grayscale
# ---
# lum = luminance(what5())
# resize = cv.resize(lum, (299,897))
# cv.imshow("image coordinates",  resize)
# cv.waitKey()
# cv.destroyAllWindows()


def thresh1(img: np.ndarray, val: int) -> np.ndarray:
    """Threshold a colour image to a bitmap. OpenCV version

    Algorithm: translate to grayscale, map all pixels above val to white.

    Params:
        img (np.ndarray) colour image
        val (int) threshold value in [0,255]
    Returns: (np.ndarray) bitmap: white if above the threshold value, else black
    """

    # return and image, _, pipes it to null
    _, img = cv.threshold(luminance(img), val, 255, cv.THRESH_BINARY)

    return img


# Test to see what5 with opencv's bitmap
# ---
# th = thresh1(what5(), 180)
# resize = cv.resize(th, (299,897))
# cv.imshow("image coordinates",  resize)
# cv.waitKey()
# cv.destroyAllWindows()


def thresh2(img: np.ndarray, val: int) -> np.ndarray:
    """Threshold a colour image to a bitmap. Numpy version yourself.

    Algorithm: translate to grayscale, map all pixels above val to white.

    Params:
        img (np.ndarray) colour image
        val (int) threshold value in [0,255]
    Returns: (np.ndarray) bitmap: white if above the threshold value, else black
    """

    return applyFunctionToImage(img, threshold, val=val)


# Test to see what5 in bitmap with function pointer
# ---
# th = thresh1(what5(), 180)
# resize = cv.resize(th, (299,897))
# cv.imshow("image coordinates",  resize)
# cv.waitKey()
# cv.destroyAllWindows()


def chess(n: int, w: int) -> np.ndarray:
    """Chessboard.
    [473: b/w; see pdf]

    Params:
        n (int) number of squares in the chessboard
        w (int) width of each square in pixels

    Returns: (np.ndarray) chessboard image
    """

    # Alternating bit

    chessboard = np.zeros((n, n, 1), dtype=np.uint8)

    vertical = 0
    horizontal = 0
    color = 0

    # odd and even
    for column in range(len(chessboard)):
        vertical += 1
        if vertical > w:
            vertical = 0
            color = 0 if color else 255
        for row in range(len(chessboard[column])):
            horizontal += 1
            if horizontal > w:
                horizontal = 1
                color = 0 if color else 255
            chessboard[column, row] = color

    return chessboard


# Test for chessboard
# ---
# chessboard = chess(500, 50)

# cv.imshow("image coordinates", chessboard)
# cv.waitKey()
# cv.destroyAllWindows()
