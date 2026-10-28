# Plantilla de espacio de cliente

Lo que usamos con cada cliente, desde la primera llamada hasta el piloto. Se copia por cliente con `scripts/new-client.sh`.

**Regla de oro:** los datos y documentos de un cliente nunca entran a este repositorio. La copia de cada cliente vive fuera del repo (en la carpeta compartida del proyecto o en el repo propio del cliente). Ver `policy/data-classification.md`.

## Qué trae

| Archivo | Para qué | Cuándo |
|---|---|---|
| `ficha-cliente.md` | Lo que sabemos, de dónde salió y qué falta. Mapa de procesos con puntaje de encaje con IA. | Antes y después de cada reunión |
| `solicitud-datos.md` | Lista de lo que pedimos al cliente, incluida una cuenta o llave de IA del lado del cliente. | Al cerrar la primera reunión |
| `escenario-sintetico.md` | Cómo armar datos de prueba ficticios para avanzar sin esperar al cliente. | Desde el día 1 |
| `propuesta-piloto.md` | Piloto con línea base, KPI, nivel de autonomía y lo que queda fuera. Incluye el registro de datos. | Al proponer |
| `adopcion.md` | Guion de la primera sesión, primeras victorias por rol y página "Empieza aquí". | Al arrancar el piloto |

## Cómo se usa

1. `scripts/new-client.sh <cliente>` crea la carpeta del cliente con la ficha, la solicitud, la propuesta y la adopción, más una carpeta `escenario-SINTETICO/` vacía. La guía del escenario se consulta aquí, no se copia.
2. Llena la ficha con lo que ya sabes y marca cada dato como **confirmado** (lo dijo el cliente o lo vimos), **inferido** (lo deducimos) o **pendiente**.
3. Arma el escenario sintético del proceso candidato y prueba el piloto con él mientras llegan los datos reales.
4. Cuando llegan los datos reales, se repite la misma prueba con ellos. El escenario sintético nunca se presenta como resultado del cliente.

Los entregables para clientes de Latinoamérica van solo en español.
