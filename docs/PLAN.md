# Plan

_Última actualización: 2026-11-17_

## Propósito

Construir un kit que le permita a Directio implementar IA en los procesos de sus clientes siempre de la misma forma: diagnóstico, mapa del proceso, especificación, construcción, verificación y operación. Cualquier agente de programación puede hacer la construcción porque las reglas viven en el repositorio y en CI.

## Fase actual: cimientos

Objetivo: que el repositorio pueda recibir trabajo de forma segura antes de empezar con cualquier cliente.

- [x] Repositorio creado (privado, organización `Directio-AI`)
- [x] Instrucciones para agentes, documentos fuente de verdad, plantillas de artefactos y de unidad de trabajo
- [x] Controles de CI: búsqueda de secretos, revisión de estructura, protección de datos de prueba
- [x] Políticas: clasificación de datos, uso de IA, plantilla de acuerdo de confidencialidad (borradores; el acuerdo espera revisión legal)
- [x] Convención de idioma: español primero, inglés segundo
- [x] Estándar de ingeniería: código limpio, trabajo con agentes, evaluaciones y observabilidad (`docs/engineering-standard.md`)
- [ ] Prompts de cada rol en `agents/`
- [x] Plantilla de espacio de cliente y script para crear clientes nuevos (PR #9)
- [x] Diagnóstico por área y champion conectado con capacitación y Companion Guide (#10, incorporado en PR #11)
- [ ] Diagramas as is/con IA y revisión humana como parte de cada diagnóstico (#12, en revisión)
- [ ] Configuración del repositorio aplicada (ver ADR 0001; parte depende del plan de GitHub)

## Siguiente fase: primer cliente

Usar el kit en el primer proceso de un cliente (candidato: el piloto con el grupo de muebles). Solo diagnóstico hasta que se firme un acuerdo de confidencialidad; ningún dato del cliente entra en una herramienta en la nube antes de eso.

## Fuera de alcance por ahora

- Modelos locales o en las instalaciones del cliente (se revisa cuando un cliente exija que sus datos no salgan de su edificio)
- Motores de flujos de larga duración (Temporal o similares)
- Cualquier cosa específica de Sin Demora, Ventara o de un solo cliente
