import os

# Obtiene la ruta del directorio del script actual
directorio_actual = os.path.dirname(os.path.abspath(__file__))

# Itera sobre los archivos en el directorio actual
for archivo in os.listdir(directorio_actual):
    # Verifica si el archivo es un archivo de texto (.txt)
    if archivo.endswith(".txt"):
        # Construye la ruta completa al archivo
        ruta_archivo = os.path.join(directorio_actual, archivo)

        # Lee la quinta línea del archivo
        with open(ruta_archivo, 'r') as file:
            lineas = file.readlines()

            # print("archivo: "+archivo,lineas[4])
            if archivo =="PUEnTe2.txt":
                print("unidades y periodos"+archivo,lineas[0], archivo,lineas[1])
                # print("archivo: periodos " +archivo,lineas[0])
                print("archivo: ",archivo)
            
            # if len(lineas) >= 5 and lineas[4].startswith("5"):
            #     # Imprime el nombre del archivo si la quinta línea comienza con "5"
            #     print(f"El archivo {archivo} cumple con la condición.")
