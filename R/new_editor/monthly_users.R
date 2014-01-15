source("loader/all_monthly_users.R")

months = load_all_monthly_users(reload=T)

# Filter partial month
months = months[registration_month < "2014-01-01",]

normalized.months = with(months, 
	rbind(
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=NA,
				t=NA,
				edits=0,
				n=registered_users,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=F,
				t="24 hours",
				edits=1,
				n=new_editors_day_1,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=F,
				t="24 hours",
				edits=5,
				n=new_editors_day_5,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=F,
				t="24 hours",
				edits=10,
				n=new_editors_day_10,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=T,
				t="24 hours",
				edits=1,
				n=content_editors_day_1,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=T,
				t="24 hours",
				edits=5,
				n=content_editors_day_5,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=T,
				t="24 hours",
				edits=10,
				n=content_editors_day_10,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=F,
				t="1 week",
				edits=1,
				n=new_editors_week_1,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=F,
				t="1 week",
				edits=5,
				n=new_editors_week_5,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=F,
				t="1 week",
				edits=10,
				n=new_editors_week_10,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=T,
				t="1 week",
				edits=1,
				n=content_editors_week_1,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=T,
				t="1 week",
				edits=5,
				n=content_editors_week_5,
				total=registered_users
			)
		],
		months[,
			list(
				wiki,
				registration_month,
				user_type,
				main_only=T,
				t="1 week",
				edits=10,
				n=content_editors_week_10,
				total=registered_users
			)
		]
	)
)

normalized.months$prop = with(
	normalized.months,
	n/total
)

plot_editor_counts = function(data){
	g = ggplot(
		data,
		aes(
			x=registration_month,
			y=n,
			color=t,
			linetype=main_only
		)
	) + 
	geom_line() + 
	theme_bw() + 
	scale_x_date("Registration month") + 
	scale_y_continuous("Editors") + 
	scale_linetype_discrete("Main only")
	
	print(g)
}


svg("new_editor/plots/monthly_editor_counts.1_edit.ptwiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 1 & 
		wiki == "ptwiki",
	]
)
dev.off()

svg("new_editor/plots/monthly_editor_counts.5_edit.ptwiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 5 & 
		wiki == "ptwiki",
	]
)
dev.off()

svg("new_editor/plots/monthly_editor_counts.10_edit.ptwiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 10 & 
		wiki == "ptwiki",
	]
)
dev.off()


svg("new_editor/plots/monthly_editor_counts.1_edit.enwiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 1 & 
		wiki == "enwiki",
	]
)
dev.off()

svg("new_editor/plots/monthly_editor_counts.5_edit.enwiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 5 & 
		wiki == "enwiki",
	]
)
dev.off()

svg("new_editor/plots/monthly_editor_counts.10_edit.enwiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 10 & 
		wiki == "enwiki",
	]
)
dev.off()


svg("new_editor/plots/monthly_editor_counts.1_edit.dewiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 1 & 
		wiki == "dewiki",
	]
)
dev.off()

svg("new_editor/plots/monthly_editor_counts.5_edit.dewiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 5 & 
		wiki == "dewiki",
	]
)
dev.off()

svg("new_editor/plots/monthly_editor_counts.10_edit.dewiki.svg",
	height=4,
	width=6)
plot_editor_counts(
	normalized.months[
		user_type=="self-created" & 
		edits == 10 & 
		wiki == "dewiki",
	]
)
dev.off()


svg("new_editor/plots/monthly_editor_prop.1_edit.svg",
	height=5,
	width=12)
ggplot(
	normalized.months[user_type=="self-created" & edits == 1,],
	aes(
		x=registration_month,
		y=prop,
		color=t,
		linetype=main_only
	)
) + 
geom_line() + 
theme_bw() + 
scale_x_date("Registration month") + 
scale_y_continuous("Proportion of \"Newly registered users\"") + 
scale_linetype_discrete("Main only") + 
facet_wrap(~ wiki)
dev.off()
