# Cleaning the names of the stations

- The stationnames in the files are different from the station names in the excel file

- There are 20 stations where the names do not allow a direct join

- The file names (the actual data) contain underscores while the names in the excel file contain dashes and white spaces


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
- One of the reasons is that in the filesname there are, for good reasons, no spaces.

- One we change underscores for spaces there are only 7 stations, extracted from the files, which have no corresponding station in the excel file

```
# clean the file names and introduce spaces breaks
names_data_new = names_data %>%
  mutate(name = gsub("_", " ", name))

# perform again the set_diff
setdiff(names_data_new, names_xl)
```
- Finally some manual renaming...

```
# do some manual renaming
names_data_final = names_data_new %>% 
  mutate(
    name = str_replace(name, ".*Eisack.*", "Eisack - Sterzing"),
    name = str_replace(name, ".*Antholz.*", "Antholz - Obertal"),
    name = str_replace(name, ".*Eyrs.*", "Eyrs - Laas"),
    name = str_replace(name, ".*Meran.*", "Meran - Gratsch"),
    name = str_replace(name, ".*Oberplanitzing.*", "Oberplanitzing - Kaltern"),
    name = str_replace(name, ".*Seiser Alm.*", "Seiser Alm - Zallinger"),
    name = str_replace(name, ".*St.Walburg.*", "St.Walburg - Zoggler Stausee")
  )

# perform again the set_diff
setdiff(names_data_final, names_xl)

#
# A tibble: 0 x 1
# … with 1 variable: name <chr>

```


