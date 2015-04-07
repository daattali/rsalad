Performance of `dfCount()`
--------------------------

After some basic testing (not extremely thorough), I believe that
`dfCount()` performs much faster than its equivalent `table()` on large
datasets, especially when the data is numeric. The analysis was done
with the `microbenchmark` package to compare the two functions on a few
different datasets.

    library(rsalad)
    library(dplyr)
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
        times = 10
      )

<table>
<thead>
<tr class="header">
<th align="left">expr</th>
<th align="right">min</th>
<th align="right">mean</th>
<th align="right">median</th>
<th align="right">max</th>
<th align="right">neval</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">dfCount(fDat, &quot;day&quot;)</td>
<td align="right">17.592022</td>
<td align="right">26.477759</td>
<td align="right">23.361650</td>
<td align="right">47.942357</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">table(fDat$day)</td>
<td align="right">124.502858</td>
<td align="right">176.668992</td>
<td align="right">178.783502</td>
<td align="right">220.172421</td>
<td align="right">10</td>
</tr>
<tr class="odd">
<td align="left">dfCount(fDat, &quot;dest&quot;)</td>
<td align="right">20.467399</td>
<td align="right">27.618526</td>
<td align="right">26.889988</td>
<td align="right">35.597483</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">table(fDat$dest)</td>
<td align="right">28.812769</td>
<td align="right">47.353390</td>
<td align="right">46.714503</td>
<td align="right">64.513612</td>
<td align="right">10</td>
</tr>
<tr class="odd">
<td align="left">dfCount(largeIntDat, &quot;col&quot;)</td>
<td align="right">142.112473</td>
<td align="right">179.890952</td>
<td align="right">172.354499</td>
<td align="right">269.982579</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">table(largeIntDat$col)</td>
<td align="right">1072.657027</td>
<td align="right">1564.270936</td>
<td align="right">1489.253169</td>
<td align="right">2379.238431</td>
<td align="right">10</td>
</tr>
<tr class="odd">
<td align="left">dfCount(largeCharDat, &quot;col&quot;)</td>
<td align="right">109.545406</td>
<td align="right">182.959669</td>
<td align="right">202.074962</td>
<td align="right">244.528265</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">table(largeCharDat$col)</td>
<td align="right">200.472889</td>
<td align="right">268.210916</td>
<td align="right">278.629599</td>
<td align="right">330.212632</td>
<td align="right">10</td>
</tr>
<tr class="odd">
<td align="left">dfCount(smallDat, &quot;col&quot;)</td>
<td align="right">2.376538</td>
<td align="right">3.811807</td>
<td align="right">3.696206</td>
<td align="right">5.809396</td>
<td align="right">10</td>
</tr>
<tr class="even">
<td align="left">table(smallDat$col)</td>
<td align="right">1.081611</td>
<td align="right">1.798311</td>
<td align="right">1.881731</td>
<td align="right">2.662426</td>
<td align="right">10</td>
</tr>
</tbody>
</table>

Every pair of rows corresponds to counting the same data using
`dfCount()` vs `table()`. The results show that:

-   `dfCount()` was faster in all 4 large datasets
-   `dfCount()` was an order of magnitude faster in both cases when the
    data was numeric
-   `dfCount()` was slower on very the small dataset

After performing this analysis, I've realized that the likely cause of
the speed boost is due to `dfCount()` relying on `dplyr`. After making
that realization, I found that `dplyr` also has a `count()` function,
which performs equally fast as `dfCount()`, which further supports the
hypothesis that the speed boost was thanks to `dplyr`. However, I still
want to include this function in the package because it took a lot of
hard work (and documentation!), and it also has a very differences from
`dplyr::count()`. For example, `dplyr::count()` does not sort by
default, which I find to be the less desired behaviour, and
`dplyr::count()` does not have a standard-evaluation version.
