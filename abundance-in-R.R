
library(tidyr)
library(dplyr)
library(ggplot2)

## The categories for medications and ingredients
Medications<- c("Mucinex", "Tylenol", "Allegra", "Ibuprofen")
Ingredients <- c("MagnesiumCategory", "MeclizineCategory", "LactoseCategory",
                 "TitaniumDioxideCategory")

## Data for plotting the abundance
set.seed(1)
num_rows <- length(Medications)
num_cols <- length(Ingredients)
abddata <-
  matrix(data = abs(rnorm(num_rows*num_cols, mean=0.01, sd=0.05)),
         nrow=num_rows, ncol=num_cols)
rownames(abddata) <- Medications
colnames(abddata) <- Ingredients
abddata <-
  abddata %>%
  as.data.frame() %>%
  tibble::rownames_to_column("Medications") %>%
  gather(Ingredients, abundance, -Medications)


## The data frame examples
filter_Ingredients <- function(abddata, Medicationscat){
  abddata %>%
    filter(Medications == Medicationscat) %>%
    select(-Medications)
}
dd_Magnesium <- filter_Ingredients(abddata, "MagnesiumCategory")
dd_Tylenol <- filter_Ingredients(abddata, "MeclizineCategory")
dd_Allegra <- filter_Ingredients(abddata, "LactoseCategory")
dd_Ibuprofen <- filter_Ingredients(abddata, "TitaniumDioxideCategory")




#Code to plot the abundance through bar graph using ggplot
plot_Ingredients <- function(dd, title=""){
  dd %>%
    ggplot(aes(x = Medications, y = abundance)) +
    geom_bar(stat = "identity") +
    ggtitle(title)
}
plt_Magnesium <- plot_Ingredients(dd_Magnesium, "Magnesium")
plt_Tylenol <- plot_Ingredients(dd_Tylenol, "Tylenol")
plt_Allegra <- plot_Ingredients(dd_Allegra, "Allegra")
plt_Ibuprofen <- plot_Ingredients(dd_Ibuprofen, "Ibuprofen")


#Combine everything to plot using cow
cowplot::plot_grid(plt_Magnesium, plt_Tylenol, plt_Allegra, plt_Ibuprofen)

