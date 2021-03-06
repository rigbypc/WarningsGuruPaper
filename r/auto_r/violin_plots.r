library("RPostgreSQL", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.1")
library("vioplot", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.1")                                                                 

con <- dbConnect(dbDriver("PostgreSQL"), dbname="cas", host="localhost")

avgDevDelta <- dbGetQuery(con, "SELECT c.fix = 'True' as fix, c.contains_bug = 'TRUE' as contains_bug, repo_name, ns, nd, nf, entrophy,
la, ld, lt, ndev, age, nuc, exp, rexp, sexp, warnings, new_warnings, jlint_warnings, new_jlint_warnings, findbugs_warnings,
new_findbugs_warnings, security_warnings, new_security_warnings, fallback_warnings, fallback_security_warnings,
build != 'BUILD' as build_failed, warnings > 0 as w_bool
from commits as c, commit_warning_summary as w where c.repository_id = w.repo and c.commit_hash = w.commit")

#detach(avgDevDelta)
attach(avgDevDelta)

result = split(avgDevDelta, as.factor(avgDevDelta$repo_name))                                                             

commons_lang = result[['commons-lang']]$new_warnings
hadoop = result[['hadoop']]$new_warnings
ignite = result[['ignite']]$new_warnings
kylin = result[['kylin']]$new_warnings
phoenix = result[['phoenix']]$new_warnings
ranger = result[['ranger']]$new_warnings
tika = result[['tika']]$new_warnings
wicket = result[['wicket']]$new_warnings

png(filename="{image_path}/new_warnings_violin.png", width = 1000, height = 570, pointsize = 18)
vioplot(commons_lang, hadoop, ignite, kylin, phoenix, ranger, tika, wicket,
names = c("C-L", "Hadoop", "Ignite", "Kylin", "Phoenix", "Ranger", "Tika", "Wicket"),
col = "gold")
                                                                                   title("New Warnings Contained in Project Commit")
dev.off()

pdf("{image_path}/new_warnings_violin.pdf", width=10, height=6)
vioplot(commons_lang, hadoop, ignite, kylin, phoenix, ranger, tika, wicket,
names = c("C-L", "Hadoop", "Ignite", "Kylin", "Phoenix", "Ranger", "Tika", "Wicket"),
col = "gold")
                                                                                   title("New Warnings Contained in Project Commit")
dev.off()

commons_lang = result[['commons-lang']]$new_security_warnings
hadoop = result[['hadoop']]$new_security_warnings
ignite = result[['ignite']]$new_security_warnings
kylin = result[['kylin']]$new_security_warnings
phoenix = result[['phoenix']]$new_security_warnings
ranger = result[['ranger']]$new_security_warnings
tika = result[['tika']]$new_security_warnings
wicket = result[['wicket']]$new_security_warnings

png(filename="{image_path}/new_security_warnings_violin.png", width = 1000, height = 570, pointsize = 18)
vioplot(commons_lang, hadoop, ignite, kylin, phoenix, ranger, tika, wicket,
names = c("C-L", "Hadoop", "Ignite", "Kylin", "Phoenix", "Ranger", "Tika", "Wicket"),
col = "gold")
title("New Security Warnings Contained in Project Commit")
dev.off()

pdf("{image_path}/new_security_warnings_violin.pdf", width=10, height=6)
vioplot(commons_lang, hadoop, ignite, kylin, phoenix, ranger, tika, wicket,
names = c("C-L", "Hadoop", "Ignite", "Kylin", "Phoenix", "Ranger", "Tika", "Wicket"),
col = "gold")
title("New Security Warnings Contained in Project Commit")
dev.off()
