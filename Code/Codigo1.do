import excel "C:\Users\prestamour\Downloads\Datos_Juego_1.xlsx", sheet("Game History") firstrow clear
describe
summarize

keep if Game == 1

count
* Debería mostrar 220 observaciones (22 jugadores x 10 rondas)

* ============================================================
* 2. Contribución promedio por período (Pregunta 2.1.1)
* ============================================================
capture mkdir "../results"

preserve
collapse (mean) Contribution, by(Round)

twoway line Contribution Round, ///
    title("Contribución promedio por período - Juego 1") ///
    xtitle("Período") ytitle("Contribución promedio (€)") ///
    xlabel(1(1)10) lcolor(navy) lwidth(medium)

graph export "../results/grafico_contribucion_juego1.png", replace width(1000)
restore

* ============================================================
* 3. Estadísticas descriptivas por período (para Parte 2.2 más adelante)
* ============================================================
summarize Contribution if Round == 1
summarize Contribution if Round == 10

tabstat Contribution, by(Round) statistics(mean sd min max) columns(statistics)
