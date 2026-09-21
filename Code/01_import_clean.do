*==============================================================================
* 01_import_clean.do
* Importa los dos bloques del archivo de Herrmann et al. (2008) y los datos
* recogidos en clase. Deja dos bases limpias en formato largo.
*
* Estructura del archivo de Excel "doing-economics-datafile...":
*   Hoja "Public goods contributions"
*   Fila 2  : encabezados (Period + 16 ciudades)  | Filas 3-12 : SIN castigo (Fig 3)
*   Fila 16 : encabezados                          | Filas 17-26: CON castigo (Fig 2A)
*==============================================================================

*------------------------------------------------------------------ BLOQUE 1
* SIN castigo (Figura 3 de Herrmann et al. 2008)
*---------------------------------------------------------------------------
import excel using "$raw/doing-economics-datafile-working-in-excel-project-2.xlsx", ///
    sheet("Public goods contributions") cellrange(A3:Q12) clear

rename A periodo
local i = 1
foreach v of varlist B-Q {
    rename `v' contrib`i'
    local ++i
}
gen byte castigo = 0
tempfile sincastigo
save `sincastigo'

*------------------------------------------------------------------ BLOQUE 2
* CON castigo (Figura 2A de Herrmann et al. 2008)
*---------------------------------------------------------------------------
import excel using "$raw/doing-economics-datafile-working-in-excel-project-2.xlsx", ///
    sheet("Public goods contributions") cellrange(A17:Q26) clear

rename A periodo
local i = 1
foreach v of varlist B-Q {
    rename `v' contrib`i'
    local ++i
}
gen byte castigo = 1

append using `sincastigo'

*--- De ancho a largo: una fila por ciudad-periodo-tratamiento --------------
reshape long contrib, i(periodo castigo) j(ciudad)

*--- Etiquetas -------------------------------------------------------------
label define lciudad ///
     1 "Copenhagen"      2 "Dnipropetrovsk"  3 "Minsk"      4 "St. Gallen"   ///
     5 "Muscat"          6 "Samara"          7 "Zurich"     8 "Boston"       ///
     9 "Bonn"           10 "Chengdu"        11 "Seoul"     12 "Riyadh"       ///
    13 "Nottingham"     14 "Athens"         15 "Istanbul"  16 "Melbourne"
label values ciudad lciudad

label define lcastigo 0 "Sin castigo" 1 "Con castigo"
label values castigo lcastigo

label var periodo  "Periodo del juego (1-10)"
label var ciudad   "Ciudad donde se corrio el experimento"
label var castigo  "Tratamiento: 0 = sin castigo, 1 = con castigo"
label var contrib  "Contribucion promedio al bien publico"

order ciudad castigo periodo contrib
sort  castigo ciudad periodo

*--- Chequeos de integridad (deben pasar los tres) -------------------------
assert !missing(contrib)
assert inrange(periodo,1,10)
count
assert r(N) == 320          // 16 ciudades x 10 periodos x 2 tratamientos

save "$raw/herrmann_largo.dta", replace
display as result "OK: base herrmann_largo.dta creada (320 obs)"

*==============================================================================
* DATOS RECOGIDOS EN CLASE (Game 1, economics-games.com, 22 jugadores)
* Fuente: Game_History_clase_Paul_20262.pdf, tabla "Game 1"
*==============================================================================
import delimited using "$raw/game1_clase.csv", clear varnames(1)

rename (contribucion pago) (contrib pago)

label var ronda   "Ronda del juego (1-10)"
label var jugador "Identificador del jugador (1-22)"
label var contrib "Contribucion individual al bien publico"
label var pago    "Dinero conservado en la cuenta privada (dotacion - contrib)"

*--- Chequeo de integridad: la dotacion (contrib + pago) debe ser constante
*    dentro de cada ronda. Esto confirma que "pago" es dinero conservado,
*    NO la ganancia total con el retorno del bien publico (a diferencia de
*    lo que se asumia con la base de prueba usada inicialmente).
gen dotacion = contrib + pago
bysort ronda: egen dot_min = min(dotacion)
bysort ronda: egen dot_max = max(dotacion)
assert dot_min == dot_max
drop dot_min dot_max
label var dotacion "Dotacion individual en esa ronda (constante dentro de la ronda)"

count
assert r(N) == 220          // 22 jugadores x 10 rondas
assert !missing(contrib)

save "$raw/clase_largo.dta", replace
display as result "OK: base clase_largo.dta creada (Game 1, 22 jugadores x 10 rondas)"
