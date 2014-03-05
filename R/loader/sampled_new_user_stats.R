source("env.R")
source("util.R")

load_sampled_new_user_stats = tsv_loader(
	paste(DATA_DIR, "sampled_new_user_stats.tsv", sep="/"),
	"SAMPLED_NEW_USER_STATS"
)
