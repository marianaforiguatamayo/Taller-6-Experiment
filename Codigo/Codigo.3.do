import excel "C:\Users\prestamour\Downloads\doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A16:Q26) firstrow clear
describe
* Ajusta los nombres de columna según lo que confirmes aquí

egen promedio_con_castigo = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

keep Period promedio_con_castigo
save concastigo.dta,replace
* ============================================================
* Importar base de datos
* ============================================================
import excel "C:\Users\prestamour\Downloads\doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A2:Q12) firstrow clear
egen promedio_sin_castigo = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
* ============================================================
* Unir sin castigo y con castigo en una sola base
* ============================================================
merge 1:1 Period using "concastigo.dta"

drop _merge
* ============================================================
* Gráfico de líneas: con castigo vs sin castigo
* ============================================================
twoway (line promedio_sin_castigo Period, lcolor(red) lwidth(medium)) ///
       (line promedio_con_castigo Period, lcolor(navy) lwidth(medium)), ///
    title("Contribución promedio por período: con y sin castigo") ///
    xtitle("Período") ytitle("Contribución promedio") ///
    xlabel(1(1)10) ///
    legend(order(1 "Sin castigo" 2 "Con castigo") position(6) rows(1))

graph export "../results/grafico_herrmann_comparacion.png", replace width(1000)
* ============================================================
* 11. Gráfico de columnas: período 1 vs período 10
* ============================================================
preserve
keep if Period == 1 | Period == 10

graph bar promedio_sin_castigo promedio_con_castigo, over(Period) ///
    title("Contribución promedio: Período 1 vs Período 10") ///
    ytitle("Contribución promedio") ///
    legend(order(1 "Sin castigo" 2 "Con castigo") position(6) rows(1)) ///
    bar(1, color(red)) bar(2, color(navy))

graph export "../results/grafico_columnas_periodo1_10.png", replace width(1000)
restore

import excel "C:\Users\prestamour\Downloads\doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A16:Q26) firstrow clear
describe
egen sd_con_castigo = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

list Period sd_con_castigo if Period == 1 | Period == 10

import excel "C:\Users\prestamour\Downloads\doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A2:Q12) firstrow clear
egen sd_sin_castigo = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

list Period sd_sin_castigo if Period == 1 | Period == 10

egen max_con_castigo = rowmax(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
egen min_con_castigo = rowmin(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

list Period max_con_castigo min_con_castigo if Period == 1 | Period == 10
* ============================================================
* P2.2.5 - Tabla de estadísticas descriptivas
* Media, varianza, sd, mínimo, máximo y rango
* Períodos 1 y 10, para SIN castigo y CON castigo
* ============================================================

* ---------- SIN CASTIGO ----------
import excel "C:\Users\prestamour\Downloads\doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A2:Q12) firstrow clear

egen media_sc    = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
egen sd_sc       = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
egen max_sc      = rowmax(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
egen min_sc      = rowmin(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

gen var_sc   = sd_sc^2
gen rango_sc = max_sc - min_sc

display "===== SIN CASTIGO ====="
list Period media_sc var_sc sd_sc min_sc max_sc rango_sc if Period == 1 | Period == 10

* ---------- CON CASTIGO ----------
import excel "C:\Users\prestamour\Downloads\doing-economics-datafile-working-in-excel-project-2.xlsx", sheet("Public goods contributions") cellrange(A16:Q26) firstrow clear

egen media_cc    = rowmean(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
egen sd_cc       = rowsd(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
egen max_cc      = rowmax(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)
egen min_cc      = rowmin(Copenhagen Dnipropetrovsk Minsk StGallen Muscat Samara Zurich Boston Bonn Chengdu Seoul Riyadh Nottingham Athens Istanbul Melbourne)

gen var_cc   = sd_cc^2
gen rango_cc = max_cc - min_cc

display "===== CON CASTIGO ====="
list Period media_cc var_cc sd_cc min_cc max_cc rango_cc if Period == 1 | Period == 10