import cv2
import numpy as np
import matplotlib.pyplot as plt
import os

# Ruta del dataset
base_origin_path = os.path.join(os.getcwd(), 'dataset')

# Recorrer cada año y mes
for year in range(2015, 2024):
    for month in range(1, 13):
