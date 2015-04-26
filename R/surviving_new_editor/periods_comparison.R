source("loader/monthly_new_user_survival_groups.R")
source("loader/monthly_new_user_survival.R")

monthly_survival = merge(
	load_monthly_new_user_survival_groups(reload=T),
	load_monthly_new_user_survival(reload=T),
	by=c("wiki_db","registration_month","registration_type")
)
monthly_survival$registration_month = as.Date(monthly_survival$registration_month)

populated.monthly_survival = monthly_survival[new_editors_day_1 >= 100,]

normalized.counts = data.table()
for(trial_months in 1:6){
	for(survival_months in 1:6){
		column_name = paste("trial", trial_months, "survival", survival_months, sep="_")
		normalized.counts = with(
			populated.monthly_survival,
			rbind(
				normalized.counts,
				data.table(
					wiki_db, registration_month, registration_type,
					trial_months,
					survival_months,
					k = populated.monthly_survival[[column_name]],
					n = new_editors_day_1
				)
			)
		)
	}
}

# Trim months
last_month = max(populated.monthly_survival$registration_month)
filtered.normalized.counts = normalized.counts[
	registration_month < last_month - (trial_months+survival_months)*30,
]
filtered.normalized.counts$db_trials = with(
	filtered.normalized.counts,
	paste("trial months = ", trial_months, sep="")
)

svg("surviving_new_editor/plots/periods_comparison/survival_prop.by_trial_and_survival_months.enwiki.svg",
	height=5,
	width=12)
ggplot(
	filtered.normalized.counts[
		wiki_db == "enwiki" &
		registration_type == "self" & 
		registration_month >= "2006-01-01",
	],
	aes(
		x=registration_month,
		y=k/n,
		color=factor(survival_months),
		fill=factor(survival_months)
	)
) + 
facet_wrap(~ db_trials, nrow=1) + 
geom_line() + 
theme_bw() + 
scale_color_discrete("Survival months") + 
scale_x_date("Registration month") + 
scale_y_continuous("Surviving proportion") + 
theme(
	axis.text.x = element_text(angle = 45, hjust = 1)
)
dev.off()

svg("surviving_new_editor/plots/periods_comparison/survival_prop.by_trial_and_survival_months.dewiki.svg",
	height=5,
	width=12)
ggplot(
	filtered.normalized.counts[
		wiki_db == "dewiki" &
		registration_type == "self" & 
		registration_month >= "2006-01-01",
	],
	aes(
		x=registration_month,
		y=k/n,
		color=factor(survival_months),
		fill=factor(survival_months)
	)
) + 
facet_wrap(~ db_trials, nrow=1) + 
geom_line() + 
theme_bw() + 
scale_color_discrete("Survival months") + 
scale_x_date("Registration month") + 
scale_y_continuous("Surviving proportion") + 
theme(
	axis.text.x = element_text(angle = 45, hjust = 1)
)
dev.off()

trial_factor = rbind(
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 6,
			survival_months = 3,
			factor = trial_6_survival_3/trial_3_survival_3
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 5,
			survival_months = 3,
			factor = trial_5_survival_3/trial_3_survival_3
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 4,
			survival_months = 3,
			factor = trial_4_survival_3/trial_3_survival_3
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 3,
			survival_months = 3,
			factor = 1
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 2,
			survival_months = 3,
			factor = trial_2_survival_3/trial_3_survival_3
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 1,
			survival_months = 3,
			factor = trial_1_survival_3/trial_3_survival_3
		)
	]
)

svg("surviving_new_editor/plots/periods_comparison/survival_prop.trial_factor.svg",
	height=5,
	width=14)
ggplot(
	trial_factor[
		registration_type == "self" & 
		registration_month < last_month - (trial_months+survival_months+1)*30,],
	aes(
		x=registration_month,
		y=factor,
		color = factor(trial_months)
	)
) + 
facet_wrap(~ wiki_db, nrow=1) +
geom_line() + 
theme_bw() + 
scale_y_continuous("Factor (trial months = 3)", limits=c(0, 2)) + 
scale_x_date("Registration month")
dev.off()

survival_factor = rbind(
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 3,
			survival_months = 6,
			factor = trial_3_survival_6/trial_3_survival_3
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 3,
			survival_months = 5,
			factor = trial_3_survival_5/trial_3_survival_3
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 3,
			survival_months = 4,
			factor = trial_3_survival_4/trial_3_survival_3
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 3,
			survival_months = 3,
			factor = 1
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 3,
			survival_months = 2,
			factor = trial_3_survival_2/trial_3_survival_3
		)
	],
	populated.monthly_survival[,
		list(
			wiki_db, registration_month, registration_type,
			trial_months = 3,
			survival_months = 1,
			factor = trial_3_survival_1/trial_3_survival_3
		)
	]
)


svg("surviving_new_editor/plots/periods_comparison/survival_prop.survival_factor.svg",
	height=5,
	width=14)
ggplot(
	survival_factor[
		registration_type == "self" & 
		registration_month < last_month - (trial_months+survival_months+1)*30,],
	aes(
		x=registration_month,
		y=factor,
		color = factor(survival_months)
	)
) + 
facet_wrap(~ wiki_db) +
geom_line() + 
theme_bw() + 
scale_y_continuous("Factor (survival months = 3)", limits=c(0, 2)) + 
scale_x_date("Registration month")
dev.off()
