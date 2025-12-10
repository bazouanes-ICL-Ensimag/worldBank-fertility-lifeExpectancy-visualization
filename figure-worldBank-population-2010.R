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

world_bank_2010 <- subset(world_bank, year == 2010)

# Creating the figure : 
scatter <- ggplot() +
  geom_point(
    aes(x = life.expectancy, y = fertility.rate, color = Region, size = population),
    data = world_bank_2010
  ) +
  scale_size_continuous(
    range = c(1, 18),
    breaks = c(1e5, 1e6, 1e7, 1e8, 5e8, 1e9),
    labels = c("100K", "1M", "10M", "100M", "500M", "1B")
  ) +
  labs(
    title = "World Bank : Life Expectancy vs Fertility Rate (2010)",
    x = "Life Expectancy (years)",
    y = "Fertility Rate"
  ) +
  theme(text = element_text(size = 12))

# Saving the figure :
png("figure-worldBank-population-2010.png", height=6, width=10, units="in", res=200)
print(scatter)
dev.off()