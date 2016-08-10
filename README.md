# twitterAPI
Twitter apps and programs using the API
<br>
<br>

<h2>Shiny app - shiny_senti </h2>
Interactive Shiny application to display sentiment analysis for various phrases and search terms.<br>
Application accepts user a search term as input and displays graphical sentiment analysis.<br>
Live App Link - https://anupamaprv.shinyapps.io/shiny_senti/
<br>
The program processes the search term and extracts maximum 20 tweets transmitted between 1-Jan-2013 and 8-Aug-2016, using an authorized Twitter API connection.<br>
A bar graph displays the overall "sentimental" value for the associated tweet-set, for emotions ranging from anger, fear, 
joy, anticipation, etc.<br>
An image is also displayed to indicate the overall positive/negative "sentiment" of the tweets returned. <br>
![Screenshot - Shiny Sentiment Analysis app](https://github.com/anurajaram/twitterAPI/blob/master/twitter_sentiment_shinyapp.jpg)

<h2> Files used with Shiny App</h2>
<h3>ui.R</h3>
Code to format the display/ UI of the Shiny app.
<br>

<h3>server.R</h3>
Code for logic and computations for each input/ output block of the Shiny app.
<br>

<h3>global</h3>
Program to define functions used in the Shiny app, store global variables, Twitter API authorization keys, etc. 
<br>

<h3>joy_disney.jpg, sad_disney.jpg</h3>
Images used with the Shiny app.
<br>

<h3>wksp_prep.R</h3>
Program to set basic R library packages, set number formatting, etc. and basically prepare the environment.



