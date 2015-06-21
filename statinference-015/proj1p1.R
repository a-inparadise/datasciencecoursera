library(ggplot2)

lambda = 0.2
simmu <- 1/lambda
n = 40
nsims = 1:1000
set.seed(876)
means <- data.frame(x = sapply(nsims, function(x) {mean(rexp(n, lambda))}))
head(means)

g1 <- ggplot(data = means, aes(x = x)) + 
  geom_histogram( binwidth=0.1, aes(y=..density..))
print(g1)

simmean <- mean(means$x)
simsd <- sd(means$x)
simexpsd <- (1/lambda)/sqrt(n)
simvar <- var(means$x)
simexpvar <- ((1/lambda)/sqrt(n))^2

ggplot(data = means, aes(x = x)) + 
  geom_histogram(binwidth=0.1, aes(y=..density..), fill = I('#8A8A8A'),) +
  stat_function(fun = dnorm, arg = list(mean = simmu , sd = simsd), colour = "red", size=2) + 
  geom_vline(xintercept = simmu, size=1, colour="red") + 
  geom_density(colour="blue", size=2) +
  geom_vline(xintercept = simmean, size=1, colour="blue") + 
  labs(x="Means") +
  labs(y="Density")
#print(g2)