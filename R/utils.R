tsfactory <- "jdplus/toolkit/base/api/timeseries/TsFactory"

#' @title Reload dictionaries
#'
#' @returns invisibly \code{NULL}
#'
#' @importFrom rJava .jcall
#' @export
#'
#' @examplesIf check_java_version()
#' reload_dictionaries()
reload_dictionaries <- function() {
    rJava::.jcall(
        obj = "jdplus/toolkit/base/api/information/InformationExtractors",
        returnSig = "V",
        method = "reloadExtractors"
    )
    return(invisible(NULL))
}

#' @title Reload all the time series providers
#'
#' @returns invisibly \code{NULL}
#'
#' @importFrom rJava .jcall
#' @export
#'
#' @examplesIf check_java_version()
#' reload_tsproviders()
reload_tsproviders <- function() {
    jfac <- rJava::.jcall(
        obj = tsfactory,
        returnSig = "Ljdplus/toolkit/base/api/timeseries/TsFactory;",
        method = "ofServiceLoader"
    )
    rJava::.jcall(obj = tsfactory, returnSig = "V", method = "setDefault", jfac)
    return(invisible(NULL))
}

#' @title Reload all seasonal adjustment factories
#'
#' @importFrom rJava .jcall
#' @export
#'
#' @examplesIf check_java_version()
#' reload_safactories()
reload_safactories <- function() {
    rJava::.jcall(
        obj = "jdplus/sa/base/api/SaManager",
        returnSig = "V",
        method = "reload"
    )
    return(invisible(NULL))
}
