# Econometría II — Series de Tiempo

Material de clase del curso **Econometría II: Series de Tiempo**, Tec de Monterrey, agosto-septiembre 2026.

**Profesor:** Benjamín Oliva (benjov@tec.mx)

## Sobre el curso

Curso de 5 semanas (martes y miércoles) que introduce el análisis de series de tiempo univariadas: desde ecuaciones en diferencia hasta modelos ARIMA, pruebas de raíz unitaria y modelos de volatilidad (ARCH/GARCH). Todo el código es en **R**, usando R Markdown.

Es una versión condensada del curso semestral que el profesor imparte en la Facultad de Economía de la UNAM ([repositorio](https://github.com/benjov/Series-Tiempo-2026), [notas de clase](https://benjov.github.io/Series-Tiempo/index.html)); el temario completo de esta edición está en [`Temario y Tareas/`](./Temario%20y%20Tareas).

## Estructura del repositorio

```
Clase_IntroR/     Introducción a R
Clase_01/         Naturaleza de las series de tiempo, ejemplos y aplicaciones
Clase_02/         Ecuaciones en diferencia, operador de rezago, procesos divergentes
Clase_03/         Procesos AR(p), MA(q), FAC y FACP
Clase_04/         ARMA(p,q) / ARIMA(p,d,q), metodología Box-Jenkins, pronóstico
Clase_05/         No estacionariedad, pruebas de raíz unitaria (DF/ADF/PP/KPSS), cambio estructural
Clase_06/         Descomposición de series (clásica, STL, filtro Hodrick-Prescott)
Clase_07/         Modelos ARCH
Clase_08/         Modelos GARCH y extensiones (EGARCH)

Practica_01/      Práctica 1 — Aplicación de un modelo AR(1) (15% de la calificación)
Practica_02/      Práctica 2 — Pruebas de raíz unitaria y cambio estructural (15%)

data/             Bases de datos compartidas entre las clases (ver abajo)
utils/            Funciones de R reutilizadas por varias clases
Temario y Tareas/ Temario oficial del curso (PDF)
```

Cada carpeta `Clase_XX/` contiene un único archivo `Clase_XX.Rmd`: es un notebook de clase ya resuelto (teoría + código + ejercicios al final), pensado para exponerse en vivo y para que sirva de material de consulta después. Las carpetas `Practica_XX/` son evaluación: plantillas con secciones en blanco que cada alumno completa con una serie de su elección.

### Datos

Todas las clases y prácticas comparten dos bases de INEGI, centralizadas en `data/`:

| Archivo | Periodo | Variables |
|---|---|---|
| `Base_Transporte.xlsx` | Mensual, ene-2000 a jun-2025 | `Pax_Nal`, `Pax_Int`, `Vue_Nal`, `Vue_Int` (pasajeros y vuelos, nacionales/internacionales), `Pax_Metro` (pasajeros del STC Metro) |
| `Data_Practica_02.xlsx` | Mensual, ene-2005 a jul-2025 | `Informalidad`, `TDesocupa`, `TDesocupa_H`, `TDesocupa_M` (tasas de informalidad y desocupación) |

Usar las mismas series a lo largo del curso (incluida la parte de volatilidad, en `Clase_07`/`Clase_08`) es intencional: permite ver cómo un mismo dato — por ejemplo el choque de la pandemia en 2020 — aparece bajo distintas lentes: como quiebre estructural (Clase 05), como pérdida de estacionariedad (Clase 05), o como agrupamiento de volatilidad (Clase 07-08).

### `utils/utils.R`

Funciones auxiliares que varias clases cargan con `source("../utils/utils.R")`:

- `tema_series()` — tema `ggplot2` consistente
- `plot_char_roots()` — grafica las raíces características de un proceso AR/ARMA sobre el círculo unitario
- `unit_root_summary()` — corre ADF (3 especificaciones), Phillips-Perron y KPSS sobre una serie y regresa una tabla comparativa

## Calendario

| Semana | Martes | Miércoles |
|---|---|---|
| 1 (11-12 ago) | Intro a R | Clase 01 |
| 2 (18-19 ago) | Clase 02 | Clase 03 · **Práctica 1** (AR(1)) |
| 3 (25-26 ago) | Clase 04 | **Examen parcial** (temas 1-3) |
| 4 (1-2 sep) | Clase 05 · **Práctica 2** (raíz unitaria) | Clase 06 |
| 5 (8-9 sep) | Clase 07 | Clase 08 |

**Prácticas:** `Practica_01` (fecha en el Rmd: 19-ago) evalúa lo visto en Clase 03; `Practica_02` (fecha en el Rmd: 1-sep) evalúa lo visto en Clase 05. Cada una vale 15% de la calificación.

**Trabajo final** (41% de la calificación, ensayo aplicando alguna técnica del curso): se entrega el fin de semana del 12-13 de septiembre.

**Ponderación:** Prácticas 15% c/u · Examen parcial 29% · Trabajo final 41%.

## Cómo usar este repositorio

1. Clona o descarga el repositorio.
2. Abre el `.Rmd` de la clase que quieras revisar en RStudio.
3. Los paquetes de R que usa el curso (instálalos una vez):

   ```r
   install.packages(c(
     "ggplot2", "dplyr", "readxl", "tidyr",
     "forecast", "urca", "strucchange", "mFilter",
     "rugarch", "FinTS",
     "zoo", "sandwich", "lmtest", "vars", "MASS"
   ))
   ```

4. Cada `Clase_XX.Rmd` lee los datos con rutas relativas (`../data/...`) y carga utilidades con `source("../utils/utils.R")` — para que funcione, abre el `.Rmd` directamente (o fija el directorio de trabajo a la carpeta `Clase_XX/`) en vez de correr el código desde la raíz del repositorio.
5. Para generar el HTML de una clase: botón *Knit* en RStudio, o `rmarkdown::render("Clase_XX.Rmd")` (requiere [pandoc](https://pandoc.org/installing.html)).
