# this course is given by datacamp

# Load qdpa packages
library(qdap)
library(readr)

# --- Ex1

# Print new_text to the console
new_text <-
    "DataCamp is the first online learning platform that focuses on building the best learning experience specifically for Data Science. We have offices in New York, London and Belgium and to date, we trained over 3.8 million (aspiring) data scientists in over 150 countries. These data science enthusiasts completed more than 185 million exercises. You can take free beginner courses, or subscribe for $29/month to get access to all premium courses."

# Find the 10 most frequent terms: term_count
term_count <- freq_terms(new_text, 10)

# Plot term_count
plot(term_count)

# --- Ex2
tweets <- 
    read_csv("/home/wilians/Documents/R_course/text_mining/Dataset/Coffe_tweets.csv")


# View the structure of tweets
str(tweets)

# Isolate text from tweets
coffee_tweets <- tweets$text

# --- Ex 3
# Load tm
library(tm)

# Make a vector source from coffee_tweets
coffee_source <- VectorSource(coffee_tweets)

# --- Ex 4

# Make a volatile corpus from coffee_corpus
coffee_corpus <- VCorpus(coffee_source)

# Print out coffee_corpus
coffee_corpus

# Print the 15th tweet in coffee_corpus
coffee_corpus[[15]]

# Print the contents of the 15th tweet in coffee_corpus
content(coffee_corpus[[15]])

# Now use content to review plain text of the 10th tweet
content(coffee_corpus[[10]])

# --- Ex 5
doc_id <- c(1,2,3)
text <- c("Text mining is a great time.", "Text analysis provides insights","qdap and tm are used in text mining" )
author <- c( "Author1", "Author2", "Author3")
date <- c(
1514953399,
1514866998,
1514780598)

example_text <- data.frame(doc_id, text, author,date)

# Create a DataframeSource from the example text
df_source <- DataframeSource(example_text)

# Convert df_source to a volatile corpus
df_corpus <- VCorpus(df_source)

# Examine df_corpus
df_corpus

# Examine df_corpus metadata
meta(df_corpus)

# Compare the number of documents in the vector source
vec_corpus

# Compare metadata in the vector corpus
meta(vec_corpus)

#################################
# Cleaning and preprocessing text

# --- Ex 1
# Create the object: text
text <- "<b>She</b> woke up at       6 A.M. It\'s so early!  She was only 10% awake and began drinking coffee in front of her computer."

# Make lowercase
tolower(text)

# Remove punctuation
removePunctuation(text)

# Remove numbers
removeNumbers(text)

# Remove whitespace
stripWhitespace(text)

#########
# Cleaning with qdap
library(qdap)

# --- EX 1
# Remove text within brackets
bracketX(text)

# Replace numbers with words
replace_number(text)

# Replace abbreviations
replace_abbreviation(text)

# Replace contractions
replace_contraction(text)

# Replace symbols with words
replace_symbol(text)

# --- EX 2

# List standard English stop words
stopwords("en") 

# Print text without standard stop words
removeWords(text, stopwords("en"))

# Add "coffee" and "bean" to the list: new_stops
new_stops <- c("coffee", "bean", stopwords("en"))

# Remove stop words from text
removeWords(text,new_stops)

# --- EX 3 
library(tm)
# Intro to word stemming and stem completion

# Create complicate
complicate <- c("complicated", "complication", "complicatedly")

# Perform word stemming: stem_doc
stem_doc <- stemDocument(complicate)

# Create the completion dictionary: comp_dict
comp_dict <- "complicate"

# Perform stem completion: complete_text 
complete_text <- stemCompletion(stem_doc, comp_dict)

# Print complete_text
complete_text

### 
# Word stemming and stem completion on a sentence
# -- Ex 4
text_data <- "Word stemming and stem completion on a sentence"
comp_dict <- c("In" ,
"a",
"complicate",
"haste",
"Tom"  ,     
"rush"  ,     
"to"   ,      
"fix"  ,      
"new" ,       
"too")


# Remove punctuation: rm_punc
rm_punc <- removePunctuation(text_data)

# Create character vector: n_char_vec
n_char_vec <- unlist(strsplit(rm_punc, split = " "))

# Perform word stemming: stem_doc
stem_doc <- stemDocument(n_char_vec)

# Print stem_doc
stem_doc

# Re-complete stemmed document: complete_doc
complete_doc <- stemCompletion(stem_doc,comp_dict)

# Print complete_doc
complete_doc
# TODO: rever a variável comp_dict

# Apply preprocessing steps to a corpus

# Alter the function code to match the instructions
clean_corpus <- function(corpus) {
  # Remove punctuation
  corpus <- tm_map(corpus, removePunctuation)
  # Transform to lower case
  corpus <- tm_map(corpus, content_transformer(tolower))
  # Add more stopwords
  corpus <- tm_map(corpus, removeWords, words = c(stopwords("en"), "coffee", "mug"))
  # Strip whitespace
  corpus <- tm_map(corpus, stripWhitespace)
  return(corpus)
}

# Make a document-term matrix

# Hopefully you are not too tired after all this basic text mining work! 
# Just in case, let's revisit the coffee and get some Starbucks while 
# building a document-term matrix from coffee tweets

clean_corp <- clean_corpus(coffee_corpus)

# Create the document-term matrix from the corpus
coffee_dtm <- DocumentTermMatrix(clean_corp)

# Print out coffee_dtm data
coffee_dtm

# Convert coffee_dtm to a matrix
coffee_m <- as.matrix(coffee_dtm)
# Print the dimensions of coffee_m
dim(coffee_m)
# Review a portion of the matrix to get some Starbucks
coffee_m[25:35, c("star", "starbucks")]

#  Understanding TDM and DTM
# When should you use the term-document matrix instead of the document-term matrix?
# resp:  When you want the words as rows and documents as columns