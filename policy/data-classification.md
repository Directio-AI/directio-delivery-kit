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

Usamos IA en tres capas, y cada una tiene reglas distintas:

1. **Nuestra base.** Herramientas de Directio, en cuentas nuestras, para construir y operar el kit y nuestro trabajo interno. Sin datos de clientes.
2. **Construcción.** Durante el diagnóstico y la construcción manejamos datos reales del cliente. **Preferido:** trabajar dentro de las licencias del cliente desde el primer día (nos crean una cuenta o una llave de API). **Alternativa:** si procesamos en nuestro lado, solo con nuestras cuentas aprobadas abajo, nunca con cuentas personales o de consumo.
3. **Producción.** La solución corre con las licencias del cliente (su ChatGPT Enterprise, su Microsoft 365 o Google Workspace, sus llaves de API). Los datos quedan bajo el contrato del cliente con el proveedor; nosotros configuramos y operamos.

Revisada el 2026-10-27 contra los términos publicados por cada proveedor. Los términos cambian: se revisan antes de cada cliente nuevo y cada 6 meses. "Personal" significa siempre seudonimizado (regla 3); los datos **Sensibles** no entran en ninguna herramienta sin aprobación escrita del cliente.

### Capa 2: nuestras cuentas aprobadas para datos de clientes

| Herramienta | Clases permitidas | Por qué, y condiciones |
|---|---|---|
| **OpenAI**: ChatGPT Business o Enterprise, y la API | Pública, Confidencial de negocio, Personal (seudonimizado) | OpenAI declara que no entrena con datos de estos planes por defecto. La conservación se puede configurar (cero conservación en la API para cuentas que califican). |
| **Anthropic Claude**: Team o Enterprise, y la API (incluye Claude Code bajo términos comerciales) | Pública, Confidencial de negocio, Personal (seudonimizado) | Anthropic declara que no entrena con datos bajo términos comerciales. Conservación estándar de 30 días. |
| **Google Gemini**: Gemini en ediciones de Google Workspace que califican, y la API de Gemini en el nivel de pago | Pública, Confidencial de negocio, Personal (seudonimizado) | Google declara que no usa estos datos para entrenar ni mejorar productos. **El nivel gratuito de la API y Google AI Studio sin facturación sí los usan**: prohibidos para datos de clientes. |

### Capa 1: solo trabajo interno (sin datos de clientes)

Cualquier herramienta de la capa 2 sirve también aquí. Además, los planes de consumo que pagamos (por ejemplo Claude Max) sirven para trabajo interno con el entrenamiento de modelos desactivado en su configuración de privacidad.

| Herramienta | Clases permitidas | Por qué, y condiciones |
|---|---|---|
| **Cursor** | Pública; código de repositorios de clientes solo con Privacy Mode obligatorio para todo el equipo | Con Privacy Mode, Cursor declara que no entrena con el código y tiene acuerdos de cero conservación con sus proveedores de modelos. Sin Privacy Mode puede guardar y entrenar con el código. Nunca datos personales. |
| **Grok (xAI)** | Pública | La versión de consumo usa lo que escribes para entrenar. Existen planes empresariales y API, pero no verificamos sus términos de datos. Se reevalúa si un cliente lo pide. |
| **Agente Muse de Meta** | Pública | Lanzado en 2026; no encontramos términos publicados de tratamiento de datos para empresas, y los analistas señalan dudas de confianza. Se reevalúa cuando existan. |
| **Hermes Agent (Nous Research)** | La que permita el modelo al que se conecte | Es código abierto y corre en nuestro propio servidor; los datos van solo al proveedor de modelo que se configure. Candidato para clientes que no quieren que sus datos salgan de su infraestructura. |

### Capa 3: licencias del cliente

El cliente elige y paga el proveedor; nosotros no lo imponemos. Antes de conectar cualquier proceso, verificamos con su administrador:

- Que el plan sea empresarial o de API, no de consumo.
- Que el entrenamiento con sus datos esté desactivado y el periodo de conservación sea el que el cliente quiere.
- Que Directio tenga su propio usuario o llave, con el mínimo acceso necesario, y que se pueda revocar al terminar.
- Que el costo de uso quede a nombre del cliente, con un tope de gasto configurado.

Lo verificado se registra en el repositorio del cliente.

### Nunca, para datos de clientes

Cuentas gratuitas o personales de cualquier herramienta (ChatGPT, Claude, Gemini, Grok, Meta AI y similares), aunque la herramienta aparezca arriba en su versión empresarial.

## Para los agentes

Los agentes deben cumplir este archivo. Si un issue o un archivo implica datos de una clase superior a **Pública** en este repositorio, detente y etiqueta `needs-human`.
