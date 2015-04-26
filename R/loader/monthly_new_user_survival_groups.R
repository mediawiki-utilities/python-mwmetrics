source("env.R")
source("util.R")

load_monthly_new_user_survival_groups = tsv_loader(
	paste(DATA_DIR, "monthly_new_user_survival_groups.tsv", sep="/"),
	"MONTHLY_NEW_USER_SURVIVAL_GROUPS"
)
