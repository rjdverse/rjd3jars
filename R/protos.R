#' @importFrom RProtoBuf readProtoFiles2
NULL

# actual namespace environment of this package

PROTO_DIR <- NULL

.env <- new.env()

#' Initialize protos
#'
#' @export
#'
#' @examples
#' initialize_protos()
initialize_protos  <- function() {
    if (! exists("initialized", .env)) {
        readProtoFiles2(protoPath = PROTO_DIR)
        assign("initialized", TRUE, .env)
    }
}
