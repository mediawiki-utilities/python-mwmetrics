source("env.R")
source("util.R")

load_monthly_new_user_activity = tsv_loader(
	paste(DATA_DIR, "monthly_new_user_activity.tsv", sep="/"),
	"MONTHLY_NEW_USER_ACTIVITY"
)
