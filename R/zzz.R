#' @title Extract the Java installed version
#'
#' @param silent Boolean to indicate if a message should be displayed.
#' @param startup Boolean to indicate if the function is launch at the startup
#'   of the package.
#'
#' @name java-version
#'
#' @returns `get_java_version()` returns the current java installed and usable
#' version. It's an integer.
#' `minimal_java_version` is the minimal java version accepted currently by
#' JDemetra+.
#' `check_java_version()` returns `TRUE` or `FALSE` if the current version of
#' Java is greater than or equal to the minimum required version.
#'
#' @examples
#' print(minimal_java_version)
#' print(get_java_version())
#' check_java_version()
#'
#' @importFrom rJava .jcall
#' @export
get_java_version <- function() {
    jversion <- rJava::.jcall(
        obj = "java.lang.System",
        returnSig = "S",
        method = "getProperty",
        "java.version"
    )
    jversion <- as.integer(regmatches(
        x = jversion,
        m = regexpr(pattern = "^(\\d+)", text = jversion)
    ))
    return(jversion)
}

#' @rdname java-version
#' @export
minimal_java_version <- 21L

#' @rdname java-version
#' @export
check_java_version <- function(silent = TRUE, startup = TRUE) {
    current_java_version <- get_java_version()
    if (current_java_version >= minimal_java_version) {
        return(TRUE)
    }
    text <- sprintf(
        "Your java version is %s. %s or higher is needed.",
        current_java_version,
        minimal_java_version
    )
    if (!silent && startup) {
        packageStartupMessage(text)
    } else if (!silent) {
        message(text)
    }
    return(FALSE)
}

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
        stop("Loading java packages failed")
    }

    # Check Java version
    check_java_version(silent = FALSE, startup = TRUE)
}
