Overview
--------

`rsalad`, like any other salad, is a mixture of different healthy
vegetables that you should be having frequently and that can make your
life much better. Except that instead of vegetables, `rsalad` provides
you with R functions.

This package was born as a result of me constantly breaking the DRY
principle by copy-and-pasting functions from old projects into new ones.
Hence, the functions in `rsalad` do not have a single common topic, but
they are all either related to manipulating data.frames or general
productivity utilities.

Analysis
--------

This vignette will introduce all the families of functions available in
`rsalad`, but will not dive too deeply into any one specific function.
To demonstrate all the functionality, we will use the
`nycflights13::flights` dataset (information about ~335k flights
departing from NYC) to visualize the 50 most common destinations of
flights out of NYC. While the analysis is not particularly exciting, it
will show how to use `rsalad` proficiently.

### Load packages

Before beginning any analysis using `rsalad`, the first step is to load
the package. We'll also load `dplyr` and `ggplot2` to make the analysis
more complete.

    library(rsalad)
    library(dplyr)
    library(ggplot2)

### Load data

First step is to load the `flights` dataset and have a peak at how it
looks

    fDat <- nycflights13::flights
    head(fDat)

<table>
<thead>
<tr class="header">
<th align="right">year</th>
<th align="right">month</th>
<th align="right">day</th>
<th align="right">dep_time</th>
<th align="right">dep_delay</th>
<th align="right">arr_time</th>
<th align="right">arr_delay</th>
<th align="left">carrier</th>
<th align="left">tailnum</th>
<th align="right">flight</th>
<th align="left">origin</th>
<th align="left">dest</th>
<th align="right">air_time</th>
<th align="right">distance</th>
<th align="right">hour</th>
<th align="right">minute</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">2013</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">517</td>
<td align="right">2</td>
<td align="right">830</td>
<td align="right">11</td>
<td align="left">UA</td>
<td align="left">N14228</td>
<td align="right">1545</td>
<td align="left">EWR</td>
<td align="left">IAH</td>
<td align="right">227</td>
<td align="right">1400</td>
<td align="right">5</td>
<td align="right">17</td>
</tr>
<tr class="even">
<td align="right">2013</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">533</td>
<td align="right">4</td>
<td align="right">850</td>
<td align="right">20</td>
<td align="left">UA</td>
<td align="left">N24211</td>
<td align="right">1714</td>
<td align="left">LGA</td>
<td align="left">IAH</td>
<td align="right">227</td>
<td align="right">1416</td>
<td align="right">5</td>
<td align="right">33</td>
</tr>
<tr class="odd">
<td align="right">2013</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">542</td>
<td align="right">2</td>
<td align="right">923</td>
<td align="right">33</td>
<td align="left">AA</td>
<td align="left">N619AA</td>
<td align="right">1141</td>
<td align="left">JFK</td>
<td align="left">MIA</td>
<td align="right">160</td>
<td align="right">1089</td>
<td align="right">5</td>
<td align="right">42</td>
</tr>
<tr class="even">
<td align="right">2013</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">544</td>
<td align="right">-1</td>
<td align="right">1004</td>
<td align="right">-18</td>
<td align="left">B6</td>
<td align="left">N804JB</td>
<td align="right">725</td>
<td align="left">JFK</td>
<td align="left">BQN</td>
<td align="right">183</td>
<td align="right">1576</td>
<td align="right">5</td>
<td align="right">44</td>
</tr>
<tr class="odd">
<td align="right">2013</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">554</td>
<td align="right">-6</td>
<td align="right">812</td>
<td align="right">-25</td>
<td align="left">DL</td>
<td align="left">N668DN</td>
<td align="right">461</td>
<td align="left">LGA</td>
<td align="left">ATL</td>
<td align="right">116</td>
<td align="right">762</td>
<td align="right">5</td>
<td align="right">54</td>
</tr>
<tr class="even">
<td align="right">2013</td>
<td align="right">1</td>
<td align="right">1</td>
<td align="right">554</td>
<td align="right">-4</td>
<td align="right">740</td>
<td align="right">12</td>
<td align="left">UA</td>
<td align="left">N39463</td>
<td align="right">1696</td>
<td align="left">EWR</td>
<td align="left">ORD</td>
<td align="right">150</td>
<td align="right">719</td>
<td align="right">5</td>
<td align="right">54</td>
</tr>
</tbody>
</table>

