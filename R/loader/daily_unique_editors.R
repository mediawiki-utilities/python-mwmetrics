source("env.R")
source("util.R")

load_daily_unique_editors = tsv_loader(
    paste(DATA_DIR, "historic_daily_unique_editors.en_de_fr_it_es_wikidata.tsv", sep="/"),
    "DAILY_UNIQUE_EDITORS",
    function(dt){
        dt$date = as.Date(as.character(dt$day),
                          origin="1970-01-01",
                          format="%Y%m%d")
        
        dt
    }
)
