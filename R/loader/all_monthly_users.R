source("env.R")
source("util.R")

load_monthly_users.ptwiki = tsv_loader(
	paste(DATA_DIR, "monthly_users.ptwiki.tsv", sep="/"),
	"MONTHLY_USERS.PTWIKI"
)
load_monthly_users.enwiki = tsv_loader(
	paste(DATA_DIR, "monthly_users.enwiki.tsv", sep="/"),
	"MONTHLY_USERS.ENWIKI"
)
load_monthly_users.frwiki = tsv_loader(
	paste(DATA_DIR, "monthly_users.frwiki.tsv", sep="/"),
	"MONTHLY_USERS.FRWIKI"
)
load_monthly_users.eswiki = tsv_loader(
	paste(DATA_DIR, "monthly_users.eswiki.tsv", sep="/"),
	"MONTHLY_USERS.ESWIKI"
)
load_monthly_users.dewiki = tsv_loader(
	paste(DATA_DIR, "monthly_users.dewiki.tsv", sep="/"),
	"MONTHLY_USERS.DEWIKI"
)

load_all_monthly_users = data_loader(
	function(verbose=T, reload=F){
		rbind(
			load_monthly_users.ptwiki(verbose, reload), 
			load_monthly_users.enwiki(verbose, reload), 
			load_monthly_users.frwiki(verbose, reload), 
			load_monthly_users.eswiki(verbose, reload), 
			load_monthly_users.dewiki(verbose, reload)
		)
	},
	"ALL_MONTHLY_USERS",
	function(d){
		# Remove null registration dates
		d = d[!is.na(registration_month),]
		
		# Convert registration month to a date
		d$registration_month = as.Date(d$registration_month)
		
		# Label account creation
		d$user_type = sapply(
			d$attached,
			function(attached){
				if(attached){
					"attached"
				}else{
					"self-created"
				}
			}
		)
		d
	}
)
