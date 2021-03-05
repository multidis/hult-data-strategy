# Example visualization using ggplot2 with a built-in diamonds dataset.
library(ggplot2)

ggplot(diamonds, aes(x=carat, y=price, color=cut)) +
  geom_point()

