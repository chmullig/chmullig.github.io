#Get our title text ready
s <- read.csv('summary.csv')
s$fetchtime <- strptime(s$fetchtime, "%Y-%m-%d %H:%M:%s")
last <- s[nrow(s),]
nsubs <- last$submissions
when <- last$fetchtime

#Load the main data
map <- read.csv('leaderMeanAveragePrecision.csv')
map$fetchtime <- strptime(map$fetchtime, "%Y-%m-%d %H:%M:%s")
map$submissiontime <- strptime(map$submissiontime, "%Y-%m-%d %H:%M:%s")

scores <- unique(map[,-(0:3)])
starttime <- strptime("20110117", "%Y%m%d")
xrange <- c(starttime, when)
yrange <- c(0, 100)

#Ensure teh text size and trim length are set properly to show as much name as possible
TEXTSIZE <- .85
MAXLEN <- 16/TEXTSIZE
palette(c("#7570B3", "#430541", "#E6AB02", "#CF0234", "#A6D854", "#A6761D", "#FC8D62", "#E78AC3", 
"#FF00AA", "#22FF55", "chocolate", "#FF6163", "red", "#430541", "black", "#66A61E", "blue", 
"#1B9E77", "#042E60", "turquoise", "forest green", "purple", "orange",
"#7570B3", "#E78AC3", "chocolate", "#CF0234", "#1B9E77", "#FC8D62", "#66A61E", 
"#D95F02", "black", "#E6AB02", "#042E60", "blue"))
colors <- palette()

#Make sure the final labels will be sufficiently spread out
#This finds any points that are close together than 2 times the text size
#And moves the top one up, and the bottom one down by about half the space
#Required to make them 2*textsize apart. It movies the top one up slightly more
#because that was more aethetically pleasing
bests <- aggregate(scores$score, list(team = scores$team), max)
bests <- bests[order(bests$x), ]
badPoints <- which(diff(bests$x) < 2*TEXTSIZE)
i <- 0
while (length(badPoints) > 0)
  {
  bests$x[badPoints] <- bests$x[badPoints] - (((2 * TEXTSIZE +.02) - diff(bests$x)[badPoints])*0.45)
  bests$x[badPoints+1] <- bests$x[badPoints+1] + (((2 * TEXTSIZE +.02) - diff(bests$x)[badPoints])*0.55)
  badPoints <- which(diff(bests$x) < 2*TEXTSIZE)
  i <- i + 1
  }
nteams <- nrow(bests)
print(paste("Spreading required", i, "iterations"))

#png(filename="mitre_leaderboard.png", width=870, height=870)
pdf(file="mitre_leaderboard.pdf", width=12, height=12)

#Setup the plot, title, axis labels, etc
par(mar=par()$mar+c(0,0,0,6),bty="l",yaxs="i", xaxs="i")
plot(xrange, yrange, type="n", xaxt='n', xlab="Submission Time", ylab="Best MAP Score", main="MITRE Name Matching Challenge: Best MAP Score for each team over time")
atx <- seq(starttime, when, by=(when-starttime)/6)
axis(1, at=atx, labels=format(atx, "%b\n%d"), padj=0.5)
mtext(side=3, text=paste(nsubs, "submissions by", nteams, "teams as of ", format(when, format="%B %d %Y %l:%M %p")))
mtext(side=4, text="Team & Current Score", at=100, las=2, line=-0.5)

#For each team plot their scores and label in the margin
for (team in unique(scores$team)) {
    i = which(unique(scores$team)==team)
    currscore <- max(scores$score[scores$team==team])
    xvals <- scores$submissiontime[scores$team==team]
    yvals <- scores$score[scores$team==team]
	#These next two lines add a datapoint for their current score right now
    xvals <- append(xvals, when)
    yvals <- append(yvals, currscore)
    lines(xvals, yvals, col=colors[i], lwd=2, type="s")
    displayName <- team
    #Trim the team name if it's too long to be shown
    if (nchar(as.character(displayName)) > MAXLEN) {
        displayName <- paste(substring(displayName, 0, MAXLEN-3), "...", sep="")
    }
    mtext(side=4, at=bests$x[bests$team==team], text=paste(displayName, round(currscore, 1)), col=colors[i], line=0.5, las=2, cex=TEXTSIZE)
    print(paste(team, colors[i]))
}
