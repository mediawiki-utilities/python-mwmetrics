source("loader/monthly_new_user_survival.R")

monthly_survival = load_monthly_new_user_survival(reload=T)
monthly_survival$registration_month = as.Date(monthly_survival$registration_month)

normalized.stats = rbind(
	monthly_survival[
		new_editors_day_1 > 100 & 
		registration_month < max(registration_month) - 28,
		list(
			survival_period = "3 to 4 weeks",
			wiki_db,
			registration_month,
			registration_type,
			edits = 1,
			n = new_editors_day_1,
			k = surviving_3_to_4_weeks_1
		),
	],
	monthly_survival[
		new_editors_day_1 > 100 & 
		registration_month < max(registration_month) - 28,
		list(
			survival_period = "3 to 4 weeks",
			wiki_db,
			registration_month,
			registration_type,
			edits = 5,
			n = new_editors_day_1,
			k = surviving_3_to_4_weeks_5
		),
	],
	monthly_survival[
		new_editors_day_1 > 100 & 
		registration_month < max(registration_month) - 30*2,
		list(
			survival_period = "1 to 2 months",
			wiki_db,
			registration_month,
			registration_type,
			edits = 1,
			n = new_editors_day_1,
			k = surviving_1_to_2_months_1
		),
	],
	monthly_survival[
		new_editors_day_1 > 100 & 
		registration_month < max(registration_month) - 30*2,
		list(
			survival_period = "1 to 2 months",
			wiki_db,
			registration_month,
			registration_type,
			edits = 5,
			n = new_editors_day_1,
			k = surviving_1_to_2_months_5
		),
	],
	monthly_survival[
		new_editors_day_1 > 100 & 
		registration_month < max(registration_month) - 30*6,
		list(
			survival_period = "2 to 6 months",
			wiki_db,
			registration_month,
			registration_type,
			edits = 1,
			n = new_editors_day_1,
			k = surviving_2_to_6_months_1
		),
	],
	monthly_survival[
		new_editors_day_1 > 100 & 
		registration_month < max(registration_month) - 30*6,
		list(
			survival_period = "2 to 6 months",
			wiki_db,
			registration_month,
			registration_type,
			edits = 5,
			n = new_editors_day_1,
			k = surviving_2_to_6_months_5
		),
	]
)
normalized.stats$prop = with(
	normalized.stats,
	k/n
)
normalized.stats$survival_period = factor(
	normalized.stats$survival_period,
	levels=c("3 to 4 weeks", "1 to 2 months", "2 to 6 months", "1 to 2 years", "1 year + 1 month")
)

svg("surviving_new_editor/plots/per_wiki/surviving_prop.1_edit.by_wiki.by_survival_period.svg",
	height=5,
	width=7)
ggplot(
	normalized.stats[
		registration_type == "self" & 
		wiki_db == "enwiki" & 
		edits == 1,
	],
	aes(
		x=registration_month,
		y=prop,
		color=survival_period
	)
) + 
geom_line() + 
scale_y_continuous("Proportion of surviving new editors") + 
scale_x_date("Month of registration") + 
theme_bw()
dev.off()

svg("surviving_new_editor/plots/per_wiki/surviving_prop.5_edit.by_wiki.by_survival_period.svg",
	height=5,
	width=7)
ggplot(
	normalized.stats[
		registration_type == "self" & 
		wiki_db == "enwiki" & 
		edits == 5,
	],
	aes(
		x=registration_month,
		y=prop,
		color=survival_period
	)
) + 
geom_line() + 
scale_y_continuous("Proportion of surviving new editors") + 
scale_x_date("Month of registration") + 
theme_bw()
dev.off()
