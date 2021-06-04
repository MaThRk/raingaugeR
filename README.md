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

- The stationnames in the files are different from the station names in the excel file

- There are 20 stations where the names do not allow a direct join


```

# from data
names_data = read_rainfall(only.names = T) %>% as.data.frame() 
names(names_data) = c("name")

# from excel
names_xl = get_station_information() %>% dplyr::select(matches("^name$"))
setdiff(names_data, names_xl)

# The names from the files which are not in the excel-sheet

# A tibble: 20 x 1
   name                      
   <chr>                     
 1 Antholz_Obertal           
 2 Brixen_Vahrn              
 3 Corvara_im_Gadertal       
 4 Eisack_Sterzing           
 5 Eyrs_Laas                 
 6 Meran_Gratsch             
 7 Obereggen_Absam           
 8 Oberplanitzing_Kaltern    
 9 Piz_la_Ila                
10 Rein_in_Taufers           
11 Seiser Alm_Zallinger      
12 St.Jakob_in_Pfitsch       
13 St.Magdalena_in_Gsies     
14 St.Martin_in_Passeier     
15 St.Martin_in_Thurn        
16 St.Valentin_auf_der_Haide 
17 St.Veit_in_Prags          
18 St.Walburg_Zoggler Stausee
19 Sterzing_Flughafen        
20 Völs_am_Schlern 

```
- One of the reasons is that there are


