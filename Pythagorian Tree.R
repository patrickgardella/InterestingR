library("grid")
l=0.15 #Length of the square
grid.newpage()
gr <- rectGrob(width=l, height=l, name="gr") #Basic Square
pts <- data.frame(level=1, x=0.5, y=0.1, alfa=0) #Centers of the squares
for (i in 2:10) #10=Deep of the fractal. Feel free to change it
{
  df<-pts[pts$level==i-1,]
  for (j in 1:nrow(df))
  {
    pts <- rbind(pts, 
                 c(i, 
                   df[j,]$x-2*l*((1/sqrt(2))^(i-1))*sin(df[j,]$alfa+pi/4)-0.5*l*((1/sqrt(2))^(i-2))*sin(df[j,]$alfa+pi/4-3*pi/4), 
                   df[j,]$y+2*l*((1/sqrt(2))^(i-1))*cos(df[j,]$alfa+pi/4)+0.5*l*((1/sqrt(2))^(i-2))*cos(df[j,]$alfa+pi/4-3*pi/4),                  
                   df[j,]$alfa+pi/4))
    pts <- rbind(pts, 
                 c(i, 
                   df[j,]$x-2*l*((1/sqrt(2))^(i-1))*sin(df[j,]$alfa-pi/4)-0.5*l*((1/sqrt(2))^(i-2))*sin(df[j,]$alfa-pi/4+3*pi/4), 
                   df[j,]$y+2*l*((1/sqrt(2))^(i-1))*cos(df[j,]$alfa-pi/4)+0.5*l*((1/sqrt(2))^(i-2))*cos(df[j,]$alfa-pi/4+3*pi/4),                  
                   df[j,]$alfa-pi/4))
  }
}
for (i in 1:nrow(pts))
{
  grid.draw(editGrob(gr, vp=viewport(x=pts[i,]$x, y=pts[i,]$y, w=((1/sqrt(2))^(pts[i,]$level-1)), h=((1/sqrt(2))^(pts[i,]$level-1)), angle=pts[i,]$alfa*180/pi), 
                     gp=gpar(col=0, lty="solid", fill=rgb(139*(nrow(pts)-i)/(nrow(pts)-1), 
                                                          (186*i+69*nrow(pts)-255)/(nrow(pts)-1), 
                                                          19*(nrow(pts)-i)/(nrow(pts)-1), 
                                                          alpha= (-110*i+200*nrow(pts)-90)/(nrow(pts)-1), max=255))))
}