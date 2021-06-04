# RaingaugeR

> Functions to work with Wiski raingauge-data

## The data

- There is one excel file which lists all the information about the 66 individual stations. It contains information about the easting, the northing, the temporal resolution (5 or 10 minutes)...

```
 name           name_2         elev   lat  long easting northing par   time_res_min start      end      
  <chr>          <chr>         <dbl> <dbl> <dbl>   <dbl>    <dbl> <chr>        <dbl> <chr>      <chr>    
1 Melag          Melago         1915  46.8  10.7 626323  5188431  N                5 1998-01-0… 2020-11-…
2 St.Valentin a… S.Valentino …  1499  46.8  10.5 616720  5181393  N                5 1981-01-1… 2020-11-…
3 Marienberg     Monte Maria    1310  46.7  10.5 616288. 5173583. N                5 2009-07-2… 2020-11-…
4 Taufers        Tubre          1235  46.6  10.5 611860  5165895  N                5 1989-05-1… 2020-11-…
5 Madritsch      Madriccio      2825  46.5  10.6 623901  5150187. N                5 2008-11-2… 2020-11-…
6 Sulden         Solda          1905  46.5  10.6 622375  5152632. N                5 1987-01-0… 2020-11-…
```

- Then There is the actual rainfall data which is stores in `.csv`-files with the name of the station in each filename

```
Antholz_Obertal.txt
Auer.txt
Bozen.txt
Branzoll.txt
Brixen_Vahrn.txt
Bruneck.txt
Corvara_im_Gadertal.txt
Deutschnofen.txt
Eisack_Sterzing.txt
Eyrs_Laas.txt
Gantkofel.txt
Gargazon.txt
Grasstein.txt
Hintermartell.txt
...
```

# How to work with the data

1. Get a list of all the stations

- You can get a list of all the stations or via 2 ways as each stationname is in the filename for the data, but also in the excel-sheet with the additional information




