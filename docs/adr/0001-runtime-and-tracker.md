# ADR 0001: Entorno de ejecución, seguimiento de trabajo y controles

- Estado: aceptado
- Fecha: 2026-10-18 (actualizado 2026-10-20)

## Contexto

Directio quiere un sistema de entrega en el que pueda trabajar cualquier agente de programación, solo en la nube por ahora y con libertad para cambiar de modelo o herramienta en cualquier momento. Las reglas escritas solo en prompts dependen de que el agente las obedezca; las reglas que aplican git y CI se cumplen sin importar qué agente abrió el PR.

## Decisión

1. **Seguimiento de trabajo:** GitHub Issues, con la plantilla de unidad de trabajo y los estados por etiquetas de `AGENTS.md`.
2. **Instrucciones:** `AGENTS.md` es el archivo principal. Los archivos propios de cada herramienta (`CLAUDE.md` y otros) son punteros de una línea.
3. **Entorno de ejecución:** agentes de programación en la nube. Empezamos con Claude y probaremos otro agente con un issue real, para comprobar en la práctica que el sistema es portable.
4. **Controles en CI:** cada PR pasa por búsqueda de secretos (gitleaks), revisión de estructura y protección de los datos de prueba de referencia. Son los controles que la protección de ramas debe exigir.
5. **Revisión:** `CODEOWNERS` nombra a las personas que aprueban. Los agentes nunca aprueban. Excepción temporal (decidida por Jaime el 2026-10-20): hasta que se firme el primer cliente, Claude puede hacer merge de sus propios PRs cuando CI está en verde y no hay temas Clase C ni datos de clientes. La excepción termina cuando la organización pase a Team.
6. **Producción:** un environment de GitHub llamado `production` con revisores obligatorios. Los agentes se detienen antes de él.
7. **Idioma (2026-10-20):** español primero, inglés segundo; ver la regla 10 de `AGENTS.md`.

## Configuración del repositorio (la aplica un owner de la organización)

- Protección de rama o ruleset en `main`: exigir pull request, una aprobación de un code owner, los controles de `ci` en verde y sin force push.
- Desactivar merge commits; permitir solo squash merge; borrar ramas después del merge.
- Crear etiquetas: `ready`, `building`, `verifying`, `needs-human`, `blocked`, `killed`, `done`, `fixture-change-approved`.

**Limitación del plan:** en el plan Free de GitHub, la protección de ramas, los rulesets y los revisores obligatorios de environments no están disponibles para repositorios privados. Los controles corren igual, pero nada impide un merge cuando fallan. Revisar la página de planes de GitHub antes de decidir, porque esto cambia.

## Decisiones tomadas

1. **Plan de GitHub (2026-10-20):** seguir en Free hasta que se firme el primer cliente; pasar a Team antes de que cualquier trabajo de un cliente entre a un repositorio.

## Consecuencias

- Cambiar de agente significa cambiar un archivo puntero, no el sistema.
- Mientras se esté en Free, los controles son solo de aviso.
