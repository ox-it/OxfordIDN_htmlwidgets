library(plyr)
library(dplyr)
library(readr)

## ===== data_fig_2 ==============================
## ====================================================

data_fig_2 <- read_tsv("data/thesaurus.fig2.tsv")
colnames(data_fig_2) <- tolower(colnames(data_fig_2))

## ===== data_fig_2_AF_vs_TPR ==============================
## ====================================================

data_fig_2_AF_vs_TPR <- data_fig_2 %>%
  select(series, af, tpr) %>%
  spread(series, tpr)

## Colnames have very invalid names, create a reference for labelling later
datacols_fig_2_AF_vs_TPR <- data_frame(
  safe.name = make.names(setdiff(colnames(
    data_fig_2_AF_vs_TPR
  ), "af")),
  label = setdiff(colnames(data_fig_2_AF_vs_TPR), "af"),
  colour = mapvalues(
    setdiff(colnames(data_fig_2_AF_vs_TPR), "af"),
    from = c(
      "[MQ 1] Local",
      "[MQ 1] Thesaurus",
      "[MQ 16] Local",
      "[MQ 16] Thesaurus",
      "Mutect"
    ),
    to = c("#84002e", "#909090" , "#ff5b00", "#2956b2", "#7dbd00"),
    warn_missing = FALSE
  )
)

## Sanitize names
colnames(data_fig_2_AF_vs_TPR) <-
  make.names(colnames(data_fig_2_AF_vs_TPR))

## ===== data_fig_2_AF_vs_FDR =========================
## ====================================================

data_fig_2_AF_vs_FDR <- data_fig_2 %>%
  select(series, af, fdr)

# Highchart version
# data_fig_2_AF_vs_FDR <- data_fig_2 %>%
#   select(series, af, fdr) %>%
#   spread(series, fdr)
# ## Colnames have very invalid names, create a reference for labelling later
# datacols_fig_2_AF_vs_FDR<- data_frame(
#   safe.name = make.names(setdiff(colnames(data_fig_2_AF_vs_FDR), "af")),
#   label = setdiff(colnames(data_fig_2_AF_vs_FDR), "af"),
#   colour = mapvalues(
#     setdiff(colnames(data_fig_2_AF_vs_FDR), "af"),
#     from = c(
#       "[MQ 1] Local",
#       "[MQ 1] Thesaurus",
#       "[MQ 16] Local",
#       "[MQ 16] Thesaurus",
#       "Mutect"
#     ),
#     to = c("#84002e", "#909090" , "#ff5b00", "#2956b2", "#7dbd00"),
#     warn_missing = FALSE
#   )
# )
#
# ## Sanitize names
# colnames(data_fig_2_AF_vs_FDR) <- make.names(colnames(data_fig_2_AF_vs_FDR))

## Unique colours for plotly
colors_fig_2_AF_vs_FDR <- mapvalues(
  unique(data_fig_2_AF_vs_FDR$series),
  from = c(
    "[MQ 1] Local",
    "[MQ 1] Thesaurus",
    "[MQ 16] Local",
    "[MQ 16] Thesaurus",
    "Mutect"
  ),
  to = c("#84002e", "#909090" , "#ff5b00", "#2956b2", "#7dbd00"),
  warn_missing = FALSE
)

## ===== data_fig_3 ==============================
## ====================================================

data_fig_3 <- read_tsv("data/thesaurus.fig3.tsv")
colnames(data_fig_3) <- tolower(colnames(data_fig_3))

## ===== data_fig_3_AF_vs_TPR ==============================
## ====================================================

data_fig_3_AF_vs_TPR <- data_fig_3 %>%
  select(series, baf, tpr) %>%
  spread(series, tpr)

## Colnames have very invalid names, create a reference for labelling later
datacols_fig_3_AF_vs_TPR <- data_frame(
  safe.name = make.names(setdiff(colnames(
    data_fig_3_AF_vs_TPR
  ), "baf")),
  label = setdiff(colnames(data_fig_3_AF_vs_TPR), "baf"),
  colour = mapvalues(
    setdiff(colnames(data_fig_3_AF_vs_TPR), "baf"),
    from = c(
      "[MQ 1] Local",
      "[MQ 1] Thesaurus",
      "[MQ 16] Local",
      "[MQ 16] Thesaurus",
      "Mutect"
    ),
    to = c("#84002e", "#909090" , "#ff5b00", "#2956b2", "#7dbd00"),
    warn_missing = FALSE
  )
)

## Sanitize names
colnames(data_fig_3_AF_vs_TPR) <-
  make.names(colnames(data_fig_3_AF_vs_TPR))


## ===== data_fig_3_AF_vs_FDR ==============================
## ====================================================

data_fig_3_AF_vs_FDR <- data_fig_3 %>%
  select(series, baf, fdr) %>%
  spread(series, fdr)

## Colnames have very invalid names, create a reference for labelling later
datacols_fig_3_AF_vs_FDR <- data_frame(
  safe.name = make.names(setdiff(colnames(
    data_fig_3_AF_vs_FDR
  ), "baf")),
  label = setdiff(colnames(data_fig_3_AF_vs_FDR), "baf"),
  colour = mapvalues(
    setdiff(colnames(data_fig_3_AF_vs_FDR), "baf"),
    from = c(
      "[MQ 1] Local",
      "[MQ 1] Thesaurus",
      "[MQ 16] Local",
      "[MQ 16] Thesaurus",
      "Mutect"
    ),
    to = c("#84002e", "#909090" , "#ff5b00", "#2956b2", "#7dbd00"),
    warn_missing = FALSE
  )
)

## Sanitize names
colnames(data_fig_3_AF_vs_FDR) <-
  make.names(colnames(data_fig_3_AF_vs_FDR))

## ===== data_fig_4 ==============================
## ====================================================


data_fig_4_red <- read_tsv("data/thesaurus.fig4-red.tsv")
colnames(data_fig_4_red) <- tolower(colnames(data_fig_4_red))



## Add column with 1 in it
data_fig_4_red <- data_fig_4_red %>%
  mutate(bubble.size = 0.02)

data_fig_4_blue <- read_tsv("data/thesaurus.fig4-blue.tsv")
colnames(data_fig_4_blue) <- tolower(colnames(data_fig_4_blue))

## Add column with 1 in it
data_fig_4_blue <- data_fig_4_blue %>%
  mutate(bubble.size = 0.02)
