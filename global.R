Bi_Data <- read.csv("Bi_Data.csv")
Tri_Data <- read.csv("Tri_Data.csv")
Quad_Data <- read.csv("Quad_Data.csv")
Pent_Data <- read.csv("Pent_Data.csv")
Sext_Data <- read.csv("Sext_Data.csv")




checkforFiveWords <- function(getCheckString) {
  
  wordCount <- sapply(gregexpr("\\W+", getCheckString), length) + 1
  
  if (wordCount >= 5) {
    
    textcleansplit <- tail(strsplit(getCheckString,split=" ")[[1]],5)
    textcleansplit <- paste(textcleansplit,collapse =" ")
    
  }
}


downtoFour <- function(getcheckString4) {
  
  wordCount <- sapply(gregexpr("\\W+", getcheckString4), length) + 1
  
  if (wordCount >= 4) {
    
    textcleansplit <- tail(strsplit(getcheckString4,split=" ")[[1]],4)
    textcleansplit <- paste(textcleansplit,collapse =" ")
    
  }
}


downtoThree <- function(getcheckString3) {
  
  wordCount <- sapply(gregexpr("\\W+", getcheckString3), length) + 1
  
  if (wordCount >= 3) {
    
    textcleansplit <- tail(strsplit(getcheckString3,split=" ")[[1]],3)
    textcleansplit <- paste(textcleansplit,collapse =" ")
    
  }
}

downtoTwo <- function(getcheckString2) {
  
  wordCount <- sapply(gregexpr("\\W+", getcheckString2), length) + 1
  
  if (wordCount >= 2) {
    
    textcleansplit <- tail(strsplit(getcheckString2,split=" ")[[1]],2)
    textcleansplit <- paste(textcleansplit,collapse =" ")
    
  }
}





getTopFiveWords2 <- function(getString2) {
  getString2 <- paste('^',getString2,' ',sep = '')
  findRecord <- grep(getString2,Tri_Data$term)
  if (length(findRecord) >0 ) {
    tempDF <- head(Tri_Data[findRecord,],5)
    tempDF
    SourceFun <- 'Two Word Match'
    cbind(tempDF,SourceFun)
  }  
  else {
    tempDF <- data.frame(term='No Match', Mike_Count=0, SourceFun='Two Word Check')
  }
}


getTopFiveWords3 <- function(getString3) {
  getString3 <- paste('^',getString3,' ',sep = '')
  findRecord <- grep(getString3,Quad_Data$term)
  if (length(findRecord) >0 ) {
    tempDF <- head(Quad_Data[findRecord,],5)
    tempDF
    SourceFun <- 'Three Word Match'
    cbind(tempDF,SourceFun)
  }  
  else {
    tempDF <- data.frame(term='No Match', Mike_Count=0, SourceFun='Three Word Check')
  }
}


getTopFiveWords4 <- function(getString4) {
  getString4 <- paste('^',getString4,' ',sep = '')
  findRecord <- grep(getString4,Pent_Data$term)
  if (length(findRecord) >0 ) {
    tempDF <- head(Pent_Data[findRecord,],5)
    tempDF
    SourceFun <- 'Four Word Match'
    cbind(tempDF,SourceFun)
  }  
  else {
    tempDF <- data.frame(term='No Match', Mike_Count=0, SourceFun='Four Word Match')
  }
}


getTopFiveWords5 <- function(getString5)  {
  
  getString5 <- paste('^',getString5,' ',sep = '')
  findRecord <- grep(getString5,Sext_Data$term)
  if (length(findRecord) >0 ) {
    tempDF <- head(Sext_Data[findRecord,],5)
    tempDF
    SourceFun <- 'Five Word Match'
    cbind(tempDF,SourceFun)
  }
  else {
    tempDF <- data.frame(term='No Match', Mike_Count=0, SourceFun='Five Word Match')
  }
}

cleanInput <- function(getInput) {
  
  badword1 <- grep('[Ff][Uu][Cc][Kk]',getInput)
  badword2 <- grep('[Ss][Hh][Ii][Tt]',getInput)
  if (length(badword1)+length(badword2) > 0)  {
    clean1 <- getInput[-c(badword1,badword2)] }
  else {
    clean1 <- getInput}
  clean1 <- getInput
  #clean1 <- iconv(clean1, 'UTF-8', 'ASCII')
  clean1 <- iconv(clean1, "latin1", "ASCII", sub="")
  clean1 <- gsub("[?.;!¡¿·&,_():;']","", clean1)
  clean1 <- tolower(clean1)
  clean1 <- gsub(pattern='[^a-zA-Z]',clean1,replacement=' ')
  #clean1 <- strsplit(clean1, '\\W+', perl=TRUE)
  
}

