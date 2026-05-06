#' @include utils.R
#' @importFrom rJava .jpackage .jcall

#' @title Java Utility Functions
#'
#' @description
#' These functions are used in all JDemetra+ 3.0 packages to easily interact between R and Java objects.
#' @name jd3_utilities
NULL
#> NULL


#' @title Reload dictionaries
#'
#' @export
#'
#' @returns invisibly \code{NULL}
#'
#' @examplesIf check_java_version()
#' reload_dictionaries()
reload_dictionaries <- function() {
    .jcall("jdplus/toolkit/base/api/information/InformationExtractors", "V", "reloadExtractors")
}

TSFACTORY<-"jdplus/toolkit/base/api/timeseries/TsFactory"

#' Reload all the time series providers
#'
#' @export
#'
#' @examplesIf check_java_version()
#' reload_tsproviders()
reload_tsproviders<-function(){
    jfac <- .jcall(TSFACTORY,  "Ljdplus/toolkit/base/api/timeseries/TsFactory;", "ofServiceLoader")
    .jcall( TSFACTORY, "V", "setDefault", jfac)
}
