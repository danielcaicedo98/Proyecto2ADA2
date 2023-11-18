import minizinc

def main():
    archivo_nombre = 'modelo.mzn'

    # Crea un entorno MiniZinc
    gecode = minizinc.Solver.lookup("coin-bc")

    # Carga el modelo MiniZinc desde el archivo
    model = minizinc.Model(archivo_nombre)

    # Crea una instancia del modelo
    instance = minizinc.Instance(gecode, model)
   
    # Resuelve la instancia
    result = instance.solve()

    # Comprueba si se encontró una solución
    if result:
        # Imprime información sobre la solución encontrada
        print(result)
       
    else:
        print("No se encontró solución.")
main()
