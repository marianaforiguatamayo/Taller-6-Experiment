# Scripts — Taller 6: Experimentos

Do-files de Stata con el análisis del taller. La carpeta contiene dos conjuntos de scripts: el **pipeline final** (`01_import_clean.do` → `02_descriptivas.do` → `03_inferencia.do`), que es el que sustenta las cifras y tablas citadas en el informe, y los **scripts exploratorios** (`Codigo1.do`, `Codigo2.do`, `Codigo.3.do`) del desarrollo inicial del taller, que se conservan como evidencia del proceso de trabajo pero no son la fuente de los resultados finales.

## Requisitos

- Stata (cualquier versión con soporte para `egen`, `reshape`, `table`, `statsby`, `ttest`, `sdtest`).
- Antes de correr el pipeline final, definir los globals de ruta al inicio de la sesión (o en un do-file maestro):
  ```stata
  global raw    "RawData"     // datos crudos: xlsx, csv, y las .dta generadas por 01_import_clean.do
  global tablas "Outputs"     // carpeta donde se exportan los .csv de resultados
  ```
- Los scripts exploratorios (`Codigo1.do`, `Codigo2.do`, `Codigo.3.do`) usan rutas relativas (`../results/`) y rutas absolutas de una máquina local (`C:\Users\prestamour\Downloads\...`) que deben ajustarse manualmente si se vuelven a ejecutar.

## Pipeline final

### `01_import_clean.do` — Importación y limpieza (insumo para todo lo demás)

Importa los dos bloques de la base de Herrmann et al. (2008) desde `doing-economics-datafile-working-in-excel-project-2.xlsx` (hoja *Public goods contributions*): el bloque sin castigo (`A3:Q12`, Figura 3) y el bloque con castigo (`A17:Q26`, Figura 2A). Renombra columnas, etiqueta el tratamiento (`castigo`: 0 = sin castigo, 1 = con castigo) y las 16 ciudades, reestructura la base de ancho a largo (`reshape long`) y corre chequeos de integridad (`assert`) para confirmar 320 observaciones (16 ciudades × 10 períodos × 2 tratamientos). Guarda `herrmann_largo.dta`.

También importa los datos recogidos en clase (Game 1, 22 jugadores, `game1_clase.csv`), valida que la dotación (`contrib + pago`) sea constante dentro de cada ronda —lo que confirma que `pago` es el remanente en la cuenta privada y no la ganancia total— y guarda `clase_largo.dta` (220 observaciones: 22 jugadores × 10 rondas).

**Outputs:** `$raw/herrmann_largo.dta`, `$raw/clase_largo.dta`

### `02_descriptivas.do` — Estadísticas descriptivas (Parte 2.2 y datos de clase)

A partir de `herrmann_largo.dta`, responde:

- **P2.2.1** — contribución promedio por período y tratamiento (`table`), y una versión reestructurada con la diferencia con/sin castigo, exportada a `T1_medias_por_periodo.csv`.
- **P2.2.3–P2.2.5** — tabla de estadísticas descriptivas completas (media, varianza, desviación estándar, mínimo, máximo, rango) para los Períodos 1 y 10 en ambos tratamientos (`tabstat` + `statsby`), exportada a `T2_descriptivas_P1_P10.csv`.
- **P2.2.3** — verificación de la regla práctica (media ± 2 desviaciones estándar), reportando cuántas observaciones caen dentro del intervalo por combinación de castigo y período.
- **P2.2.4** — identifica qué ciudad marca el valor mínimo y el máximo en cada combinación de castigo y período.

A partir de `clase_largo.dta`, calcula la contribución promedio por ronda del Game 1 jugado en clase (insumo para **P2.1.1**), junto con la tasa de contribución relativa a la dotación, exportada a `T3_clase_por_ronda.csv`.

**Outputs:** `$tablas/T1_medias_por_periodo.csv`, `$tablas/T2_descriptivas_P1_P10.csv`, `$tablas/T3_clase_por_ronda.csv`

### `03_inferencia.do` — Pruebas de hipótesis (Parte 2.3)

A partir de `herrmann_largo.dta`, responde:

- **P2.3.2** — prueba t de diferencia de medias entre con y sin castigo en el **Período 1**, con su prueba de igualdad de varianzas (`sdtest`) y la versión de Welch (`ttest ... unequal`) como respaldo cuando las varianzas no son iguales.
- **P2.3.3** — la misma prueba t para el **Período 10**.
- **Chequeo de robustez** — dado que las mismas 16 ciudades aparecen en ambos tratamientos, corre además una prueba t pareada por ciudad (períodos 1 y 10) para verificar que la conclusión no dependa del supuesto de muestras independientes.
- **Resumen** — consolida diferencia de medias, estadístico t, grados de libertad y valor p de ambos períodos, y los exporta a `T4_pruebas_t.csv`.

**Output:** `$tablas/T4_pruebas_t.csv`

## Orden de ejecución del pipeline

1. `01_import_clean.do`
2. `02_descriptivas.do`
3. `03_inferencia.do`

## Scripts exploratorios (desarrollo inicial)

### `Codigo1.do`

Primera aproximación a los datos propios del Juego 1 (`Datos_Juego_1.xlsx`, hoja *Game History*): filtra el juego, verifica 220 observaciones y genera un primer gráfico de contribución promedio por período (versión preliminar de la **P2.1.1**), junto con estadísticas descriptivas exploratorias de los Períodos 1 y 10.

### `Codigo2.do`

Primera aproximación a los datos sin castigo de Herrmann et al. (2008), calculando el promedio de las 16 ciudades y graficando la serie de referencia (versión preliminar de la **P2.1.2–P2.1.4**).

### `Codigo.3.do`

Primera aproximación a la comparación con y sin castigo: une ambas series por período, genera el gráfico de líneas comparativo y el gráfico de columnas del primer y último período (versión preliminar de **P2.2.1** y **P2.2.2**), y calcula desviaciones estándar, máximos, mínimos y la tabla descriptiva completa por fuera del flujo reestructurado que luego se formalizó en `02_descriptivas.do`.

> Estos tres scripts se mantienen en el repositorio como registro del proceso de trabajo del equipo, pero las cifras y gráficos citados en `Informe/informe_taller6.docx` y en `Presentacion/` deben verificarse contra el pipeline final (`01`–`03`), que es la versión reproducible y con chequeos de integridad.

## Verificación de resultados

Todas las tablas exportadas a `$tablas/` (`T1`–`T4`) corresponden uno a uno con las cifras citadas en `../Informe/informe_taller6.docx`, Partes 2.1 a 2.3.