### `%nin%` operator and `notIn()`

Let's say that for some reason we aren't interested in flights operated
by United Airlines (UA), Delta Airlines (DL) and American Airlines (AA).
To choose only carrier that are **not** part of that group, we can use
the `%nin%` operator, which is also aliased to `notIn()`.

    fDat2 <- fDat %>% filter(carrier %nin% c("UA", "DL", "AA"))
    allCarriers <- fDat %>% select(carrier) %>% first %>% unique
    myCarriers <- fDat2 %>% select(carrier) %>% first %>% unique

    paste0("All carriers: ", paste(allCarriers, collapse = ", "))
    paste0("My carriers: ", paste(myCarriers, collapse = ", "))

    #> [1] "All carriers: UA, AA, B6, DL, EV, MQ, US, WN, VX, FL, AS, 9E, F9, HA, YV, OO"
    #> [1] "My carriers: B6, EV, MQ, US, WN, VX, FL, AS, 9E, F9, HA, YV, OO"

The `%nin%` operator is simply the negation of `%in%`, but can be a
handy shortcut. `lhs %nin% rhs` is equivalent to `notIn(lhs, rhs)`. The
following code would have the same result as above:

    fDat2_2 <- fDat %>% filter(notIn(carrier, c("UA", "DL", "AA")))
    identical(fDat2, fDat2_2)

    #> [1] TRUE

For more information, see `?rsalad::notIn`.

### `move` functions: move columns to front/back

The `move` family of functions can be used to rearrange the column order
of a data.frame by moving specific columns to be the first
(`moveFront()` and `moveFront_()`) or last (`moveBack()` and
`moveBack_()`) columns.  
The order in which the columns are passed in as arguments determines the
order in which the columns will be in the resulting data.frame,
regardless of whether the columns are moved to the front or back.

These functions support non-standard evaulation (see function
documentation for more details).

For brevity, we will only keep a few columns in the data.

    fDat3 <- fDat2 %>% select(carrier, flight, origin, dest)
    head(fDat3)

<table>
<thead>
<tr class="header">
<th align="left">carrier</th>
<th align="right">flight</th>
<th align="left">origin</th>
<th align="left">dest</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">B6</td>
<td align="right">725</td>
<td align="left">JFK</td>
<td align="left">BQN</td>
</tr>
<tr class="even">
<td align="left">B6</td>
<td align="right">507</td>
<td align="left">EWR</td>
<td align="left">FLL</td>
</tr>
<tr class="odd">
<td align="left">EV</td>
<td align="right">5708</td>
<td align="left">LGA</td>
<td align="left">IAD</td>
</tr>
<tr class="even">
<td align="left">B6</td>
<td align="right">79</td>
<td align="left">JFK</td>
<td align="left">MCO</td>
</tr>
<tr class="odd">
<td align="left">B6</td>
<td align="right">49</td>
<td align="left">JFK</td>
<td align="left">PBI</td>
</tr>
<tr class="even">
<td align="left">B6</td>
<td align="right">71</td>
<td align="left">JFK</td>
<td align="left">TPA</td>
</tr>
</tbody>
</table>

Now let's rearrange the columns to be in this order: dest, origin,
carrier, flight.

    fDat4 <- fDat3 %>% moveFront(dest, origin)
    head(fDat4)

