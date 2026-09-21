# RawData — Taller 6: Experimentos

Datos crudos usados por el pipeline de `Scripts/`. Ningún archivo de esta carpeta se edita manualmente: toda la limpieza y transformación ocurre en `01_import_clean.do`, que lee estos tres archivos y produce las bases procesadas (`herrmann_largo.dta`, `clase_largo.dta`) que alimentan el resto del análisis.

## Archivos

### `doing-economics-datafile-working-in-excel-project-2.xlsx`

Base original de Herrmann, Thöni & Gächter (2008), hoja **"Public goods contributions"**. Contiene la contribución promedio por período de 16 ciudades, en dos bloques dentro de la misma hoja:

| Bloque | Rango | Contenido |
|---|---|---|
| Sin castigo | `A3:Q12` (encabezados en fila 2) | Figura 3 del paper — 10 períodos × 16 ciudades |
| Con castigo | `A17:Q26` (encabezados en fila 16) | Figura 2A del paper — 10 períodos × 16 ciudades |

Cada fila es un período (1–10); cada columna, una de las 16 ciudades del estudio (Copenhagen, Dnipropetrovsk, Minsk, St. Gallen, Muscat, Samara, Zurich, Boston, Bonn, Chengdu, Seoul, Riyadh, Nottingham, Athens, Istanbul, Melbourne). `01_import_clean.do` importa ambos bloques por separado, los reestructura a formato largo (una fila por ciudad-período-tratamiento) y los une en `herrmann_largo.dta` (320 observaciones = 16 ciudades × 10 períodos × 2 tratamientos).

### `Datos_Juego_1.xlsx`

Resultados del juego de bienes públicos jugado en clase, hoja **"Game History"**. Incluye, entre otras, las columnas `Game`, `Round` y `Contribution` por jugador y ronda. Corresponde a la fuente original usada en `Codigo1.do` (script exploratorio) para la primera aproximación a la Parte 2.1.

### `game1_clase.csv`

Versión limpia y exportada del Game 1 jugado en clase (economics-games.com), fuente: *Game_History_clase_Paul_20262.pdf*, tabla "Game 1" — 22 jugadores × 10 rondas (220 filas). Columnas:

| Columna | Descripción |
|---|---|
| `ronda` | Ronda del juego (1–10) |
| `jugador` | Identificador del jugador (1–22) |
| `contribucion` | Contribución individual al bien público en esa ronda |
| `pago` | Dinero conservado en la cuenta privada (dotación − contribución) |

Este es el archivo que usa `01_import_clean.do` para construir `clase_largo.dta`. El script valida que `contribucion + pago` (la dotación) sea constante dentro de cada ronda — chequeo que confirma que `pago` es el remanente en la cuenta privada, y no la ganancia total incluyendo el retorno del bien público.

## Notas

- Las rutas de importación en los scripts (`import excel using "$raw/..."`, `import delimited using "$raw/..."`) asumen que `$raw` apunta a esta carpeta (`RawData/`). Ver `Scripts/README.md` para la definición de los globals.
- Ninguno de estos tres archivos debe modificarse directamente: cualquier corrección a los datos debe hacerse en el script de importación (`01_import_clean.do`), para mantener el análisis reproducible de principio a fin.
