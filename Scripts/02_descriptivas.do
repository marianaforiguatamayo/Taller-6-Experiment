*==============================================================================
* 02_descriptivas.do
* Responde P2.2.1, P2.2.3, P2.2.4 y P2.2.5
* Responsable: Analista cuantitativo
*==============================================================================

use "$raw/herrmann_largo.dta", clear

*------------------------------------------------------------------ P2.2.1
* Contribucion promedio en cada periodo, por separado para cada experimento
*---------------------------------------------------------------------------
display as text _n "=== P2.2.1: contribucion promedio por periodo y tratamiento ==="
table (periodo) (castigo), statistic(mean contrib) nformat(%9.4f)

* Version guardable para el grafico y para la tabla de salida
preserve
    collapse (mean) media = contrib, by(periodo castigo)
    reshape wide media, i(periodo) j(castigo)
    rename (media0 media1) (sin_castigo con_castigo)
    gen diferencia = con_castigo - sin_castigo
    format sin_castigo con_castigo diferencia %9.4f
    list, noobs sepby(periodo) abbrev(12)
    export delimited using "$tablas/T1_medias_por_periodo.csv", replace
restore

*------------------------------------------------------------------ P2.2.3 a P2.2.5
* Tabla descriptiva completa para los periodos 1 y 10
*---------------------------------------------------------------------------
display as text _n "=== P2.2.3 / P2.2.4 / P2.2.5: tabla de estadisticas descriptivas ==="

preserve
    keep if inlist(periodo,1,10)
    egen grupo = group(castigo periodo), label

    tabstat contrib, by(grupo) ///
        stats(mean variance sd min max range n) nototal format(%9.4f) ///
        columns(statistics)

    * Mismo contenido exportado a CSV para el informe
    statsby mean=r(mean) var=r(Var) sd=r(sd) min=r(min) max=r(max) n=r(N), ///
        by(castigo periodo) clear: summarize contrib, detail
    gen rango = max - min
    order castigo periodo mean var sd min max rango n
    format mean var sd min max rango %9.4f
    list, noobs abbrev(10)
    export delimited using "$tablas/T2_descriptivas_P1_P10.csv", replace
restore

*------------------------------------------------------------------ P2.2.3
* Regla practica: cuantas observaciones caen dentro de media +/- 2 sd
*---------------------------------------------------------------------------
display as text _n "=== P2.2.3: verificacion de la regla practica (media +/- 2 sd) ==="

foreach c of numlist 0 1 {
    foreach p of numlist 1 10 {
        quietly summarize contrib if castigo==`c' & periodo==`p'
        local m  = r(mean)
        local s  = r(sd)
        local lo = `m' - 2*`s'
        local hi = `m' + 2*`s'
        quietly count if castigo==`c' & periodo==`p' & inrange(contrib,`lo',`hi')
        local dentro = r(N)
        quietly count if castigo==`c' & periodo==`p'
        local total = r(N)
        display as text "castigo=`c' periodo=`p': media=" %6.4f `m' ///
            "  sd=" %6.4f `s' "  intervalo=[" %6.4f `lo' ", " %6.4f `hi' "]" ///
            "  dentro=`dentro'/`total'"
    }
}

*------------------------------------------------------------------ P2.2.4
* Que ciudad marca el minimo y el maximo en cada caso
*---------------------------------------------------------------------------
display as text _n "=== P2.2.4: ciudades con el minimo y el maximo ==="
foreach c of numlist 0 1 {
    foreach p of numlist 1 10 {
        preserve
            keep if castigo==`c' & periodo==`p'
            sort contrib
            display as text "castigo=`c' periodo=`p':"
            list ciudad contrib in 1,  noobs abbrev(12)
            list ciudad contrib in -1, noobs abbrev(12)
        restore
    }
}

*==============================================================================
* DATOS DE CLASE (Game 1, 22 jugadores) - insumo para P2.1.1
*==============================================================================
use "$raw/clase_largo.dta", clear

display as text _n "=== Datos de clase (Game 1): contribucion promedio por ronda ==="
tabstat contrib, by(ronda) stats(mean sd min max n) format(%9.3f)

display as text _n "=== Dotacion por ronda (contextualiza la escala) ==="
tabstat dotacion, by(ronda) stats(mean) format(%9.0f)

preserve
    collapse (mean) media_contrib = contrib (sd) sd_contrib = contrib ///
             (first) dotacion = dotacion, by(ronda)
    gen tasa_contrib = media_contrib / dotacion
    format media_contrib sd_contrib tasa_contrib %9.3f
    list, noobs
    export delimited using "$tablas/T3_clase_por_ronda.csv", replace
restore
    format media_contrib sd_contrib %9.3f
    list, noobs
    export delimited using "$tablas/T3_clase_por_ronda.csv", replace
restore
