source("loader/monthly_sampled.newly_registered_users.R")
source("loader/monthly_sampled.new_user_stats.R")


users = load_monthly_sampled.newly_registered_users(reload=T)
users$user_registration = as.character(users$registration_approx)
users$registration_month = as.Date(
	paste(
		substring(users$user_registration, 1, 4),
		substring(users$user_registration, 5, 6),
		"01",
		sep="-"
	)
)
stats = load_monthly_sampled.new_user_stats(reload=T)

merged_stats = merge(
	users,
	stats,
	by="user_id"
)

normalized.monthly.productive = rbind(
	merged_stats[,
		list(
			users = length(user_id),
			editors = sum(day_main_revisions >= 1),
			t = "day",
			k = sum(day_main_revisions >= 1 & day_main_revisions > day_reverted_main_revisions)
		),
		by=registration_month
	],
	merged_stats[,
		list(
			users = length(user_id),
			editors = sum(day_main_revisions >= 1),
			t = "week",
			k = sum(day_main_revisions >= 1 & week_main_revisions > week_reverted_main_revisions)
		),
		by=registration_month
	]
)

svg("productive_new_editor/plots/exploration/monthly.productive_editors.per_newly_registered_user.enwiki.svg",
	height=4,
	width=12)
ggplot(
	normalized.monthly.productive,
	aes(
		x=registration_month,
		y=k/users,
		color=t
	)
) + 
geom_line() + 
scale_y_continuous(
	"Productive prop (newly registered users)"
) + 
theme_bw()
dev.off()

svg("productive_new_editor/plots/exploration/monthly.productive_editors.per_new_editor.enwiki.svg",
	height=4,
	width=12)
ggplot(
	normalized.monthly.productive,
	aes(
		x=registration_month,
		y=k/editors,
		color=t
	)
) + 
geom_line() + 
scale_y_continuous(
	"Productive prop (new editors)"
) + 
theme_bw()
dev.off()

svg("productive_new_editor/plots/exploration/monthly.new_editors.per_newly_registered_user.enwiki.svg",
	height=4,
	width=12)
ggplot(
	normalized.monthly.productive[t == "day",],
	aes(
		x=registration_month,
		y=editors/users
	)
) + 
geom_line() + 
scale_y_continuous(
	"Editing prop (newly registered editors)"
) + 
theme_bw()
dev.off()

svg("productive_new_editor/plots/exploration/monthly.productive_new_editor.funnel.enwiki.svg",
	height=4,
	width=12)
ggplot(
	rbind(
		normalized.monthly.productive[
			t == "day",
			list(
				registration_month,
				prop = editors/users,
				group = "New editors/Newly registered user"
			),
		],
		normalized.monthly.productive[
			t == "day",
			list(
				registration_month,
				prop = k/editors,
				group = "Productive new editors/New editor"
			)
		]
	),
	aes(
		x=registration_month,
		y=prop
	)
) + 
geom_bar(stat="identity") + 
facet_wrap(~ group, ncol=1)
dev.off()

