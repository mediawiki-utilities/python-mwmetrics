source("env.R")
source("util.R")

load_sampled_newly_registered_users = tsv_loader(
	paste(DATA_DIR, "sampled_newly_registered_users.tsv", sep="/"),
	"SAMPLED_NEWLY_REGISTERED_USERS"
)
