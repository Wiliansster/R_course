# this course is given by datacamp

# Load qdpa packages
library(qdap)

# Print new_text to the console
new_text <-
    "DataCamp is the first online learning platform that focuses on building the best learning experience specifically for Data Science. We have offices in New York, London and Belgium and to date, we trained over 3.8 million (aspiring) data scientists in over 150 countries. These data science enthusiasts completed more than 185 million exercises. You can take free beginner courses, or subscribe for $29/month to get access to all premium courses."

# Find the 10 most frequent terms: term_count
term_count <- freq_terms(new_text, 10)

# Plot term_count
plot(term_count)