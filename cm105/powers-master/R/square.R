#' Apply a useful power
#'
#' That's it -- these functions just square, cube, or take the
#' reciprocal/inverse of a vector.
#'
#' @param x The vector to be squared or cubed.
#' @param plot_it Display a plot of \code{x} vs the output? Use logical.
#' \code{FALSE} by default.
#'
#' @return
#' A vector that is the:
#' \itemize{
#'      \item square (for \code{square})
#'      \item cube (for \code{cube})
#'      \item reciprocal/inverse (for \code{reciprocal})
#' }
#'  of \code{x}.
#'
#' @details
#' If you really want to see more, check out the internal \code{\link{pow}}
#' function that these functions depend on.
#' @examples
#' cube(tenvec)
#' square(-5)
#' reciprocal(2)
#' @rdname square
#' @export
square <- function(x, plot_it=FALSE) pow(x, a=2, plot_it=plot_it)

#' @rdname square
#' @export
cube <- function(x, plot_it=FALSE) pow(x, a=3, plot_it=plot_it)


#' @rdname square
#' @export
reciprocal <- function(x, plot_it=FALSE) pow(x, a=-1, plot_it=plot_it)
