Word Predictor Application
Mike McLaughlin
Coursera/Johns Hopkins - Data Science Capstone
June 2017

This document will provide backup and information on the Word Predictor Application which is located at https://www.shinyapps.io/admin/#/application/189838

File Descriptions and purpose.
ui.R – User interface file.   Contains programming which is presented to the user upon login to the application.

server.R – Back end programming that contains the information to reference the logic to predict words.

global.R – Contains all functions and calls to data required to execute logic to predict words.

Data Files
Tri_Data.txt – Contains most common three word phrases from a 12% sampling of data provide for the course.
Quad_Data.txt – Contains most common four-word phrases.
Pent_Data.txt – Contains most common five word phrases.
Sext_Data.txt – Contains most common six word phrases.
Bi_Data.txt – Contains most common two word phrases.   Not used for this application.

Presentation
capstone_pres_v2.Rpres – File used to create presentation located at. http://rpubs.com/mikeleemclau
R Files
June07v1.R – This file contains all the programming required to create the Data files required for this application.
Additionally, it contains functions which were used to create the Shiny Application.
Functions
getFiles – Used to import a sampling of text files.
Cleandata – Remove graphics and a couple of swear words from text files.
checkforFiveWords – Get word count from information entered in application.   If text string contains five or more words, used last five words to predict next word.
Downtofour – if four words, starts with this function.   Otherwise runs this function after checkforFive words and identified a match based on four words.
DowntoThree – if three words, starts with this function.  Otherwise runs this function after checkforfour words and identified a match based on three words.

DowntoTwo – if two words starts with this function.   Otherwise starts after checkforThree

cleanInput – cleans data entered by user to match structure of data files.

Each of the below function contains the programming to extract predicted words from data  files.
getTopFiveWords5
getTopFiveWords4
getTopFiveWords3
getTopFiveWords2

This is the simple structure of basic logic.
If text string contains five or more words.   
Extract last five words.
Check Sext_Data for match on first five words.   If there is a match, use next word as predicted word.
Next Check Pent_Data for match for first four words.
Next Check Quad_Data for match on first three word.
Next Check Tri_Data for match on first two words.
After all words are identified, aggerate all found words and report back in order of when the words are found.
