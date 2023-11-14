from flask import Flask, render_template, request, send_file
import os
import minizinc

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        archivo = request.files["archivo"]
        if archivo:
            contenido = archivo.read().decode('utf-8')
            lines = contenido.split("\n")
            archivo_salida = "parametros.dzn"
            try:
                print(lines)
                # Leer J y K de las dos primeras líneas
                J = int(lines[0].strip())
                K = int(lines[1].strip())
                # Leer el resto de las líneas y dividirlas en grupos de 3
                # grupos = [lines[i:i + 3] for i in range(2, len(lines), 3)]
                print(lines[3].split(","))
                # Crear un diccionario para mapear las letras a las listas
                diccionario = {
                    'E': [],
                    'A': [],
                    'G': [],
                    'F': [],
                    'V': [],
                    'piso': [],
                    'techo': [],
                    'Sup': [],
                    'Inf': [],
                    'P': [],
                    'D': [],
                    'R': []
                }

                # for i, grupo in enumerate(grupos):
                for i in range(2, 14):
                    letra = list(diccionario.keys())[i - 2]
                    valores = [float(x) for x in lines[i].split(',')]
                    diccionario[letra] = valores

                # Abrir el archivo de salida para escritura
                with open(archivo_salida, 'w') as f:
                    f.write(f'J = {J};\n')
                    f.write(f'K = {K};\n')
                    for letra, valores in diccionario.items():
                        f.write(f'{letra} = {valores};\n')

                print(f'Procesamiento completado. Resultados escritos en {archivo_salida}')

            except FileNotFoundError:
                print("El archivo de entrada no existe.")
            except Exception as e:
                print(f"Ocurrió un error: {e}")

            archivo_nombre = 'modelo.mzn'

            # Crea un entorno MiniZinc
            gecode = minizinc.Solver.lookup("coin-bc")

            # Carga el modelo MiniZinc desde el archivo
            model = minizinc.Model(archivo_nombre)

            # Crea una instancia del modelo
            instance = minizinc.Instance(gecode, model)

            # Configura los parámetros o variables según sea necesario

            # Resuelve la instancia
            result = instance.solve()

            return str(result)

    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)
