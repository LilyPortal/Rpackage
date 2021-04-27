
#First create the datasets that you want to calculate abundance on
#This is one example
cat1 <- c("A", "B", "C", "D")
cat2 <- c("W", "X", "Y", "Z")



#Next for each variable for each sample, calculate relative abundance
#This is a new example
categories <- data.frame(
  x = 1:5,
  vari1 = c(5,9,4,8,17),
  vari2 = c(72,90,81,83,26),
  vari3 = c(19,45,76,32,99),
  total_counts = c(603,512,204,365,683)
)

#Show relative abundance for each column with this for loop
abundance <- categories
for (i in 2:(ncol(categories) - 1)) {
  abundance[i] <- abundance[i] / abundance$total_count
}
abundance
