#' @include protos.R
#' @importFrom rJava .jpackage
NULL

.onLoad <- function(libname, pkgname) {
    result <- .jpackage(pkgname, lib.loc = libname)
    if (!result)
        stop("Loading java packages failed")

    PROTO_DIR <<- system.file("proto", package = pkgname)
}

