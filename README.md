# Taller 6: Experimentos — Consultoría para Acueductos Veredales

Repositorio del equipo consultor para el encargo de la ONG interesada en la construcción de acueductos veredales. El objetivo es analizar evidencia experimental sobre cooperación, free riding y mecanismos de sanción (Herrmann, Thöni & Gächter, 2008) y traducirla en recomendaciones para el diseño de reglas e incentivos del proyecto.

## Equipo consultor

| Integrante | Rol |
|---|---|
| _David Pascagaza Rodriguez_ | _Líder de proyecto_ |
| _Sara Rodriguez Moreno_ | _Analista cuantitativo_ |
| _Mariana Forigua Tamayo_ | _Especialista en visualización y comunicación_ |
| _Santiago Cortes Gomez_ | _Especialista en reproducibilidad y datos_ |

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

**David Pascagaza Rodriguez — Líder de proyecto**

David coordinó la organización general del taller, distribuyendo las preguntas de las Partes 2.1, 2.2 y 2.3 entre el equipo y verificando que cada entrega cumpliera con la estructura y los criterios pedidos por el profesor. Se encargó puntualmente del desarrollo de la Parte 2.3 (P2.3.1–P2.3.5), incluyendo la interpretación de las pruebas t de diferencia de medias en los Períodos 1 y 10, la discusión sobre las condiciones necesarias para sostener un vínculo causal entre el castigo y el cambio de comportamiento, y la redacción de las limitaciones del experimento junto con la evidencia adicional que el equipo consultor recomendó solicitar a la ONG antes de trasladar estos resultados al diseño del proyecto de acueducto veredal. Esto puede verificarse en `Informe/informe_taller6.docx`, sección Parte 2.3, y en los comandos correspondientes a las pruebas t dentro de `Script/taller6_bienes_publicos.do`.

**Sara Rodriguez Moreno — Analista cuantitativo**

Sara desarrolló los cálculos estadísticos que soportan las Partes 2.2 y 2.3 del taller: las contribuciones promedio por período para ambos experimentos, las desviaciones estándar de los Períodos 1 y 10, los valores máximo y mínimo, y la tabla resumen de estadísticas descriptivas (media, varianza, desviación estándar, mínimo, máximo y rango). También ejecutó las pruebas t de diferencia de medias en Stata que permiten evaluar si las diferencias observadas entre los experimentos con y sin castigo son estadísticamente significativas o atribuibles al azar. Su trabajo puede verificarse en las secciones de cálculo de `Scripts/` y en las tablas de estadísticas descriptivas presentadas en `Informe/informe_taller6.docx`, Parte 2.2.

**Mariana Forigua Tamayo — Especialista en visualización y comunicación**

Mariana construyó las visualizaciones que ilustran los hallazgos del taller: el gráfico de líneas de contribución promedio por período del juego jugado en clase (Parte 2.1), su comparación visual con la Figura 3 de Herrmann et al. (2008), el gráfico de líneas con ambos experimentos (con y sin castigo) claramente etiquetados en la leyenda, y el gráfico de columnas comparando el primer y último período de cada experimento (Parte 2.2). Además, se encargó de dar coherencia visual y narrativa al informe y a la presentación del briefing para la Sesión 3. Esto puede verificarse en las figuras generadas por `Script/taller6_bienes_publicos.do` y en `Informe/informe_taller6.docx`, Partes 2.1 y 2.2, así como en `Presentacion/taller6_briefing.pptx`.

**Santiago Cortes Gomez — Especialista en reproducibilidad y datos**

Santiago estructuró el do-file para que todo el análisis fuera reproducible de principio a fin, centralizando la carga y limpieza de los datos de las Figuras 2A y 3 de Herrmann et al. (2008), documentando cada paso del procesamiento y verificando que ningún resultado dependiera de edición manual de las bases. También validó que las tablas y figuras exportadas coincidieran con las citadas en el informe, y organizó la estructura de carpetas del repositorio (`Scripts/`, `Informe/informe_taller6.docx`, `Presentacion/`) siguiendo las convenciones vistas en clase. Esto puede verificarse en la sección de configuración inicial y en los comandos de carga de datos, así como en la organización general del repositorio.

## Referencias

- Herrmann, B., Thöni, C., & Gächter, S. (2008). Antisocial Punishment Across Societies. *Science*, 319(5868), 1362–1367.
- "What do laboratory experiments measuring social preferences reveal about the real world?" (pp. 158–171).
- *Economy, Society, and Public Policy*, Sección 2.6 (free riding y altruismo).
