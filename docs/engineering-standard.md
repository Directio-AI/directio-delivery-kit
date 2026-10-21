# Estándar de ingeniería

_Versión en inglés: [engineering-standard.en.md](engineering-standard.en.md). Si difieren, prevalece este texto._

_Última actualización: 2026-10-21_

Cómo escribimos software en Directio, tanto con agentes de programación como sin ellos, y cómo construimos los sistemas con IA que entregamos a los clientes. Aplica a este repositorio y a cada repositorio de cliente creado desde el kit.

Está pensado para un equipo de dos personas que trabaja con agentes. Cada práctica tiene que ganarse su lugar: si cuesta más de lo que evita, no entra. La sección "Lo que no adoptamos todavía" es tan parte del estándar como el resto.

## 1. Principios

1. **Lo simple primero.** Un script antes que un servicio, un flujo fijo antes que un agente autónomo, un modelo antes que varios. Se sube de nivel solo cuando la medición muestra que lo simple no alcanza. (Ver "Building effective agents" de Anthropic.)
2. **Las reglas que importan viven en CI, no en prompts.** Un prompt es una petición; un control de CI se cumple con cualquier agente o persona. Si una regla se rompe dos veces, se vuelve control.
3. **Evidencia antes que opinión.** Nada está terminado hasta que una prueba, una evaluación o un comando lo demuestra, y el resultado está en el PR.
4. **Legible antes que ingenioso.** El código lo va a leer otro agente, otra persona o el equipo del cliente. Optimiza para quien lo lee después.
5. **El cliente debe poder mantenerlo.** Si solo Directio entiende lo que construimos, el cliente compró una dependencia, no una solución. Elegimos tecnología aburrida y documentada, y la entrega al equipo del cliente es un entregable.

## 2. Código limpio

Lo esencial, en cualquier lenguaje:

- **Nombres que dicen qué es y para qué.** `pedidos_vencidos`, no `data2`. Nombres del dominio del cliente cuando existan.
- **Funciones cortas con una sola responsabilidad.** Si necesitas "y" para describirla, probablemente son dos.
- **Sin abstracciones prematuras.** Duplicar dos veces está bien; a la tercera se extrae (regla de tres). Nada de interfaces o capas "por si acaso".
- **Errores explícitos.** Nunca un `except: pass` ni un `catch {}` vacío. Un error se maneja, se registra con contexto o se deja subir. Falla temprano con un mensaje claro.
- **Los comentarios explican el porqué, no el qué.** El qué lo dice el código. Sin código comentado ni código muerto: git ya guarda la historia.
- **Configuración fuera del código.** Rutas, URLs, umbrales y nombres de modelo van en configuración o variables de entorno; los secretos, solo en el gestor de secretos.
- **Tipos.** Python con type hints revisados por un verificador de tipos; TypeScript con `strict`.
- **Pocas dependencias, versiones fijadas.** Cada dependencia nueva se justifica en el PR. Archivo de bloqueo (lockfile) siempre en el repositorio.
- **Formato y lint automáticos, en CI.** Nadie discute estilo en una revisión. Por defecto: Python con `ruff` (formato y lint) y `mypy` o `pyright`; TypeScript con Biome, o Prettier más ESLint. Se agregan a CI en el primer PR que introduce código en ese lenguaje.

## 3. Pruebas

- **Lo determinista se prueba de forma determinista.** Parsers, reglas de negocio, transformaciones de datos y validaciones llevan pruebas unitarias normales, rápidas y sin red.
- **Una corrección empieza con la prueba que falla.** Y esa prueba no se edita durante la corrección (regla 1 de `AGENTS.md`).
- **Lo que depende de un modelo se mide con evaluaciones, no con pruebas unitarias** (sección 6).
- **Solo datos sintéticos o anonimizados** en pruebas y datos de referencia, según [policy/data-classification.md](../policy/data-classification.md).
- **Una prueba lenta o inestable se arregla o se borra**, con un issue. Nunca se salta en silencio para poner CI en verde.

