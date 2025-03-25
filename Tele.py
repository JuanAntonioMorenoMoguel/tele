import cv2
import numpy as np
import matplotlib.pyplot as plt
import os
from tensorflow.keras.applications import ResNet50
from tensorflow.keras.applications.resnet50 import preprocess_input, decode_predictions
from tensorflow.keras.preprocessing import image

# Ruta del dataset
base_origin_path = os.path.join(os.getcwd(), 'res')

# Cargar el modelo preentrenado
model = ResNet50(weights='imagenet')

# Función para cargar y preprocesar la imagen para ResNet50
def load_and_preprocess_image(img_path):
    img = image.load_img(img_path, target_size=(224, 224))
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array = preprocess_input(img_array)
    return img_array

# Función para clasificar la luminosidad
def clasificar_luminosidad(imagen_gris):
    # Definir umbrales
    umbrales = [50, 150]  # Oscuro < 50, Intermedio 50-150, Brillante > 150

    # Crear una imagen de clasificación (RGB)
    mapa_clasificacion = np.zeros((*imagen_gris.shape, 3), dtype=np.uint8)

    # Aplicar colores según la luminosidad
    mapa_clasificacion[imagen_gris <= umbrales[0]] = [0, 0, 255]       # Rojo (Oscuro)
    mapa_clasificacion[(imagen_gris > umbrales[0]) & (imagen_gris <= umbrales[1])] = [0, 255, 255]  # Amarillo (Intermedio)
    mapa_clasificacion[imagen_gris > umbrales[1]] = [0, 255, 0]       # Verde (Brillante)

    return mapa_clasificacion

# Recorrer cada año y mes
for year in range(2015, 2021):
    for month in range(1, 13):
        folder_path = os.path.join(base_origin_path, str(year), str(month))
        if not os.path.exists(folder_path):
            continue
        
        # Recorrer cada imagen en la carpeta
        for img_name in os.listdir(folder_path):
            img_path = os.path.join(folder_path, img_name)
            if not img_path.lower().endswith(('.png', '.jpg', '.jpeg')):
                continue
            
            # Cargar la imagen en color para visualización
            img_color = cv2.imread(img_path)
            if img_color is None:
                continue  # Saltar si la imagen no se carga correctamente

            # Convertir a escala de grises
            img_gray = cv2.cvtColor(img_color, cv2.COLOR_BGR2GRAY)

            # Generar mapa de clasificación de luminosidad
            mapa_luminosidad = clasificar_luminosidad(img_gray)

            # Cargar y preprocesar la imagen para ResNet50
            img_array = load_and_preprocess_image(img_path)
            
            # Realizar la predicción con ResNet50
            preds = model.predict(img_array)
            decoded_preds = decode_predictions(preds, top=3)[0]
            
            # Mostrar la imagen original y el mapa de luminosidad
            plt.figure(figsize=(10, 5))

            plt.subplot(1, 2, 1)
            plt.imshow(cv2.cvtColor(img_color, cv2.COLOR_BGR2RGB))
            plt.title(f"Imagen Original\nPredictions: {decoded_preds}")

            plt.subplot(1, 2, 2)
            plt.imshow(cv2.cvtColor(mapa_luminosidad, cv2.COLOR_BGR2RGB))
            plt.title("Mapa de Clasificación de Luminosidad")

            plt.show()
