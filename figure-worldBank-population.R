library(animint2)

data(WorldBank)
WorldBank$Region <- sub(" (all income levels)", "", WorldBank$region, fixed = TRUE)
world_bank <- subset(
  WorldBank,
  is.finite(fertility.rate) & is.finite(life.expectancy),
  select = c(
    Region, country, year, fertility.rate, life.expectancy,
    lending, population, income
  )
)

## The used code to propose a just scale for the population. 
#summary(world_bank$population)
#range(world_bank$population, na.rm = TRUE)
#quantile(world_bank$population, c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE)



scatter <- ggplot() +
  geom_point(
    mapping = aes(x = life.expectancy, y = fertility.rate, color = Region, size = population), showSelected="year",
    data = world_bank
  ) +
  scale_size_animint(
    pixel.range = c(1, 18),
    breaks = c(1e5, 1e6, 1e7, 1e8, 5e8, 1e9),
    labels = c("100K", "1M", "10M", "100M", "500M", "1B")
  )

viz <- animint(scatter)
print(viz)