## 4. Git y pull requests

- **Ramas cortas sobre `main`.** Una rama por issue, viva días, no semanas. `main` siempre está en un estado que funciona.
- **PRs pequeños.** Como guía, menos de unas 400 líneas cambiadas sin contar archivos generados. Un PR grande se divide en el issue, no en la revisión.
- **Commits en inglés, en modo imperativo y con el porqué.** "Add retry to ERP export because the API times out at night", no "fix". Merge siempre con squash.
- **El PR cuenta la historia.** Qué cambió, por qué, y la evidencia, siguiendo la plantilla. Quien revisa lee el diff, no solo el resumen del agente.
- **Archivos generados y secretos fuera del repositorio**, salvo los archivos de bloqueo.

## 5. Ingeniería con agentes de programación

Cómo trabajamos con Claude, Codex u otros agentes, sin importar cuál.

**Contexto**

- `AGENTS.md` es corto y estable: reglas y punteros. El detalle vive en documentos enlazados como este. Si `AGENTS.md` pasa de unas 200 líneas, se recorta.
- **Cada error repetido mejora el sistema.** Si un agente comete el mismo error dos veces, se agrega una línea a `AGENTS.md` o, mejor, un control en CI. Ese es el ciclo de aprendizaje del equipo.
- Los documentos fuente de verdad (`PLAN`, `QUEUE`, `BOARD`) se mantienen al día porque son el contexto del siguiente agente.

**Sesiones**

- **Una tarea por sesión, con contexto limpio.** Una sesión larga que mezcla temas produce trabajo peor. Al cambiar de tarea, sesión nueva.
- **Planificar antes de programar.** Para todo lo que no sea trivial, el agente propone un plan (la cadena de artefactos de `AGENTS.md`) y una persona lo aprueba antes del código.
- **Trabajo aislado.** Cada sesión trabaja en su propia rama (y su propio worktree si corren varias a la vez). Las reglas de limpieza de worktrees están en `AGENTS.md`.

**Verificación**

- **El agente corre las pruebas él mismo** y pega el resultado. "Debería funcionar" no es evidencia.
- **Revisión independiente.** Un segundo agente, con otro prompt y de preferencia otro modelo, revisa el PR buscando romperlo. Ese revisor nunca hace merge.
- **Lo que un agente nunca hace:** editar o saltar pruebas para que pasen, desactivar reglas de lint, agregar dependencias sin decirlo en el PR, tocar archivos fuera del alcance del issue.

**Registro**

- El PR es el registro de la sesión: enlaza la sesión del agente cuando la herramienta lo permite (por ejemplo la línea `Claude-Session` en los commits).
- Por ahora no registramos sesiones completas con herramientas externas. Si lo hacemos (por ejemplo Beacon), será en modo local, porque una sesión puede contener datos del cliente.

## 6. Sistemas con IA que entregamos a clientes

Aquí está la mayor parte del riesgo y del valor. Se aplica desde el primer piloto.

**Diseño**

- **Flujos antes que agentes.** La mayoría de los procesos de un cliente se resuelven con pasos fijos y un modelo en los puntos que lo necesitan. Un agente autónomo se justifica con una evaluación que muestre que el flujo fijo no alcanza.
- **Salidas estructuradas y validadas.** El modelo devuelve JSON con un esquema; el código valida antes de actuar. Una salida inválida es un error visible, no un valor por defecto.
- **Una persona aprueba lo que no se puede deshacer.** Pagos, pedidos a proveedores, mensajes a clientes del cliente y cambios en el sistema central (ERP) pasan por aprobación humana hasta que las evaluaciones y el cliente digan lo contrario, por escrito.
- **Independencia del proveedor.** Las llamadas al modelo pasan por un adaptador delgado propio. La versión del modelo está fijada en configuración. Cambiar de modelo significa correr las evaluaciones, no reescribir el sistema.
- **Los prompts son código.** Viven en el repositorio, cambian por PR y cada cambio corre las evaluaciones.