<table>
<thead>
<tr class="header">
<th align="left">dest</th>
<th align="left">origin</th>
<th align="left">carrier</th>
<th align="right">flight</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">BQN</td>
<td align="left">JFK</td>
<td align="left">B6</td>
<td align="right">725</td>
</tr>
<tr class="even">
<td align="left">FLL</td>
<td align="left">EWR</td>
<td align="left">B6</td>
<td align="right">507</td>
</tr>
<tr class="odd">
<td align="left">IAD</td>
<td align="left">LGA</td>
<td align="left">EV</td>
<td align="right">5708</td>
</tr>
<tr class="even">
<td align="left">MCO</td>
<td align="left">JFK</td>
<td align="left">B6</td>
<td align="right">79</td>
</tr>
<tr class="odd">
<td align="left">PBI</td>
<td align="left">JFK</td>
<td align="left">B6</td>
<td align="right">49</td>
</tr>
<tr class="even">
<td align="left">TPA</td>
<td align="left">JFK</td>
<td align="left">B6</td>
<td align="right">71</td>
</tr>
</tbody>
</table>

The same result can be achieved in different ways using other `move`
functions.

    fDat4_2 <- fDat3 %>% moveFront_(c("dest", "origin"))
    fDat4_3 <- fDat3 %>% moveBack(carrier, flight) %>% moveFront(dest)

    all(identical(fDat4, fDat4_2), identical(fDat4, fDat4_3))

    #> [1] TRUE

For more information, see `?rsalad::move`.

### `dfFactorize()`: convert data.frame columns to factors

Sometimes you want to convert all the character columns of a data.frame
into factors. In our current data, we have three character variables
(dest, origin, carrier), but they all make more sense as factors. Rather
than converting each column manually, we can use the `dfFactorize()`
function.

    str(fDat4)

    #> Classes 'tbl_df', 'tbl' and 'data.frame':    197272 obs. of  4 variables:
    #>  $ dest   : chr  "BQN" "FLL" "IAD" "MCO" ...
    #>  $ origin : chr  "JFK" "EWR" "LGA" "JFK" ...
    #>  $ carrier: chr  "B6" "B6" "EV" "B6" ...
    #>  $ flight : int  725 507 5708 79 49 71 1806 371 4650 343 ...

    fDat5 <- fDat4 %>% dfFactorize()
    str(fDat5)

    #> Classes 'tbl_df', 'tbl' and 'data.frame':    197272 obs. of  4 variables:
    #>  $ dest   : Factor w/ 94 levels "ABQ","ACK","ALB",..: 12 32 38 48 63 90 11 32 4 63 ...
    #>  $ origin : Factor w/ 3 levels "EWR","JFK","LGA": 2 1 3 2 2 2 2 3 3 1 ...
    #>  $ carrier: Factor w/ 13 levels "9E","AS","B6",..: 3 3 4 3 3 3 3 3 8 3 ...
    #>  $ flight : int  725 507 5708 79 49 71 1806 371 4650 343 ...

As you can see, calling `dfFactorize()` with no additional arguments
converted all potential factor columns into factors. Note that the
integer column was unaffected.

By default, all character columns are coerced to factors, but we can
also specify which columns to convert or which columns to leave
unaffected.

    str(fDat4 %>% dfFactorize(only = "origin"))

    #> Classes 'tbl_df', 'tbl' and 'data.frame':    197272 obs. of  4 variables:
    #>  $ dest   : chr  "BQN" "FLL" "IAD" "MCO" ...
    #>  $ origin : Factor w/ 3 levels "EWR","JFK","LGA": 2 1 3 2 2 2 2 3 3 1 ...
    #>  $ carrier: chr  "B6" "B6" "EV" "B6" ...
    #>  $ flight : int  725 507 5708 79 49 71 1806 371 4650 343 ...

    str(fDat4 %>% dfFactorize(ignore = c("origin", "dest")))

    #> Classes 'tbl_df', 'tbl' and 'data.frame':    197272 obs. of  4 variables:
    #>  $ dest   : chr  "BQN" "FLL" "IAD" "MCO" ...
    #>  $ origin : chr  "JFK" "EWR" "LGA" "JFK" ...
    #>  $ carrier: Factor w/ 13 levels "9E","AS","B6",..: 3 3 4 3 3 3 3 3 8 3 ...
    #>  $ flight : int  725 507 5708 79 49 71 1806 371 4650 343 ...

For more information, see `?rsalad::dfFactorize`.

### `dfCount()`: count number of rows per group

