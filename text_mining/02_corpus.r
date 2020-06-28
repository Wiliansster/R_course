library(readr)
# Import text data from CSV, no factors
setwd("/home/wilians/Documents/R_course/text_mining")
tweets <- read_csv("coffee_data_file.csv")


# View the structure of tweets
str(tweets)

# Isolate text from tweets
coffee_tweets <- tweets$text
