*==============================================================================
* 03_inferencia.do
* Responde P2.3.2 y P2.3.3  (pruebas t y valores p)
* Responsable: Analista cuantitativo  <-- nucleo del rol
*==============================================================================

use "$raw/herrmann_largo.dta", clear

*------------------------------------------------------------------ P2.3.2
* Diferencia de medias en el PERIODO 1 (con vs sin castigo)
* Hipotesis nula: la contribucion promedio es igual en ambos tratamientos
*---------------------------------------------------------------------------
display as text _n "==============================================="
display as text    "  P2.3.2  Prueba t - PERIODO 1"
display as text    "==============================================="

ttest contrib if periodo==1, by(castigo)

* Guardar los resultados clave
scalar t_p1    = r(t)
scalar p_p1    = r(p)
scalar dif_p1  = r(mu_2) - r(mu_1)
scalar gl_p1   = r(df_t)

* Prueba de igualdad de varianzas (justifica si conviene reportar Welch)
display as text _n "-- Igualdad de varianzas, periodo 1 --"
sdtest contrib if periodo==1, by(castigo)

* Version de Welch (no supone varianzas iguales)
display as text _n "-- Welch, periodo 1 --"
ttest contrib if periodo==1, by(castigo) unequal

*------------------------------------------------------------------ P2.3.3
* Diferencia de medias en el PERIODO 10 (con vs sin castigo)
*---------------------------------------------------------------------------
display as text _n "==============================================="
display as text    "  P2.3.3  Prueba t - PERIODO 10"
display as text    "==============================================="

ttest contrib if periodo==10, by(castigo)

scalar t_p10   = r(t)
scalar p_p10   = r(p)
scalar dif_p10 = r(mu_2) - r(mu_1)
scalar gl_p10  = r(df_t)

display as text _n "-- Igualdad de varianzas, periodo 10 --"
sdtest contrib if periodo==10, by(castigo)

display as text _n "-- Welch, periodo 10 --"
ttest contrib if periodo==10, by(castigo) unequal

*------------------------------------------------------------------ ROBUSTEZ
* Las mismas 16 ciudades aparecen en ambos tratamientos, asi que la version
* pareada es una alternativa defendible. Se reporta como chequeo de robustez:
* si la conclusion no cambia, el resultado no depende del supuesto de muestras
* independientes.
*---------------------------------------------------------------------------
display as text _n "=== ROBUSTEZ: prueba t pareada por ciudad ==="
preserve
    keep if inlist(periodo,1,10)
    keep ciudad castigo periodo contrib
    reshape wide contrib, i(ciudad periodo) j(castigo)
    rename (contrib0 contrib1) (sin_cast con_cast)

    display as text _n "-- Pareada, periodo 1 --"
    ttest con_cast == sin_cast if periodo==1

    display as text _n "-- Pareada, periodo 10 --"
    ttest con_cast == sin_cast if periodo==10
restore

*------------------------------------------------------------------ RESUMEN
display as text _n "==============================================="
display as text    "  RESUMEN DE INFERENCIA"
display as text    "==============================================="
display as text "Periodo 1 : diferencia = " %7.4f dif_p1  "  t = " %7.4f t_p1  ///
                "  gl = " %4.0f gl_p1  "  p = " %7.4f p_p1
display as text "Periodo 10: diferencia = " %7.4f dif_p10 "  t = " %7.4f t_p10 ///
                "  gl = " %4.0f gl_p10 "  p = " %7.4f p_p10

* Exportar el resumen
preserve
    clear
    set obs 2
    gen periodo    = cond(_n==1, 1, 10)
    gen diferencia = cond(_n==1, dif_p1, dif_p10)
    gen t          = cond(_n==1, t_p1,   t_p10)
    gen gl         = cond(_n==1, gl_p1,  gl_p10)
    gen pvalor     = cond(_n==1, p_p1,   p_p10)
    format diferencia t pvalor %9.6f
    list, noobs
    export delimited using "$tablas/T4_pruebas_t.csv", replace
restore
