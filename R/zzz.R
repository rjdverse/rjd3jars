#' @importFrom rJava .jpackage .jcall .jinit
NULL

#' @title Java Utility Functions
#' @name jd3_utilities
#'
#' @returns `get_java_version()` returns the current java installed and usable
#' version. It's an integer.
#'
#' @examples
#' print(minimal_java_version)
#' print(get_java_version())
#' @export
get_java_version <- function() {
    .jinit()
    jversion <- .jcall("java.lang.System", "S", "getProperty", "java.version")
    jversion <- as.integer(regmatches(
        x = jversion,
        m = regexpr(pattern = "^(\\d+)", text = jversion)
    ))
    return(jversion)
}

#' @rdname jd3_utilities
#' @export
current_java_version <- get_java_version()

#' @rdname jd3_utilities
#' @export
minimal_java_version <- 21L

.onAttach <- function(libname, pkgname) {
    .current_java_version <- get_java_version()
    if (.current_java_version < minimal_java_version) {
        packageStartupMessage(sprintf(
            "Your java version is %s. %s or higher is needed.",
            .current_java_version,
            minimal_java_version
        ))
    }
}

.onLoad <- function(libname, pkgname) {
    result <- .jpackage(pkgname, lib.loc = libname)
    if (!result) stop("Loading java packages failed", call. = FALSE)

    if (is.null(getOption("summary_info"))) {
        options(summary_info = TRUE)
    }
}
