# Plantilla de espacio de cliente

Lo que usamos con cada cliente, desde la primera llamada hasta el piloto. Se copia por cliente con `scripts/new-client.sh`.

**Regla de oro:** los datos y documentos de un cliente nunca entran a este repositorio. La copia de cada cliente vive fuera del repo (en la carpeta compartida del proyecto o en el repo propio del cliente). Ver `policy/data-classification.md`.

## Qué trae

| Archivo | Para qué | Cuándo |
|---|---|---|
| `ficha-cliente.md` | Lo que sabemos, de dónde salió y qué falta. Mapa de procesos con puntaje de encaje con IA. | Antes y después de cada reunión |
| `diagnostico-area.md` | Objetivos, procesos candidatos, restricciones y dependencias; se reutiliza al incorporar champions. | Al incorporar o actualizar un área |
| `diagnostico-champion.md` | Mapa detallado, punto de partida con IA y condiciones para la primera práctica. | Antes de capacitar a cada champion |
| `mapa-proceso.md` | Diagrama comparativo as is/con IA, revisión humana, excepciones y marcas [C]/[I]/[P]. Fuente editable y criterios de exportación. | Parte de cada diagnóstico |
| `solicitud-datos.md` | Lista de lo que pedimos al cliente, incluida una cuenta o llave de IA del lado del cliente. | Al cerrar la primera reunión |
| `escenario-sintetico.md` | Cómo armar datos de prueba ficticios para avanzar sin esperar al cliente. | Desde el día 1 |
| `propuesta-piloto.md` | Piloto con línea base, KPI, nivel de autonomía y lo que queda fuera. Incluye el registro de datos. | Al proponer |
| `adopcion.md` | Guion de la primera sesión, primeras victorias por rol y página "Empieza aquí". | Al arrancar el piloto |
| `capacitacion-champions.md` | Seis sesiones con el proceso propio y seguimiento mediante el AI Companion Guide. | Después del diagnóstico y la preparación del piloto |

## Cómo se usa

1. `scripts/new-client.sh <cliente> [destino]` copia las plantillas en español y crea `escenario-SINTETICO/` fuera de este repositorio. La guía del escenario se consulta aquí, no se copia. Para varias áreas o champions, duplica sus fichas dentro del espacio autorizado del cliente y conserva referencias y versiones.
2. Llena la ficha de cliente y el diagnóstico del área. Marca cada dato **[C] confirmado**, **[I] inferido** o **[P] pendiente**, con fuente y fecha; asigna responsables a los pendientes.
3. Completa los mapas visuales del área y del champion con `mapa-proceso.md`: proceso actual, intervención de IA y revisión humana. Inserta las figuras al inicio de cada ficha, con fuente editable, exportación legible y trazabilidad [C]/[I]/[P]. Para varios procesos, duplica el mapa con nombres únicos y actualiza sus referencias. Si el área ya está diagnosticada, verifica y reutiliza su versión vigente.
4. Prepara la propuesta de piloto, el escenario sintético con clave de respuestas y la primera plantilla. Verifica las condiciones de inicio del diagnóstico individual.
5. Inicia la capacitación y el Companion Guide con esa tarea. La sesión 3 valida y completa el mapa inicial; no sustituye el diagnóstico previo.
6. Con autorización compatible para datos reales, repite la prueba en el entorno aprobado y mide contra una línea base comparable. El escenario sintético nunca se presenta como resultado del cliente.

Los entregables para clientes de Latinoamérica van solo en español.
