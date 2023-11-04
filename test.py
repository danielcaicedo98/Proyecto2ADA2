import os
from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        archivo = request.files["archivo"]
        if archivo:            
            archivo_nombre = archivo.filename   
            # Obtén la ruta completa del archivo temporal
            ruta_completa = os.path.abspath(archivo_nombre)
            print("Ruta del archivo temporal:", ruta_completa)

    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)
# # import tkinter as tk
# # from tkinter import filedialog
# # import minizinc

# # # Función para resolver el modelo MiniZinc
# # def resolver_modelo():
# #     # Obtiene la ruta del archivo seleccionado
# #     archivo = filedialog.askopenfilename()

# #     if archivo:
# #         # Crea un entorno MiniZinc
# #         gecode = minizinc.Solver.lookup("coin-bc")

# #         # Carga el modelo MiniZinc
# #         model = minizinc.Model(archivo)

# #         # Crea una instancia del modelo
# #         instance = minizinc.Instance(gecode, model)

# #         # Resuelve la instancia
# #         result = instance.solve()

# #         # Comprueba si se encontró una solución
# #         if result:
# #             resultado_label.config(text="Solución encontrada:")
# #             resultado_label.config(text=result)
# #         else:
# #             resultado_label.config(text="No se encontró solución.")

# # # Configuración de la ventana
# # ventana = tk.Tk()
# # ventana.title("Seleccionar Archivo MiniZinc")

# # # Botón para seleccionar un archivo
# # seleccionar_boton = tk.Button(ventana, text="Seleccionar Archivo", command=resolver_modelo)
# # seleccionar_boton.pack(pady=10)

# # # Etiqueta para mostrar el resultado
# # resultado_label = tk.Label(ventana, text="")
# # resultado_label.pack()

# # ventana.mainloop()


# from flask import Flask, render_template, request
# import minizinc
# import os

# app = Flask(__name__)

# @app.route("/", methods=["GET", "POST"])

# def index():
#     if request.method == "POST":
#         archivo = request.files["archivo"]
#         if archivo:
#             # Guarda el archivo temporalmente
#             archivo.save(archivo.filename)

#             # Crea un entorno MiniZinc
#             gecode = minizinc.Solver.lookup("coin-bc")

#             # Carga el modelo MiniZinc desde el archivo
#             model = minizinc.Model(archivo.filename)

#             # Crea una instancia del modelo
#             instance = minizinc.Instance(gecode, model)

#             # Resuelve la instancia
#             result = instance.solve()

#             # Comprueba si se encontró una solución
#             if result:
#                 resultado = "Solución encontrada:<br>" + str(result)
#             else:
#                 resultado = "No se encontró solución."

#             # Borra el archivo temporal
#             os.remove(archivo.filename)

#             return resultado

#     return render_template("index.html")

# if __name__ == "__main__":
#     app.run(debug=True)

# from flask import Flask, render_template, request, send_file
# import minizinc
# import os

# app = Flask(__name__)

# @app.route("/", methods=["GET", "POST"])
# def index():
#     if request.method == "POST":
#         archivo = request.files["archivo"]
#         if archivo:
#             # Guarda el archivo temporalmente
#             archivo_nombre = archivo.filename
#             archivo_copia_nombre = f"temp_{archivo_nombre}"
#             archivo.save(archivo_copia_nombre)

#             # Carga el archivo .dzn en MiniZinc
#             dzn_model = minizinc.Model(archivo_copia_nombre)

#             # Crea un entorno MiniZinc
#             gecode = minizinc.Solver.lookup("coin-bc")

#             # Carga el modelo genérico MiniZinc
#             model = minizinc.Model("./Alimento.mzn")  # Reemplaza con la ubicación de tu modelo

#             # Crea una instancia del modelo genérico
#             instance = minizinc.Instance(gecode, model)

#             # Configura los datos de entrada usando el archivo .dzn
#             instance.add_file(dzn_model)
#             #instance._includes(archivo_copia_nombre)

#             # Resuelve la instancia del modelo genérico
#             result = instance.solve()

#             # Comprueba si se encontró una solución
#             if result:
#                 resultado = "Solución encontrada:<br>" + str(result)
#             else:
#                 resultado = "No se encontró solución."

#             # Borra el archivo copiado
#             os.remove(archivo_copia_nombre)

#             return resultado

#     return render_template("index.html")

# if __name__ == "__main__":
#     app.run(debug=True)