ReviewText <- function(getTextToReview) {
  
  
  getTextToReviewX <- cleanInput(getTextToReview)
  
  dfFinal <- data.frame(term=character(), Mike_Count=integer(), SourceFun=character())
  
  
  x <- sapply(gregexpr("\\W+", getTextToReviewX), length) + 1
  y <- 0
  if (x >= 5)   {
    txtFive <- checkforFiveWords(getTextToReviewX)
    dfFive <- getTopFiveWords5(txtFive)
    dfFinal <- dfFive
    y <- y + 1
  }  
  if (x > 4) {
    txtFour <- downtoFour(getTextToReviewX)
    dfFour <- getTopFiveWords4(txtFour)
    dfFinal <- rbind(dfFinal,dfFour)
    y <- y + 1
  }
  
  if (x > 3)  {
    txtThree <- downtoThree(getTextToReviewX)
    dfThree <- getTopFiveWords3(txtThree)
    dfFinal <- rbind(dfFinal,dfThree)
    y <- y + 1
  }
  
  
  if (x >= 2) {
    txtTwo <- downtoTwo(getTextToReviewX)
    dfTwo <- getTopFiveWords2(txtTwo)
    dfFinal <- rbind(dfFinal,dfTwo)
    y <- y + 1 
  }
  
  
  
  if (y == 0) {
    
    dfFinal <- data.frame(term='Please Enter More Than One Word', Mike_Count=0, SourceFun='Please Enter More Than One Word')
  } 
  
  
  
  dfFinal
  
  
  
}


FinalTopFiveWords <- function(dfGetFive) {
  
  dfGetFive$Get_Last_Word <- word(dfGetFive$term,-1)
  dfGetFive <- subset(dfGetFive, Get_Last_Word !='Match')
  dfFiveWordMatch <- subset(dfGetFive,dfGetFive$SourceFun == 'Five Word Match' & dfGetFive$term != 'No Match')
  dfFourWordMatch <- subset(dfGetFive,dfGetFive$SourceFun == 'Four Word Match' & dfGetFive$term != 'No Match')
  if(nrow(dfFiveWordMatch) >0 ) {
    txtFiveWordMatch <- dfFiveWordMatch$Get_Last_Word
  }
  if(nrow(dfFourWordMatch) >0 ) {
    txtFourWordMatch <- dfFourWordMatch$Get_Last_Word
  }
  
  Final_List <- aggregate(Mike_Count ~ Get_Last_Word, dfGetFive, sum)
  if(nrow(dfFiveWordMatch) >0 ) {
    Final_List <- subset(Final_List,Final_List$Get_Last_Word != txtFiveWordMatch)
  }
  if(nrow(dfFourWordMatch) >0 ) {
    Final_List <- subset(Final_List,Final_List$Get_Last_Word != txtFourWordMatch)
  }
  
  Final_Term_Matrix <- Final_List[order(Final_List$Mike_Count,decreasing = TRUE),]
  Final_Term_Matrix <- head(Final_Term_Matrix)
  Final_Term_Matrix$Get_Last_Word  
}


FinalTopFiveWords2 <- function(dfGetFive) {
  
  dfGetFive$Get_Last_Word <- word(dfGetFive$term,-1)
  dfGetFive <- subset(dfGetFive, Get_Last_Word !='Match')
  txtFinal_Words <- dfGetFive$Get_Last_Word 
  txtFinal <- unique(txtFinal_Words)
  txtFinal <- head(txtFinal,5)
  #txtFinal <- paste(txtFinal,"''")
  
}


graphData <- function(getGraphList) {
  
  getGraphList$Get_Last_Word <- word(getGraphList$term,-1)
  getGraphList <- subset(getGraphList, Get_Last_Word !='Match')
  Final_List <- aggregate(Mike_Count ~ Get_Last_Word, getGraphList, sum)
  Final_Term_Matrix <- Final_List[order(Final_List$Mike_Count,decreasing = TRUE),]
  Final_Term_Matrix <- head(Final_Term_Matrix)
  
  
}