Our goal is to see which destinations were the most common, so the next
step is to count how many observations we have for each destination.
This can be achieved using the base R function `table()`:

    head(table(fDat5$dest))

    #> 
    #>  ABQ  ACK  ALB  ATL  AUS  AVL 
    #>  254  265  439 6541 1047  275

However, this is such a common task for me that I was not happy with the
result `table()` gives.  
Specifically:

-   `table()` returns a `table` object rather than the much more uesful
    `data.frame`.  
-   `table()` does not sort the resulting counts.  
-   `table()` performs very slowly on large datasets, especially if the
    data is numeric (see Performance section below).

The `dfCount()` function provides an alternative way to count the data
in a data.frame column in an efficient way, sorts the results, and
returns a data.frame.  
Let's use dfCount to count the number of flights for each destination.

    countDat <- fDat5 %>% dfCount("dest")
    head(countDat)

<table>
<thead>
<tr class="header">
<th align="left">dest</th>
<th align="right">total</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">CLT</td>
<td align="right">14062</td>
</tr>
<tr class="even">
<td align="left">BOS</td>
<td align="right">9739</td>
</tr>
<tr class="odd">
<td align="left">DCA</td>
<td align="right">9701</td>
</tr>
<tr class="even">
<td align="left">RDU</td>
<td align="right">8162</td>
</tr>
<tr class="odd">
<td align="left">FLL</td>
<td align="right">6563</td>
</tr>
<tr class="even">
<td align="left">ATL</td>
<td align="right">6541</td>
</tr>
</tbody>
</table>

Now our count data is in a nice data.frame format that can play nicely
with other data.frames, and can be easily merged/joined into the
original dataset if we wanted to.

Since we only want to see the 50 most common destinations, and the count
data is sorted in descending order, we can now easily retain only the 50
destinations that appeared the most.

    countDat2 <- slice(countDat, 1:50)

For a performance analysis of `dfCount` vs `base::table`, see the
[dfCount performance
vignette](https://github.com/daattali/rsalad/blob/master/vignettes/dfCountPerf.md).

For more information, see `?rsalad::dfCount`.

Visual analysis
---------------

The [`ggExtra`](https://github.com/daattali/ggExtra) package has several
functions that can be used to plot the resulting data more efficiently.
These functions used to be part of this package, but are now in their
own dedicated package.

Other functions
---------------

#### `spinMyR()`: create markdown/HTML reports from R scripts with no hassle

See the [spinMyR vignette](spinMyR.md) for information about this
function.

#### `tolowerfirst()`: convert first character to lower case

`rsalad` provides another function that can sometimes become handy.
`tolowerfirst()` can be used to convert the first letter of a string (or
a vector of strings) into lower case. This can be useful, for example,
when columns of a data.frame do not follow a consistent capitalization
and you would like to lower-case all first letters.

    df <- data.frame(StudentName = character(0), ExamGrade = numeric(0))
    (colnames(df) <- tolowerfirst(colnames(df)))

    #> [1] "studentName" "examGrade"

For more information, see `?rsalad::tolowerfirst`.

#### `setdiffsym()`: symmetric set difference

When wanting to know the difference between two sets, the base R
function `setdiff()` unfortunately does not do exactly what you want
because it is *asymmetric*. This means that the results depend on the
order of the two vectors passed in, which is often not the desired
behaviour. `setdiffsym` implements symmetric set difference, whiich is a
more intuitive set difference.

    setdiff(1:5, 2:4)

    #> [1] 1 5

    setdiff(2:4, 1:5)

    #> integer(0)

    setdiffsym(1:5, 2:4)

    #> [1] 1 5

    setdiffsym(2:4, 1:5)

    #> [1] 1 5

For more information, see `?rsalad::setdiffsym`.

### `%btwn%` operator and `between()`

Determine if a numeric value is between the specified range. By default,
the range is inclusive of the endpoints.

    5 %btwn% c(1, 10)

    #> [1] TRUE

    c(5, 20) %btwn% c(5, 10)

    #> [1]  TRUE FALSE

    rsalad::between(5, c(5, 10))

    #> [1] TRUE

    rsalad::between(5, c(5, 10), inclusive = FALSE)

    #> [1] FALSE

For more information, see `?rsalad::between`.
