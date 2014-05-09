fileName <- "./data/SFFood.zip"

if (!file.exists(fileName)) {
  url <- "http://steviep42.bitbucket.org/data/SFFoodProgram_Complete_Data.zip"
  download.file(url, fileName)
  system("unzip -l ./data/SFFood.zip")
}

businesses <- read.csv(unz(fileName, "businesses_plus.csv"), header=TRUE, stringsAsFactors=FALSE)
violations <- read.csv(unz(fileName, "violations_plus.csv"), header=TRUE, stringsAsFactors=FALSE)
inspections <- read.csv(unz(fileName, "inspections_plus.csv"), header=TRUE, stringsAsFactors=FALSE)

inspections$date <- strptime(inspections$date, format="%Y%m%d")
violations$date <- strptime(violations$date, format="%Y%m%d")

start_time <- strptime("20130101", "%Y%m%d")
stop_time <- strptime("20131231", "%Y%m%d")

inspections13 <- subset(inspections, date > start_time & date < stop_time)
violations13 <- subset(violations, date > start_time & date < stop_time)

range(inspections13$date)
nrow(inspections)
nrow(violations)

# Details on scores
# http://www.sfdph.org/dph/EH/Food/score/default.asp

# Get the top few inspections
head(inspections13[order(inspections13$business_id),])

head(violations13[order(violations13$business_id),])

# What is the average health score across all restuarants for 2013?
mean(inspections13$Score, na.rm = TRUE)

# P = Poor, NI = Needs Improvement, A = Adequate, G = Good
inspections13$rating <- cut(inspections13$Score,breaks=c(0,70,85,89,100), right=TRUE, labels=c("P", "NI", "A", "G"))

tapply(inspections13$Score,inspections13$rating,mean)

# Set the limits of the boxplot outside the range of data by 5
ylim <- c(min(inspections13$Score, na.rm=TRUE)-5, max(inspections13$Score, na.rm=TRUE)+5)

# Capture the boxplot output to get the number of observations per category
leg.txt <- paste(levels(inspections13$rating), myb$n, sep=" : ")

legend(3,70,leg.txt,title="Obs. per Category", cex=0.8, pch=19, col=rainbow(4))


