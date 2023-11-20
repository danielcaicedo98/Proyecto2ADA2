Proyecto Planificacion de Unidades de Energía Térmica
El siguiente proyecto está desrrollado por Estudiantes de la Universidad del Valle para el curso de Analisisi y Diseño de Algoritmos 2.

Para ejecutar el proyecto

1. Abrir una terminal, ubicarse en el directorio PUEnTeGUIFuentes que está dentro de la carpeta de nuestro proyecto
2. Instalar Flask y minizinc, para eso puede usar el archivo requirements.txt que está dentro del directorio PUEnTeGUIFuentes
   usando el siguiente comando:
   -  pip install -r requirements.txt
   En caso de que nos funcione  con esto, usar los siguientes comandos para instalar las librerias necesarias:
   -  pip install Flask
   -  pip install minizinc
   
3. Escribir en la terminal el siguiente comando: 
   py app.py
4. Abrir la siguiente ruta en el navegador:
   http://127.0.0.1:5000/
5. Seleccionar el archivo .txt que desea resolver
6. Presionar el botón resolver y esperar a que la interfaz muestre los resultados
   esto puede llegar a tardar un poco si hay muchos datos de entrada.


Integrantes

Juan David Tovar
Sebastian Peñaranda Hurtado 
Natalia Riaños Horta
Daniel Andres Caicedo 

Archivos y Directorios entregados 
- Archivo Informe.pdf: Incluye la presentación del modelo elaborado, detalles clave de su implementación y el análisis de los resultados de las pruebas, 
  apoyándose en datos visuales. Se explica el funcionamiento del modelo y del mecanismo de Branch and Bound, además de compartir un enlace a un video 
  sobre la interfaz gráfica. Finalmente, se presentan conclusiones respaldadas por el análisis de los resultados obtenidos.

- Archivo PUEnTe.mzn: donde se implementa la solución al problema de planificacion de uidades termicas de energia, usando el lenguaje minizinc, este incluye el
  archivo "parametros.dzn" con los parametros iniciales para el problema a resolver. Contiene también las restricciones que se deben cumplir y la funcion objetivo 
  que es minimizar el costo de la produccion de energia para el horizonte planeado.

- Directorio DatosPUEnTe: donde está la batería de pruebas proporcionada por los profesores y la monitora, estos archivos son los que usamos para
  hacerle las pruebas a nuestro modelo para comparar con los resultados propuestos, para así corroborar que el modelo está arrojando los resultados
  esperados.

- Directorio PUEnTeGUIFuentes: en este directorio se encuentran los siguientes archivos 
  > Directorio tempates: directorio necesario para la implementación de la interfaz gráfica, este directorio es requerido por el Framework que estamos 
    que en este caso es Flask en su interior se encuentra un archivo llamado index.html que es donde se hacemos los componentes gráficos de nuestra interfaz
  > Archivo parametros.dzn: en este archivo nuestra interfaz gráfica escribe, a partir de la seleccion previa de un archivo .txt, los parámetros de entrada 
    para que nuestro modelo PUEnTe.dzn los pueda leer
  > Archivo requirements.txt: en este archivo se encuentra las librerías necesarias para poder usar nuestra interfaz, en nuestro caso estamos usando python
    y las librerías necesarias son: Flask y minizinc
  > Archivo app.py: este es el código que logra conectar nuestra interfaz gráfica con nuestro modelo minizinc usando python y Flask

- Directorio MisInstancias:  en este directorio tenemos las instancias que desarrolló nuestro grupo para retar a los modelos de otros grupos 
  a que resuelvan el mismo problema. Se encuetran cinco instancias:
  > Mi_Instancia1.txt: esta instancia no tiene tantos datos, 6 utpee y 7 ciclos. Es más que todo para hacer una prueba rápida.
  > Mi_Instancia2.txt: esta instancia tiene pocos datos, 6 utpee y 7 ciclos. Sin embargo lo que la diferencia es que se está teniendo en cuenta 
    si las utpee ya venian encencidas antes del primer ciclo.
  > Mi_Instancia3.txt: esta instancia tiene más datos 30 utpee y 30 ciclos. Lo que caracteriza a esta instancia es que en cada cico la demanda es muy alta
    por lo tanto la mayoría de las utpee se deben encender para cubrir esa demanda. 
  > Mi_Instancia4.txt: esta instancia tiene más datos 15 utpee y 10 ciclos. Lo que caracteriza a esta instancia es que en cada cico la demanda es muy alta
    por lo tanto la todas las utpee se deben encender para cubrir esa demanda.    
  > Mi_Instancia5.txt: esta instancia tiene más datos 15 utpee y 15 ciclos. Lo que caracteriza a esta instancia es que la demanda total es posible cubrirse
    usando solo una utpee, se está teniendo en cuenta también la reserva. En este caso, la demanda será cubierta por la utpee que genere el menor costo, además
    de que cumpla con las demás restricciones. 
  
 
  
