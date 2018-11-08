#' Generic Power Function
#'
#' This function raises a vector to any power. I'm making it internal,
#' by not \code{export}ing, because I don't want users to use it.
#' Why not? Because I said so!
#'
#' @param x Vector to raise to some power.
#' @param a Power to raise \code{x} by.
#' @param plot_it Display a plot of \code{x} vs the output? Use logical.
#'
#' @return The vector \code{x}, raised to the power of \code{a}.
pow <- function(x, a, plot_it) {
    res <- x^a
    if (plot_it) print(ggplot2::qplot(x, res))
    return(res)
}
