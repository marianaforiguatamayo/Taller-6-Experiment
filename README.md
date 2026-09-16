# Taller 6: Experimentos — Consultoría para Acueductos Veredales

Repositorio del equipo consultor para el encargo de la ONG interesada en la construcción de acueductos veredales. El objetivo es analizar evidencia experimental sobre cooperación, free riding y mecanismos de sanción (Herrmann, Thöni & Gächter, 2008) y traducirla en recomendaciones para el diseño de reglas e incentivos del proyecto.

## Equipo consultor

| Integrante | Rol |
|---|---|
| _David Pascagaza Rodriguez_ | _Rol (ej. líder de proyecto)_ |
| _Sara Rodriguez Moreno_ | _Rol (ej. analista cuantitativo — Stata)_ |
| _Mariana Forigua Tamayo_ | _Rol (ej. especialista en visualización y comunicación)_ |
| _Santiago Cortes Gomez_ | _Rol (ej. especialista en reproducibilidad y datos)_ |

> Los roles definen una responsabilidad principal, no dividen el taller en cuatro partes. Todos los productos son responsabilidad conjunta y cualquier integrante puede ser seleccionado como portavoz en la Sesión 3.

## Descripción del encargo

La ONG quiere entender cómo las reglas e incentivos afectan la cooperación comunitaria cuando un proyecto requiere contribuciones individuales para lograr un beneficio colectivo (un acueducto veredal). Puntualmente, busca respuesta a tres preguntas:

1. ¿Qué enseñan los datos experimentales sobre la introducción de mecanismos de sanción frente al free riding?
2. ¿Qué tan sólida es la evidencia causal detrás de esos resultados?
3. ¿Cuáles son los límites para trasladar esos resultados a la organización de un proyecto de acueducto veredal?

El análisis se basa en el juego de bienes públicos con y sin castigo de Herrmann, Thöni & Gächter (2008), *Antisocial Punishment Across Societies*, *Science* 319, 1362–1367, complementado con datos propios recolectados en clase jugando el mismo juego.

## Estructura del repositorio

```
TALLER_6_ACUEDUCTOS_VEREDALES/
├── Script/
│   └── taller6_bienes_publicos.do      # Do-file(s) con todo el análisis (Stata)
├── Informe/
│   └── informe_taller6.docx            # Entrega escrita — respuestas a P2.1–P2.3
├── Presentacion/
│   └── taller6_briefing.pptx           # Material de apoyo para el briefing (Sesión 3)
└── README.md
```

## Reproducibilidad

- Todo el análisis se ejecuta desde **Stata** mediante do-files ubicados en `Script/`.
- Ningún resultado depende de edición manual de las bases ni de comandos ejecutados fuera de un do-file.
- Para reproducir el análisis completo: abrir `Script/taller6_bienes_publicos.do` en Stata y ejecutarlo de principio a fin (revisar y ajustar la ruta del proyecto en la sección de configuración al inicio del script).
- Las tablas y figuras generadas se guardan referenciadas explícitamente en el do-file, para poder ubicarlas y verificarlas desde el `Informe/`.

## Contenido del análisis

**Parte 2.1 — Recolectando datos jugando:** contribución promedio por período del juego jugado en clase, comparación con la Figura 3 de Herrmann et al. (2008).

**Parte 2.2 — Describiendo datos:** contribución promedio por período en ambos experimentos (con/sin castigo), gráfico de columnas del primer y último período, desviación estándar, regla práctica, estadísticas descriptivas (media, varianza, desviación estándar, mínimo, máximo, rango).

**Parte 2.3 — ¿Cómo afectó el cambio de reglas al comportamiento?:** experimento de lanzamiento de moneda como referencia de variación aleatoria, pruebas t de diferencia de medias (Períodos 1 y 10), condiciones para inferencia causal, limitaciones de la evidencia experimental y evidencia adicional recomendada a la ONG antes de trasladar los resultados al diseño del proyecto de acueducto veredal.

## Contribuciones individuales

> Cada integrante debe registrar entre 2 y 4 contribuciones concretas vinculadas a su rol, señalando el do-file, tabla, figura o sección donde se pueden verificar.

**_Nombre 1 — Rol_**
- Contribución 1 → ver `Script/taller6_bienes_publicos.do`, línea(s) __
- Contribución 2 → ver `Informe/informe_taller6.docx`, sección __

**_Nombre 2 — Rol_**
- Contribución 1 → ver ...
- Contribución 2 → ver ...

**_Nombre 3 — Rol_**
- Contribución 1 → ver ...
- Contribución 2 → ver ...

**_Nombre 4 — Rol_**
- Contribución 1 → ver ...
- Contribución 2 → ver ...

## Referencias

- Herrmann, B., Thöni, C., & Gächter, S. (2008). Antisocial Punishment Across Societies. *Science*, 319(5868), 1362–1367.
- "What do laboratory experiments measuring social preferences reveal about the real world?" (pp. 158–171).
- *Economy, Society, and Public Policy*, Sección 2.6 (free riding y altruismo).
