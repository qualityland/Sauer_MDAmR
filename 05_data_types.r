library(tidyverse)

vec <- c(father = "Stefan", mother = "Damla", child = "Victoria")
attributes(vec)
attr(vec, "pet") <- "Ameni"
vec
attributes(vec)


mat <- matrix(c('ich', 'du', 'er', 'wir', 'ihr', 'sie'), ncol = 3, byrow = TRUE)
mat
class(mat)
typeof(mat)


mat2 <- matrix(c(T, T, F, T, F, F, T, F), ncol = 4, byrow = TRUE)
mat2
class(mat2)
typeof(mat2)
