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

# levels are ordered alphanumerically (default)
tage <- factor(c("Mittwoch", "Montag", "Mittwoch", "Dienstag", "Dienstag"))
levels(tage)
tage

# but can be ordered manually
tage <- factor(tage, levels = c("Montag", "Dienstag", "Mittwoch"))
tage
levels(tage)

# or by their appearance in the factor
tage <- forcats::fct_inorder(tage)
tage

# technically factors are vectors with two attributes:
#   $levels
#   $class
attributes(tage)

# a simple vector has no attributes
days <- c("Montag", "Dienstag", "Mittwoch")
attributes(days)


## data types
# 1. integer
# 2. numeric
# 3. character
# 4. logical

# integer vs. numeric
class(2L)
class(2.0)

## data structures
# 1. vector / factor
# 2. matrix
# 3. array
# 4. list
# 5. data frame

# homogenious: vector, matrix, array
# heterogenious: list, data frame

num_vector <- c(1, 2.71, 3.14)
int_vector <- c(1L, 2L, 3L)         # integers!
chr_vector <- c("Hallo ", "R")
lgl_vector <- c(TRUE, FALSE, T, F)


## attributes
# pure vectors do not have attributes
vec <- c(1, 2, 3)
attributes(vec)

# adding attributes to a vector
# here: element names
named_vec <- c(a=1, b=2, c=3)
attributes(named_vec)

# adding other attributes
attr(vec, "Autor") <- "Stefan Schmidt"
attributes(vec)

attr(named_vec, "Autor") <- "Stefan Schmidt"
attr(named_vec, "Datum") <- 2019
attributes(named_vec)
# calling shows data and attributes
named_vec


## factors
# factor levels are stored as integer values
sex <- factor(c("mann", "frau", "frau", "frau"))
str(sex)

# CAVE! even numeric values are stored internally 
# with their labels integer value
age <- factor(c(39, 40, 38.5, 37, 41, 40, 38, 42))
age_numeric <- as.numeric(age)
age_numeric

# use this workaround to get back the original values
age_numeric <- as.numeric(as.character(age))
age_numeric
str(age_numeric)


## data frame vs. tibble

# data.frame (default: strings as factors)
df1 <- data.frame(essen = c("Suppe", "Suppe", "Pizza",),
                  geschmack = c(2, 2, 5))
str(df1)

# tibble (default: character vectors)
library(tibble)
df2 <- tibble(essen = c("Suppe", "Suppe", "Pizza"),
              geschmack = c(2, 2, 5))
str(df2)


## subsetting basics
x <- c(2.2, 3.3, 4.4)

# single index
x[1]

# multiple index
x[c(1, 2)]
# same index several times
x[c(1, 1, 2, 1)]

# negative index excludes
x[-1]
# works with multiple index
x[-c(1, 2)]

# logical index
x[c(TRUE, TRUE, FALSE)]

# locical expressions
x[x > 3]
# reason: expression returns logical vector
x > 3

# names
noten <- c("Anna" = 1.3, "Berta" = 2.7, "Carla" = 4.3)
noten["Anna"]
noten[c("Anna", "Anna", "Carla")]

## data frames

# todesfaelle ZH 1995 - 2017
df <- read.csv("./data/bev312od3120.csv")

# subsetting with [] returns a data frame
class(df[1])
class(df[1,])
class(df["StichtagDatJahr"])

# subsetting with [[]] or $ returns a vector
class(df[[1]])
class(df[["StichtagDatJahr"]])
class(df$StichtagDatJahr)


# subsetting df elements
df[2, c(1, 2)]
