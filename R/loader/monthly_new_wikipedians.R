source("env.R")
source("util.R")

load_monthly_new_wikipedians = data_loader(
	function(verbose=T, reload=F){
		data.table(
			read.table(
				paste(DATA_DIR, "WikipediansNew.csv", sep="/"),
				header=T,
				sep=","
			)
		)
	},
	"MONTHLY_NEW_WIKIPEDIANS",
	function(d){
		d$month = as.Date(
			paste(
				substring(d$date, 7, 10),
				substring(d$date, 1, 2),
				"01",
				sep="-"
			)
		)
		d
	}
)