**Evaluaciones (evals)**

- **Primero se mira, luego se mide.** Antes de escribir evaluaciones, lee 30 a 50 ejecuciones reales y anota cómo falla el sistema. Cada tipo de falla se vuelve un criterio.
- **Conjunto de referencia con datos del cliente.** Unos 50 a 100 casos etiquetados por una persona que conoce el proceso, con datos reales anonimizados y en el idioma real (normalmente español). Viven en `ci/golden/` del repositorio del cliente y solo cambian con aprobación humana.
- **Aprobado o reprobado por cada tipo de falla**, no una calificación general de 1 a 10. Un juez (otro modelo) por criterio, y el juez también se valida contra las etiquetas humanas.
- **Los umbrales se acuerdan con el cliente.** Cuánta precisión y cuánta cobertura (recall) se necesitan es una decisión de negocio. Se fija antes de construir y es el criterio de "terminado" del piloto.
- **Las evaluaciones corren en CI** cada vez que cambia un prompt, un modelo o la lógica alrededor del modelo.
- **Se mide contra una línea base**: el proceso actual del cliente, medido y firmado antes de empezar.

**Observabilidad**

- **Cada llamada a un modelo deja un registro:** entrada y salida (con los datos personales enmascarados según su clase), modelo y versión, versión del prompt, latencia, tokens y costo, y el identificador de la ejecución del flujo.
- **Formato abierto.** Registros estructurados (JSON), compatibles con OpenTelemetry, para no depender de una plataforma.
- **Costo y latencia tienen presupuesto.** Cada flujo tiene un costo por ejecución esperado; superarlo genera una alerta.
- **Las fallas se ven.** Una fuente ilegible o una salida inválida genera un aviso, nunca un "sin novedades" (regla 2 de `AGENTS.md`).

**Entrega al cliente**

- Cada sistema entregado incluye un manual de operación: cómo correrlo, cómo saber si está fallando, cómo cambiar de modelo y a quién llamar.
- Tecnología que el equipo del cliente pueda operar. Si el cliente no tiene desarrolladores, eso cambia el diseño, no solo la documentación.

## 7. Lo que no adoptamos todavía

Cosas que suenan bien pero hoy cuestan más de lo que valen. Se revisan cuando se cumple la condición.

| No adoptamos | Por qué no | Se revisa cuando |
|---|---|---|
| Un entorno propio para correr agentes (como Laminar de Ramp) | Tiene sentido con millones de sesiones, no con un piloto | Operemos varios clientes con agentes en producción |
| Motores de flujos de larga duración (Temporal o similares) | Una cola simple y reintentos alcanzan | Un flujo dure horas o necesite reanudarse tras una falla |
| Marcos de orquestación de múltiples agentes | Agregan complejidad difícil de depurar y de entregar | Una evaluación muestre que un solo flujo no alcanza |
| Plataformas pagadas de evaluación u observabilidad | Archivos, scripts y registros JSON alcanzan al inicio | Tengamos más de un sistema en producción |
| Registro de sesiones de agentes en la nube de terceros | Las sesiones pueden contener datos de clientes | Haya un acuerdo y una revisión de seguridad |
| Microservicios, Kubernetes | Un solo servicio es más fácil de operar y de entregar | Un cliente lo exija o la carga lo justifique |
| Marcos de agentes en beta (por ejemplo eve de Vercel) para producción de clientes | Las API cambian y atan a un proveedor | Salgan de beta; se pueden usar para prototipos internos |

## 8. Cómo cambia este estándar

- Por PR, como cualquier otro cambio, actualizando ambas versiones de idioma.
- Lo que el Radar marque como adoptado entra aquí; lo que deje de servir sale.
- Revisión completa cada trimestre o al cerrar cada piloto, lo que pase primero.
