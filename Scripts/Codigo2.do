import excel "C:\Users\prestamour\Downloads\doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A2:Q12) firstrow clear
describe
list

* ============================================================
* 5. Calcular promedio de las 16 ciudades (sin castigo)
* ============================================================
egen promedio_sin_castigo = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

list Period promedio_sin_castigo
describe
* ============================================================
* 6. Gráfico: contribución promedio sin castigo por período
* ============================================================
capture mkdir "../results"

twoway line promedio_sin_castigo Period, ///
    title("Contribución promedio por período (sin castigo)") ///
    subtitle("Promedio de 16 ciudades, Herrmann et al. 2008") ///
    xtitle("Período") ytitle("Contribución promedio") ///
    xlabel(1(1)10) lcolor(red) lwidth(medium)

graph export "../results/grafico_herrmann_sin_castigo.png", replace width(1000)