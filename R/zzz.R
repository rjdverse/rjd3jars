
#' @title Extract the Java installed version
#' @name java-version
#'
#' @returns `get_java_version()` returns the current java installed and usable
#' version. It's an integer.
#' `minimal_java_version` is the minimal java version accepted currently by
#' JDemetra+.
#'
#' @examples
#' print(minimal_java_version)
#' print(get_java_version())
#'
#' @importFrom rJava .jcall .jinit
#' @export
get_java_version <- function() {
    rJava::.jinit()
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
current_java_version <- get_java_version()

#' @rdname java-version
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

#' @importFrom rJava .jpackage .jaddClassPath
.onLoad <- function(libname, pkgname) {
    jar_dir <- file.path(libname, pkgname, "inst", "java")
    jars <- list.files(jar_dir, pattern = "\\.jar$", full.names = TRUE,
                       all.files = TRUE)
    rJava::.jaddClassPath(jars)
    result <- rJava::.jpackage(pkgname, lib.loc = libname)
    if (!result) stop("Loading java packages failed", call. = FALSE)

    if (is.null(getOption("summary_info"))) {
        options(summary_info = TRUE)
    }
}
