source("loader/daily_unique_editors.R")

daily_unique_editors = load_daily_unique_editors(reload=T)

normalized.due = rbind(
    daily_unique_editors[,
        list(
            wiki,
            date,
            n = 1,
            bot_filter = F,
            archive_included = T,
            count = revs_gte_1
        ),
    ],
    daily_unique_editors[,
        list(
            wiki,
            date,
            n = 1,
            bot_filter = T,
            archive_included = T,
            count = revs_gte_1_no_bot
        ),
    ],
    daily_unique_editors[,
        list(
            wiki,
            date,
            n = 1,
            bot_filter = F,
            archive_included = F,
            count = revs_no_arch_gte_1
        ),
    ],
    daily_unique_editors[,
        list(
            wiki,
            date,
            n = 1,
            bot_filter = T,
            archive_included = F,
            count = revs_no_arch_gte_1_no_bot
        ),
    ],
    daily_unique_editors[,
        list(
            wiki,
            date,
            n = 5,
            bot_filter = F,
            archive_included = T,
            count = revs_gte_5
        ),
    ],
    daily_unique_editors[,
        list(
            wiki,
            date,
            n = 5,
            bot_filter = T,
            archive_included = T,
            count = revs_gte_5_no_bot
        ),
    ],
    daily_unique_editors[,
        list(
            wiki,
            date,
            n = 5,
            bot_filter = F,
            archive_included = F,
            count = revs_no_arch_gte_5
        ),
    ],
    daily_unique_editors[,
        list(
            wiki,
            date,
            n = 5,
            bot_filter = T,
            archive_included = F,
            count = revs_no_arch_gte_5_no_bot
        ),
    ]
)

svg("unique_editors/plots/unique_editors.by_filters.enwiki.svg",
    height=4, width=8)
ggplot(
    normalized.due[wiki == "enwiki",],
    aes(
        x=date,
        y=count,
        linetype=bot_filter,
        color=archive_included
    )
) +
facet_wrap(~ n) +
geom_point(alpha=0.2, size=0.1) +
geom_smooth(fill=NA) +
theme_bw() +
scale_y_continuous("Unique editors (daily)\n") +
scale_x_date("\nDate")
dev.off()

svg("unique_editors/plots/unique_editors.by_filters.dewiki.svg",
    height=4, width=8)
ggplot(
    normalized.due[wiki == "dewiki",],
    aes(
        x=date,
        y=count,
        linetype=bot_filter,
        color=archive_included
    )
) +
facet_wrap(~ n) +
geom_point(alpha=0.2, size=0.1) +
geom_smooth(fill=NA) +
theme_bw() +
scale_y_continuous("Unique editors (daily)\n") +
scale_x_date("\nDate")
dev.off()

svg("unique_editors/plots/unique_editors.by_filters.itwiki.svg",
    height=4, width=8)
ggplot(
    normalized.due[wiki == "itwiki",],
    aes(
        x=date,
        y=count,
        linetype=bot_filter,
        color=archive_included
    )
) +
facet_wrap(~ n) +
geom_point(alpha=0.2, size=0.1) +
geom_smooth(fill=NA) +
theme_bw() +
scale_y_continuous("Unique editors (daily)\n") +
scale_x_date("\nDate")
dev.off()

svg("unique_editors/plots/unique_editors.by_filters.frwiki.svg",
    height=4, width=8)
ggplot(
    normalized.due[wiki == "frwiki",],
    aes(
        x=date,
        y=count,
        linetype=bot_filter,
        color=archive_included
    )
) +
facet_wrap(~ n) +
geom_point(alpha=0.2, size=0.1) +
geom_smooth(fill=NA) +
theme_bw() +
scale_y_continuous("Unique editors (daily)\n") +
scale_x_date("\nDate")
dev.off()

svg("unique_editors/plots/unique_editors.by_filters.eswiki.svg",
    height=4, width=8)
ggplot(
    normalized.due[wiki == "eswiki",],
    aes(
        x=date,
        y=count,
        linetype=bot_filter,
        color=archive_included
    )
) +
facet_wrap(~ n) +
geom_point(alpha=0.2, size=0.1) +
geom_smooth(fill=NA) +
theme_bw() +
scale_y_continuous("Unique editors (daily)\n") +
scale_x_date("\nDate")
dev.off()

svg("unique_editors/plots/unique_editors.by_filters.wikidatawiki.svg",
    height=4, width=8)
ggplot(
    normalized.due[wiki == "wikidatawiki",],
    aes(
        x=date,
        y=count,
        linetype=bot_filter,
        color=archive_included
    )
) +
facet_wrap(~ n) +
geom_point(alpha=0.2, size=0.1) +
geom_smooth(fill=NA) +
theme_bw() +
scale_y_continuous("Unique editors (daily)\n") +
scale_x_date("\nDate") +
coord_cartesian(ylim=c(0,2100))
dev.off()

due_2012 = normalized.due[
    date >= "2012-01-01" & date < "2012-02-01" & wiki != "wikidatawiki",
    list(
        count_2012 = mean(count)
    ),
    list(
        wiki,
        n,
        bot_filter,
        archive_included
    )
]
merged_2012.due = merge(normalized.due, due_2012,
                        by=c("wiki", "n", "bot_filter", "archive_included"))

svg("unique_editors/plots/unique_editors_factor.2012_2014.en_de_it_fr_es.svg",
    height=5, width=7)
ggplot(
    merged_2012.due[bot_filter == T & archive_included == T &
                    date >= "2012-01-01" & date <= "2014-01-01",],
    aes(
        x=date,
        y=count/count_2012,
        color=wiki
    )
) +
facet_wrap(~ n) +
geom_point(alpha=0.6, size=0.5) +
stat_smooth(se=F, span=0.5) +
theme_bw() +
scale_y_continuous("Factor of mean daily unique editors Jan. 2012\n") +
scale_x_date("\nDate") +
theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
coord_cartesian(ylim=c(0.70,1.15))
dev.off()
