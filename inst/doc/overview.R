## ----setup, echo = FALSE, message = FALSE--------------------------------
knitr::opts_chunk$set(tidy = FALSE, comment = "#>")

## ----load-lib, message = FALSE, warning = FALSE--------------------------
library(rsalad)
library(dplyr)
library(ggplot2)

## ----load-data, results = "hide"-----------------------------------------
fDat <- nycflights13::flights
head(fDat)

## ----show-data, echo = FALSE, results = 'asis'---------------------------
knitr::kable(head(fDat))

## ----show-do-notIn, results = "hold"-------------------------------------
fDat2 <- fDat %>% filter(carrier %nin% c("UA", "DL", "AA"))
allCarriers <- fDat %>% dplyr::select(carrier) %>% first %>% unique
myCarriers <- fDat2 %>% dplyr::select(carrier) %>% first %>% unique

paste0("All carriers: ", paste(allCarriers, collapse = ", "))
paste0("My carriers: ", paste(myCarriers, collapse = ", "))

## ----show-notIn-alias----------------------------------------------------
fDat2_2 <- fDat %>% filter(notIn(carrier, c("UA", "DL", "AA")))
identical(fDat2, fDat2_2)

## ----select-cols, results = "hide"---------------------------------------
fDat3 <- fDat2 %>% dplyr::select(carrier, flight, origin, dest)
head(fDat3)

## ----show-data-3, echo = FALSE, results = 'asis'-------------------------
knitr::kable(head(fDat3))

## ----move, results = "hide"----------------------------------------------
fDat4 <- fDat3 %>% moveFront(dest, origin)
head(fDat4)

## ----show-data-4, echo = FALSE, results = 'asis'-------------------------
knitr::kable(head(fDat4))

## ----move-alias----------------------------------------------------------
fDat4_2 <- fDat3 %>% moveFront_(c("dest", "origin"))
fDat4_3 <- fDat3 %>% moveBack(carrier, flight) %>% moveFront(dest)

all(identical(fDat4, fDat4_2), identical(fDat4, fDat4_3))

## ----do-dfFactorize------------------------------------------------------
str(fDat4)
fDat5 <- fDat4 %>% dfFactorize()
str(fDat5)

## ----dfFactorize-examples------------------------------------------------
str(fDat4 %>% dfFactorize(only = "origin"))
str(fDat4 %>% dfFactorize(ignore = c("origin", "dest")))

## ----do-table------------------------------------------------------------
head(table(fDat5$dest))

## ----do-dfCount, results = "hide"----------------------------------------
countDat <- fDat5 %>% dfCount("dest")
head(countDat)

## ----show-count-data, echo = FALSE, results = 'asis'---------------------
knitr::kable(head(countDat))

## ----keep-50-------------------------------------------------------------
countDat2 <- slice(countDat, 1:50)

## ----show-plotCount, fig.width = 8---------------------------------------
plotCount(countDat2)

## ----rotateTextX, fig.width = 8------------------------------------------
plotCount(countDat2) + rotateTextX()

## ----removeGrid, fig.width = 8-------------------------------------------
plotCount(countDat2) + rotateTextX() + removeGridX()

## ----show-tolowerfirst---------------------------------------------------
df <- data.frame(StudentName = character(0), ExamGrade = numeric(0))
(colnames(df) <- tolowerfirst(colnames(df)))

## ----dfCount-performance, results = "hide"-------------------------------
library(microbenchmark)

# Prepare all the datasets to test on
fDat <- nycflights13::flights
largeIntDat <- data.frame(col = rep(1:25, 100000))
largeCharDat <- data.frame(col = rep(letters[1:25], 100000))
smallDat <- data.frame(col = rep(1:25, 100))

# Run the benchmarking
m <- 
	microbenchmark(
	  dfCount(fDat, "day"), table(fDat$day),
	  dfCount(fDat, "dest"), table(fDat$dest),
	  dfCount(largeIntDat, "col"), table(largeIntDat$col),
	  dfCount(largeCharDat, "col"), table(largeCharDat$col), 
	  dfCount(smallDat, "col"), table(smallDat$col),
	  times = 50
	)

## ----show-dfCount-performance, echo = FALSE, results = 'asis'------------
knitr::kable(summary(m) %>% dplyr::select(expr, min, mean, median, max, neval))

