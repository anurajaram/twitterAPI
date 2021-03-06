# call source file with all required packages.
source("wksp_prep.R")

library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr )
library(twitteR)


# flag for image set to 100, assuming most tweets are happy!
image_flag = 100
print(image_flag)


# ============= function definition - chk_searchterm() ============ #
# ================================================================= #
# function to test whether search term was used in any tweets
chk_searchterm <- function( term )
{
  tw_search = searchTwitter(term, n=20, since='2013-01-01')
  # look for all tweets containing this search term.
  
  if(length(tw_search) <= 5)
  {
    return_term <- "None/few tweets to analyse for this search term. Please try again!"
  }  
  else 
    { return_term <- paste("Extracting max 20 tweets for Input =", term, 
                           ".Sentiment graph below ")
    }
  
  return(return_term)
} 



# ============= function definition - twitter_senti() ============ #
# ================================================================ #
# function to create graph of sentiment analysis
twitter_senti <- function( search_term)
{
  temp <- chk_searchterm(search_term)
  
  test_term = "None/few tweets to analyse for this search term. Please try again!"
  
  if(temp == test_term) 
  { return(temp_senti_total)
  }
  else
  { # Search Twitter for all tweets with the input phrase
    # at the moment we are only trying to gather 20 tweets at a time.
    tw_search = searchTwitter(search_term, n=20, since='2013-01-01')
    
    # convert list of tweets into a usable dataframe	
    tweet_doc = twListToDF(tw_search )
    
    # remove special characters and emojis from tweets
    tweet_doc$text <- sapply(tweet_doc$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
    
    # Emotional sentiment of tweets - nrc_sentiment function assigns an emotional value to each of the 20 tweets we extracted.
    mySentiment <- get_nrc_sentiment(tweet_doc$text)
    
    # aggregate sentiments into a new object
    sentimentTotals <- data.frame(colSums(mySentiment))
    
    # give column names
    names(sentimentTotals) <- "count"
    sentimentTotals <- cbind("sentiment" = rownames(sentimentTotals), sentimentTotals)
    rownames(sentimentTotals) <- NULL
    
    return(sentimentTotals)  # retun graph object
  }
}



# creating an empty sentiment graph object
# this will be displayed if the input search string returns none or very few tweets
temp_Text = "There is nothing to see"
sample_sentiment <- get_nrc_sentiment(temp_Text)
temp_senti_total <- data.frame(colSums(sample_sentiment))
colnames(temp_senti_total) <- c("count")
temp_senti_total <- cbind("sentiment" = rownames(temp_senti_total), temp_senti_total)
rownames(temp_senti_total) <- NULL



# set variables for twitter API call authorization
consumer_key = "ckey"
consumer_secret = "csecret"
access_token = "atoken"
access_secret = "asecret"
options(httr_oauth_cache=T) 


# This will enable the use of a local file to cache OAuth 
# access credentials between R sessions.
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

senti <- read.csv("tweets_senti_anly.csv")

# aggregate sentiments into a new object
sentimentTotals <- data.frame(colSums(senti[,c(22:31)]))

# give column names
names(sentimentTotals) <- "count"
sentimentTotals <- cbind("sentiment" = rownames(sentimentTotals), sentimentTotals)
rownames(sentimentTotals) <- NULL

# plot overal sentiment scores
gpsenti <- ggplot(data = sentimentTotals, aes(x = sentiment, y = count)) +
  geom_bar(aes(fill = sentiment), stat = "identity") +
  theme(legend.position = "none") +
  xlab("Sentiment") + ylab("Total Count") + ggtitle("Total Sentiment Score for All Tweets")




