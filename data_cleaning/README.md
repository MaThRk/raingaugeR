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


