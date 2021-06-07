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
## Get the station-names

- You can get the station-names from the files. This will return a dataframe with two columns. One being the actual name from the file, the other is the name of the station in the excel file

```
# get the station naames of the files
station_names_files = read_rainfall(only.names = T)
```

- We can also get the station-names from the excel file by calling:

```
station_names_xl = get_station_information()[["name"]]
```

This will return the same names as in the second column of the returned dataframe of `station_names_files`


## Get the rainfall for one station

- If you only are interested in the rainfall for one station you can use the function `read_rainfall` and specify the name of the station. It must only match more or less. If it does not match 100 % it will provide a suggestion

```
station = "bozn"
rain = read_rainfall(station=station)
# Did you meant: Bozen[Yy|Nn] 
head(rain)

        date     hour precip n_measure
1 1981-01-03 01:00:00     NA        12
2 1981-01-03 02:00:00     NA        12
3 1981-01-03 03:00:00     NA        12
4 1981-01-03 04:00:00     NA        12
5 1981-01-03 05:00:00     NA        12
6 1981-01-03 06:00:00     NA        12

```










