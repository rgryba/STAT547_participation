pow <- function(x, a=2) x^a
res <- x^p
if (showplot) {
  p <- ggplot2::qplot(x, res)
  print(p)
}
res
