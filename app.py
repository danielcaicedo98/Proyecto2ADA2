from flask import Flask, render_template, request, send_file
import minizinc
import os


app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        archivo = request.files["archivo"]
        if archivo:
            # Copia el archivo a un nuevo nombre para evitar conflictos
            archivo_nombre = archivo.filename
            archivo_copia_nombre = f"temp_{archivo_nombre}"
            archivo.save(archivo_copia_nombre)

            # Crea un entorno MiniZinc
            gecode = minizinc.Solver.lookup("coin-bc")

            # Carga el modelo MiniZinc desde el archivo copiado
            model = minizinc.Model(archivo_copia_nombre)

            # Crea una instancia del modelo
            instance = minizinc.Instance(gecode, model)

            # Resuelve la instancia
            result = instance.solve()

            # Comprueba si se encontró una solución
            if result:
                resultado = "Solución encontrada:<br>" + str(result)
            else:
                resultado = "No se encontró solución."

            # Borra el archivo copiado
            os.remove(archivo_copia_nombre)

            return resultado

    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)
