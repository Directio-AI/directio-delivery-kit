# Clasificación y tratamiento de datos

_Versión original. Traducción al inglés: [data-classification.en.md](data-classification.en.md). Estado: borrador vigente internamente. Última actualización: 2026-10-20._

Guatemala no tiene, a la fecha de este documento, una ley integral de protección de datos personales vigente (verificar el estado de la iniciativa de ley antes de cada cliente nuevo). Aun así seguimos esta política: los clientes serios esperan estos controles aunque la ley no los exija, y la ley extranjera (GDPR, leyes estatales de EE. UU.) puede aplicar cuando los clientes o socios de nuestro cliente están en el exterior.

## Las cuatro clases

| Clase | Ejemplos | ¿Puede llegar a una herramienta de IA en la nube? | ¿Puede estar en un repositorio? |
|---|---|---|---|
| **Pública** | Listas de precios publicadas, catálogos, textos del sitio web | Sí | Sí |
| **Confidencial de negocio** | Costos, márgenes, condiciones con proveedores, volúmenes de producción, procesos internos, diseños no publicados | Solo después de firmar un acuerdo de confidencialidad y solo con herramientas de la lista aprobada | Solo en el repositorio privado de ese cliente |
| **Personal** | Nombres, DPI, NIT, teléfonos, correos, direcciones, placas, filas de planilla asociadas a una persona | Solo anonimizados o seudonimizados, después de un acuerdo firmado | Nunca en crudo; solo muestras anonimizadas |
| **Sensible** | Salud, cuentas bancarias o tarjetas, datos biométricos, salario de una persona identificada, disputas legales | No, salvo que el cliente apruebe por escrito la herramienta y el propósito concretos | Nunca |

Si hay duda, se clasifica un nivel más arriba.

## Reglas

1. **Clasificar al recibir.** Cada archivo que envía un cliente recibe una clase antes de abrirse en cualquier herramienta de IA. Se registra en el registro de datos del repositorio del cliente (`docs/data-register.md`): archivo, origen, clase, responsable, fecha de recepción y fecha de eliminación.
2. **Minimizar.** Pedir solo las columnas y los periodos que el proceso necesita. Eliminar lo demás antes de procesar.
3. **Anonimizar antes del modelo.** Los identificadores personales se reemplazan por seudónimos estables (por ejemplo `EMP-0042`) antes de que cualquier modelo vea los datos. La tabla de equivalencias queda con el cliente o en el almacenamiento cifrado del cliente, nunca en un prompt.
4. **Solo herramientas aprobadas.** Los datos de clientes solo entran en herramientas de la lista aprobada, en planes empresariales o de API cuyos términos excluyan entrenar con nuestros datos. Nunca se usan cuentas personales o de consumo para datos de clientes.
5. **El cliente es dueño de sus datos.** Solo los procesamos para el proyecto y los devolvemos o eliminamos al terminar.
6. **Conservación.** Por defecto, los archivos originales del cliente se eliminan 30 días después de terminar el proyecto; los entregables derivados (mapas de procesos, especificaciones) se conservan salvo que el cliente pida otra cosa. Los registros y trazas se conservan igual que los datos que contienen.
7. **Las trazas también son datos.** Los registros de prompts, trazas de agentes e historiales de chat que contienen datos de clientes se clasifican como esos datos.
8. **Accesos.** Mínimo privilegio. Un repositorio privado y un almacén de secretos por cliente. Sin contraseñas compartidas. Los accesos se retiran al terminar el proyecto.
9. **Incidentes.** Cualquier posible fuga (destinatario equivocado, datos pegados en una herramienta no aprobada, un equipo perdido) se reporta a los socios fundadores el mismo día y al cliente dentro de las 72 horas siguientes a confirmarla, con lo que pasó y lo que hicimos.

## Herramientas aprobadas

Lista corta a propósito. Agregar una herramienta es una decisión Clase C (requiere a un socio fundador).

| Herramienta | Clases permitidas | Notas |
|---|---|---|
| _(completar antes del primer cliente)_ | | Confirmar los términos vigentes: no entrena con los datos, periodo de conservación, región donde se procesan |

## Para los agentes

Los agentes deben cumplir este archivo. Si un issue o un archivo implica datos de una clase superior a **Pública** en este repositorio, detente y etiqueta `needs-human`.
