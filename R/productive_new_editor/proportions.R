source("loader/sampled_newly_registered_users.R")
source("loader/sampled_new_user_stats.R")

users = load_sampled_newly_registered_users(reload=T)
stats = load_sampled_new_user_stats(reload=T)
user_stats = merge(
	users,
	stats,
	by=c("wiki_db", "user_id")
)
user_stats$registration_month = as.Date(
	paste(
		substring(user_stats$registration_approx, 1, 4),
		substring(user_stats$registration_approx, 5, 6),
		"01",
		sep="-"
	)
)
user_stats$new_editor = with(
	user_stats,
	day_main_revisions > 0
)
user_stats$day_productive_1 = with(
	user_stats,
	new_editor & day_main_revisions > day_reverted_main_revisions
)
user_stats$day_productive_5 = with(
	user_stats,
	new_editor & day_main_revisions - day_reverted_main_revisions >= 5
)
user_stats$week_productive_1 = with(
	user_stats,
	new_editor & week_main_revisions > week_reverted_main_revisions
)
user_stats$week_productive_5 = with(
	user_stats,
	new_editor & week_main_revisions - week_reverted_main_revisions >= 5
)


normalized.monthly.productive = rbind(
	user_stats[,
		list(
			newly_registered_users = length(user_id),
			new_editors = sum(new_editor),
			t = "day",
			n = "1",
			productive_new_editors = sum(day_productive_1)
		),
		by=list(wiki_db, registration_month)
	],
	user_stats[,
		list(
			newly_registered_users = length(user_id),
			new_editors = sum(new_editor),
			t = "day",
			n = "5",
			productive_new_editors = sum(day_productive_5)
		),
		by=list(wiki_db, registration_month)
	],
	user_stats[,
		list(
			newly_registered_users = length(user_id),
			new_editors = sum(new_editor),
			t = "week",
			n = "1",
			productive_new_editors = sum(week_productive_1)
		),
		by=list(wiki_db, registration_month)
	],
	user_stats[,
		list(
			newly_registered_users = length(user_id),
			new_editors = sum(new_editor),
			t = "week",
			n = "5",
			productive_new_editors = sum(week_productive_5)
		),
		by=list(wiki_db, registration_month)
	]
)

plot_productive_new_editors_per_newly_registered_user = function(dt){
	ggplot(
		dt,
		aes(
			x=registration_month,
			y=productive_new_editors/newly_registered_users,
			color=t,
			linetype=n
		)
	) + 
	geom_line() +
	labs(title="Productive new editors per newly registered user") + 
	scale_y_continuous(
		"Proportion",
		limits=c(0, .7)
	) + 
	scale_x_date(
		"Registration month"
	) + 
	theme_bw()
}


plot_productive_new_editors_per_new_editor = function(dt){
	ggplot(
		dt,
		aes(
			x=registration_month,
			y=productive_new_editors/new_editors,
			color=t,
			linetype=n
		)
	) + 
	geom_line() +
	labs(title="Productive new editors per new editor") + 
	scale_y_continuous(
		"Proportion",
		limits=c(.05, 1.1)
	) + 
	scale_x_date(
		"Registration month"
	) + 
	theme_bw()
}

for(wiki in unique(user_stats$wiki_db)){
	svg(
		paste(
			"productive_new_editor/plots/proportions/monthly",
			"productive_new_editors.per_newly_registered_user",
			wiki, "svg", sep="."
		),
		height=5,
		width=7)
	print(plot_productive_new_editors_per_newly_registered_user(
		normalized.monthly.productive[wiki_db == wiki,]
	))
	dev.off()
	
	svg(
		paste(
			"productive_new_editor/plots/proportions/monthly",
			"productive_new_editors.per_new_editor",
			wiki, "svg", sep="."
		),
		height=5,
		width=7)
	print(plot_productive_new_editors_per_new_editor(
		normalized.monthly.productive[wiki_db == wiki,]
	))
	dev.off()
}


	
svg(
	paste(
		"productive_new_editor/plots/proportions/monthly",
		"productive_new_editors.t_factor.svg", sep="."
	),
	height=9,
	width=7)
ggplot(
	rbind(
		user_stats[,
			list(
				t_factor = sum(day_productive_1) /  # Dividing by new_editors or newly_registered_users  
						   sum(week_productive_1),  # here isn't necessary
				users = sum(week_productive_1),
				n = "n = 1"
			),
			list(registration_month, wiki_db)
		],
		user_stats[,
			list(
				t_factor = sum(day_productive_5) /  # Dividing by new_editors or newly_registered_users  
						   sum(week_productive_5),  # here isn't necessary
				users = sum(week_productive_5),
				n = "n = 5"
			),
			list(registration_month, wiki_db)
		]
	)[users >= 10,],
	aes(
		x=registration_month,
		y=t_factor,
		color=wiki_db
	)
) + 
geom_line() + 
scale_y_continuous(
	"Productive proportion factor (day/week)",
	limits=c(.3, 1.1)
) + 
scale_x_date(
	"Registration month"
) + 
theme_bw() + 
facet_wrap(~ n, ncol=1)
dev.off()

svg(
	paste(
		"productive_new_editor/plots/proportions/monthly",
		"productive_new_editors.n_factor.svg", sep="."
	),
	height=9,
	width=7)
ggplot(
	rbind(
		user_stats[,
			list(
				n_factor = sum(day_productive_5) /  # Dividing by new_editors or newly_registered_users  
						   sum(day_productive_1),   # here isn't necessary
				users = length(user_id),
				t = "t = day"
			),
			list(registration_month, wiki_db)
		],
		user_stats[,
			list(
				n_factor = sum(week_productive_5) /  # Dividing by new_editors or newly_registered_users  
						   sum(week_productive_1),   # here isn't necessary
				users = sum(week_productive_1),
				t = "t = week"
			),
			list(registration_month, wiki_db)
		]
	)[users >= 10,],
	aes(
		x=registration_month,
		y=n_factor,
		color=wiki_db
	)
) + 
geom_line() + 
scale_y_continuous(
	"Productive proportion factor (5 edits / 1 edit)",
	limits=c(0, .6)
) + 
scale_x_date(
	"Registration month"
) + 
theme_bw() +
facet_wrap(~ t, ncol=1)
dev.off()
