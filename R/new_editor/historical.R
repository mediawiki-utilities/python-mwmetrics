source("loader/monthly_new_wikipedians.R")
source("loader/all_monthly_users.R")

month.new_wikipedians = with(
	load_monthly_new_wikipedians(reload=T),
	rbind(
		data.table(
			month,
			wiki = "ptwiki",
			metric = "new wikipedians",
			n = pt
		),
		data.table(
			month,
			wiki = "enwiki",
			metric = "new wikipedians",
			n = en
		),
		data.table(
			month,
			wiki = "frwiki",
			metric = "new wikipedians",
			n = fr
		),
		data.table(
			month,
			wiki = "eswiki",
			metric = "new wikipedians",
			n = es
		),
		data.table(
			month,
			wiki = "dewiki",
			metric = "new wikipedians",
			n = de
		)
	)
)
month.new_editors = with(
	load_all_monthly_users(reload=T)[user_type=="self-created",],
	rbind(
		data.table(
			month = registration_month,
			wiki,
			metric = "new editors (n=01)",
			n = content_editors_day_1
		),
		data.table(
			month = registration_month,
			wiki,
			metric = "new editors (n=05)",
			n = content_editors_day_5
		),
		data.table(
			month = registration_month,
			wiki,
			metric = "new editors (n=10)",
			n = content_editors_day_10
		)
	)
)

normalized.months = rbind(
	month.new_wikipedians,
	month.new_editors
)

svg("new_editor/plots/new_editors.vs.new_wikipedians.dewiki.svg",
	height=4,
	width=7)
ggplot(
	normalized.months[
		month < "2014-01-01" & 
		wiki == "dewiki",
	],
	aes(
		x=month,
		y=n,
		linetype=metric
	)
) + 
geom_line() + 
theme_bw() + 
scale_linetype_manual("Metric", values=c(2,3,4,1)) +
facet_wrap(~ wiki, ncol=1) + 
theme(
	legend.position = "top"
) + 
scale_x_date("Month") + 
scale_y_continuous("Editors")
dev.off()

svg("new_editor/plots/new_editors.vs.new_wikipedians.ptwiki.svg",
	height=4,
	width=7)
ggplot(
	normalized.months[
		month < "2014-01-01" & 
		wiki == "ptwiki",
	],
	aes(
		x=month,
		y=n,
		linetype=metric
	)
) + 
geom_line() + 
theme_bw() + 
scale_linetype_manual("Metric", values=c(2,3,4,1)) +
facet_wrap(~ wiki, ncol=1) + 
theme(
	legend.position = "top"
) +
scale_x_date("Month") + 
scale_y_continuous("Editors")
dev.off()

svg("new_editor/plots/new_editors.vs.new_wikipedians.eswiki.svg",
	height=4,
	width=7)
ggplot(
	normalized.months[
		month < "2014-01-01" & 
		wiki == "eswiki",
	],
	aes(
		x=month,
		y=n,
		linetype=metric
	)
) + 
geom_line() + 
theme_bw() + 
scale_linetype_manual("Metric", values=c(2,3,4,1)) +
facet_wrap(~ wiki, ncol=1) + 
theme(
	legend.position = "top"
) +
scale_x_date("Month") + 
scale_y_continuous("Editors")
dev.off()

svg("new_editor/plots/new_editors.vs.new_wikipedians.frwiki.svg",
	height=4,
	width=7)
ggplot(
	normalized.months[
		month < "2014-01-01" & 
		wiki == "frwiki",
	],
	aes(
		x=month,
		y=n,
		linetype=metric
	)
) + 
geom_line() + 
theme_bw() + 
scale_linetype_manual("Metric", values=c(2,3,4,1)) + 
facet_wrap(~ wiki, ncol=1) + 
theme(
	legend.position = "top"
) +
scale_x_date("Month") + 
scale_y_continuous("Editors")
dev.off()

svg("new_editor/plots/new_editors.vs.new_wikipedians.enwiki.svg",
	height=4,
	width=7)
ggplot(
	normalized.months[
		month < "2014-01-01" & 
		wiki == "enwiki",
	],
	aes(
		x=month,
		y=n,
		linetype=metric
	)
) + 
geom_line() + 
theme_bw() + 
scale_linetype_manual("Metric", values=c(2,3,4,1)) +
facet_wrap(~ wiki, ncol=1) + 
theme(
	legend.position = "top"
) +
scale_x_date("Month") + 
scale_y_continuous("Editors")
dev.off()

denormalized.months = merge(
	merge(
		normalized.months[
			metric == "new editors (n=01)",
			list(
				month,
				wiki,
				content_editors_day_1 = n
			),
		],
		normalized.months[
			metric == "new editors (n=05)",
			list(
				month,
				wiki,
				content_editors_day_5 = n
			),
		],
		by=c("month", "wiki")
	),
	normalized.months[
		metric == "new wikipedians",
		list(
			month,
			wiki,
			new_wikipedians = n
		),
	],
	by=c("month", "wiki")
)
denormalized.months$factor_n1 = with(
	denormalized.months,
	content_editors_day_1/new_wikipedians
)
denormalized.months$factor_n5 = with(
	denormalized.months,
	content_editors_day_5/new_wikipedians
)

svg("new_editor/plots/new_editors.vs.new_wikipedians.factor.n1.svg",
	height=6,
	width=6)
ggplot(
	denormalized.months[month < "2013-09-01",],
	aes(
		x=month,
		y=factor_n1,
		color=wiki
	)
) + 
geom_line() + 
theme_bw() + 
scale_y_continuous(
	expression(
		paste(
			"Factor ", 
			Delta, 
			": new wikipedian --> new editor"
		)
	)
) + 
scale_x_date("Month") + 
theme(
	legend.position = "top"
)
dev.off()

svg("new_editor/plots/new_editors.vs.new_wikipedians.factor.n5.svg",
	height=6,
	width=6)
ggplot(
	denormalized.months[month < "2013-09-01",],
	aes(
		x=month,
		y=factor_n5,
		color=wiki
	)
) + 
geom_line() + 
theme_bw() + 
scale_y_continuous(
	expression(
		paste(
			"Factor ", 
			Delta, 
			": new wikipedian --> new editor"
		)
	),
	limits=c(0,2)
) + 
scale_x_date("Month") + 
theme(
	legend.position = "top"
)
dev.off()
