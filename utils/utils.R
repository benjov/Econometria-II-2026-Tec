# Funciones utilitarias compartidas — Series de Tiempo, Econometría II (Tec, 2026)
# Se cargan en cada Clase_XX.Rmd con: source("../utils/utils.R")

library(ggplot2)

# Tema ggplot consistente para todas las clases
tema_series <- function() {
  theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(face = "bold"),
      panel.grid.minor = element_blank(),
      legend.position = "bottom"
    )
}

# Grafica las raices caracteristicas (inversas) de un proceso AR/ARMA sobre el circulo unitario.
# coefs_ar: vector de coeficientes AR (phi_1, ..., phi_p). Un proceso es estacionario si todas
# las raices caen FUERA del circulo unitario (equivalentemente, las raices inversas caen DENTRO).
plot_char_roots <- function(coefs_ar, titulo = "Raíces características") {
  poly_coefs <- c(1, -coefs_ar)
  raices <- polyroot(poly_coefs)
  df_raices <- data.frame(re = Re(raices), im = Im(raices),
                           modulo = Mod(raices))
  circulo <- data.frame(theta = seq(0, 2 * pi, length.out = 200))
  circulo$re <- cos(circulo$theta)
  circulo$im <- sin(circulo$theta)

  ggplot() +
    geom_path(data = circulo, aes(x = re, y = im), color = "grey50", linetype = "dashed") +
    geom_point(data = df_raices, aes(x = re, y = im), color = "firebrick", size = 3) +
    coord_equal() +
    labs(title = titulo, x = "Parte real", y = "Parte imaginaria",
         subtitle = "El proceso es estacionario si todas las raíces caen fuera del círculo unitario") +
    tema_series()
}

# Corre ADF (Modelos A/B/C), PP y KPSS sobre una serie y regresa un resumen compacto.
# serie: vector numérico o objeto ts. lags: rezagos para ADF/PP ("short" usa la regla de Schwert).
unit_root_summary <- function(serie, nombre = "serie") {
  library(urca)

  adf_none  <- ur.df(serie, type = "none",  selectlags = "AIC")
  adf_drift <- ur.df(serie, type = "drift", selectlags = "AIC")
  adf_trend <- ur.df(serie, type = "trend", selectlags = "AIC")

  pp_drift <- ur.pp(serie, type = "Z-tau", model = "constant", lags = "short")
  pp_trend <- ur.pp(serie, type = "Z-tau", model = "trend",    lags = "short")

  kpss_mu  <- ur.kpss(serie, type = "mu",  lags = "short")
  kpss_tau <- ur.kpss(serie, type = "tau", lags = "short")

  data.frame(
    serie = nombre,
    prueba = c("ADF (sin cte, Modelo C)", "ADF (deriva, Modelo B)", "ADF (deriva+tendencia, Modelo A)",
               "PP (deriva)", "PP (deriva+tendencia)",
               "KPSS (nivel)", "KPSS (tendencia)"),
    estadistico = round(c(adf_none@teststat[1], adf_drift@teststat[1], adf_trend@teststat[1],
                           pp_drift@teststat[1], pp_trend@teststat[1],
                           kpss_mu@teststat[1], kpss_tau@teststat[1]), 4),
    cv_5pct = round(c(adf_none@cval[1, "5pct"], adf_drift@cval[1, "5pct"], adf_trend@cval[1, "5pct"],
                       pp_drift@cval[1, "5pct"], pp_trend@cval[1, "5pct"],
                       kpss_mu@cval[1, "5pct"], kpss_tau@cval[1, "5pct"]), 4)
  )
}
