# Ficha de cliente: <cliente>

- Última actualización: <fecha>
- Responsable en Directio: <persona>
- Contacto principal del cliente: <nombre, puesto>
- Quién decide y quién firma el gasto: <nombre(s)>
- Etapa: prospecto | diagnóstico | piloto | programa
- Clase de datos más alta que vamos a tocar: Pública | Confidencial de negocio | Personal | Sensible

Cada dato lleva su marca: **[C]** confirmado (lo dijo el cliente o lo vimos), **[I]** inferido (lo deducimos), **[P]** pendiente.

## 1. El negocio en cinco líneas

Qué venden, a quién, tamaño (personas, países, facturación si la dieron), qué sistemas usan y qué IA usan hoy, oficialmente o por su cuenta.

## 2. Lo que pidieron, en sus palabras

Citas cortas, atribuidas a área o puesto, no a persona, si el documento va a circular.

## 3. Fuentes

| Fecha | Fuente | Quién estuvo | Qué aportó |
|---|---|---|---|
| | Reunión, transcripción, documento, sitio web | | |

## 4. Inventario de procesos y encaje con IA

Un renglón por proceso candidato. Puntaje de 1 a 3 en cada columna; el total ordena candidatos con información comparable. Si falta un dato, marque [P] y deje el total pendiente. El mapa detallado se completa en [diagnostico-champion.md](diagnostico-champion.md), dentro del [diagnóstico del área](diagnostico-area.md).

Antes de priorizar, confirme que existe una prueba permitida y revisable. Disponibilidad de datos no equivale a autorización. Un puntaje alto no sustituye los permisos ni la decisión sobre el riesgo.

| Proceso | Dolor (cuánto cuesta hoy) | Datos disponibles | Repetitivo y basado en documentos | Riesgo si la IA se equivoca (3 = bajo) | Medible en semanas | Total |
|---|---|---|---|---|---|---|
| | | | | | | |

Cómo puntuar:
- **Dolor:** 3 si el cliente lo nombró sin que preguntáramos y tiene un costo visible (horas, dinero, clientes perdidos).
- **Datos disponibles:** 3 si existen ejemplos históricos que nos pueden dar pronto; 1 si hay que generarlos.
- **Repetitivo y basado en documentos:** 3 si es leer, comparar, extraer o redactar sobre documentos parecidos.
- **Riesgo:** 3 solo con consecuencias acotadas y controles verificables para detectar errores antes de usar la salida; 1 si un error puede llegar al cliente o a una autoridad. La revisión humana por sí sola no acredita riesgo bajo; documente consecuencias y controles.
- **Medible:** 3 si hay una línea base que se puede tomar en una semana.

## 5. Proceso elegido para el primer piloto

Cuál, por qué (con el puntaje), y qué escenario sintético lo representa (`escenario-SINTETICO/`).

## 6. Restricciones del cliente

Herramientas permitidas y prohibidas, sistemas que no se tocan, reglas de supervisión humana, reglas de datos.

## 7. Preguntas abiertas

Lo que falta para pasar de inferido a confirmado. Cada pregunta con a quién se le hace.

## 8. Próximo paso

Una línea: qué, quién, cuándo.
