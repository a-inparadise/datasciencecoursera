library(datasets)
library(ggplot2)

data(ToothGrowth)

head(ToothGrowth)

summary(ToothGrowth)

g1 <- ggplot(ToothGrowth, aes(interaction(supp, dose), len, fill=interaction(supp, dose))) + 
  geom_boxplot() +
  labs(x="Supplement and Dose") +
  labs(y="Length") +
  guides(fill=FALSE)
  
print(g1)

suppoj = subset(ToothGrowth, supp == "OJ")
suppvc = subset(ToothGrowth, supp == "VC")

dosetest <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth)
lowdosetest <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose == 0.5, ])
meddosetest <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose == 1.0, ])
highdosetest <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = ToothGrowth[ToothGrowth$dose == 2.0, ])

lowdosetest1  <- t.test(subset(suppoj, dose == 0.5)$len, subset(suppvc, dose == 0.5)$len)
meddosetest2  <- t.test(subset(suppoj, dose == 1.0)$len, subset(suppvc, dose == 1.0)$len)
highdosetest3  <- t.test(subset(suppoj, dose == 2.0)$len, subset(suppvc, dose == 2.0)$len)