source("loader/all_monthly_users.R")

months = load_all_monthly_users(reload=T)

# Filter partial month
months = months[registration_month < "2014-01-01" & registration_month >= "2006-01-01",]

svg("new_editor/plots/wiki_metrics.comparison.content_vs_all.svg",
	height=4,
	width=6)
ggplot(
	months[user_type == "self-created",],
	aes(
		x = registration_month, 
		y = content_editors_day_1/new_editors_day_1,
		color = wiki
	)
) + 
scale_y_continuous(
	"Proportion of content editors",
	limits=c(0, 1)
) +
scale_x_date("Registration month") + 
geom_line() + 
theme_bw()
dev.off()

svg("new_editor/plots/wiki_metrics.comparison.t.svg",
	height=4,
	width=6)
ggplot(
	months[user_type == "self-created",],
	aes(
		x = registration_month, 
		y = new_editors_day_1/new_editors_week_1,
		color = wiki
	)
) + 
scale_y_continuous(
	"Proportion of 24h editors",
	limits=c(0, 1)
) +
scale_x_date("Registration month") + 
geom_line() + 
theme_bw()
dev.off()

svg("new_editor/plots/wiki_metrics.comparison.n.svg",
	height=4,
	width=6)
ggplot(
	months[user_type == "self-created",],
	aes(
		x = registration_month, 
		y = new_editors_week_10/new_editors_week_1,
		color = wiki
	)
) + 
scale_y_continuous(
	"Proportion of 10 edit editors",
	limits=c(0, .25)
) +
scale_x_date("Registration month") + 
geom_line() + 
theme_bw()
dev.off()
