#' @noRd
.onAttach <- function(libname, pkgname) {
    # Check Java version
    check_java_version(silent = FALSE, startup = TRUE)
}

#' @noRd
#' @importFrom rJava .jpackage
.onLoad <- function(libname, pkgname) {
    # Loading Java class
    jar_dir <- file.path(libname, pkgname, "inst", "java")
    jars_inst <- list.files(
        jar_dir,
        pattern = "\\.jar$",
        full.names = TRUE,
        all.files = TRUE
    )
    result <- rJava::.jpackage(
        pkgname,
        lib.loc = libname,
        morePaths = jars_inst
    )
    if (!result) {
        stop("Loading Java packages failed", call. = FALSE)
    }
}
