# Escenario sintético

Cuando el cliente todavía no manda datos, no esperamos: armamos un escenario con datos inventados que imitan su proceso y probamos ahí el piloto. Así llegamos a la siguiente reunión con algo funcionando y con preguntas mucho más concretas.

## Reglas

1. **Todo inventado.** Ningún nombre, precio, número de documento ni persona real del cliente o de terceros. Empresas y personas ficticias, con nombres que se noten ficticios.
2. **Marcado.** Cada archivo lleva `SINTÉTICO` en el nombre de la carpeta y en la primera línea o columna. Nunca se mezcla con datos reales en la misma carpeta.
3. **Fiel a la forma, no a los números.** Copiamos la estructura que el cliente describió (qué campos, qué formatos, qué pasos), no sus cifras. Las cifras son de orden de magnitud razonable y nada más.
4. **Incluye el desorden.** Los casos fáciles no prueban nada. Cada escenario trae casos incompletos, duplicados, ambiguos o mal clasificados, en la proporción que el cliente mencionó o, si no la mencionó, cerca de uno de cada cuatro.
5. **Trae su clave de respuestas.** Para cada caso sabemos de antemano cuál es la respuesta correcta. Sin clave no se puede medir.
6. **Nunca se presenta como resultado del cliente.** Sirve para probar el método y mostrar cómo se vería. Los números del piloto salen solo de datos reales.

## Qué contiene la carpeta `escenario-SINTETICO/`

| Archivo | Qué es |
|---|---|
| `LEEME.md` | Qué proceso imita, qué supuestos tomamos y de dónde salió cada supuesto (reunión, cita, inferencia). |
| Datos de referencia | Lo que la persona consulta mientras trabaja: catálogo, historial, tarifas, condicionados. CSV o Markdown. |
| Casos de entrada | Lo que llega al proceso: solicitudes, facturas, correos. Uno por archivo o uno por fila. |
| `clave-respuestas.csv` | La respuesta correcta de cada caso y qué trampa tiene. |
| `prueba.md` | El protocolo: qué se le da a la IA, qué se le pide, cómo se califica y qué número sale. |

## Cómo se arma

1. Toma de la ficha el proceso elegido y escribe en `LEEME.md` los pasos tal como el cliente los contó.
2. Lista los campos que entran y los que salen. Si no los sabes, infiérelos y márcalos **[I]**: es una pregunta para la siguiente reunión.
3. Genera los datos de referencia con un script con semilla fija, para poder regenerarlos idénticos.
4. Escribe los casos a mano o con el script, mezclando fáciles, medianos y con trampa.
5. Escribe la clave antes de correr la prueba, no después.
6. Corre la prueba en una herramienta aprobada para la capa en la que estás (ver `policy/data-classification.md`). Con datos sintéticos basta la capa de base; con datos reales, la cuenta del cliente.

## Cómo se califica

- **Acierto:** casos donde el resultado coincide con la clave, sobre el total.
- **Trampas detectadas:** casos con trampa donde la IA la señaló o pidió el dato faltante, sobre el total de trampas. Este número importa más que el acierto: una IA que inventa lo que falta es peor que una que pregunta.
- **Tiempo:** minutos por caso con la IA y la revisión humana, contra la estimación de tiempo actual del cliente.
- **Errores graves:** cualquier resultado que habría llegado mal al cliente final. La meta es cero.

## Cuando llegan los datos reales

Se corre la misma `prueba.md` con 5 a 20 casos reales en la cuenta del cliente. Se compara con el resultado sintético: si el real es mucho peor, el escenario no reflejaba bien el proceso y eso también es un hallazgo.
