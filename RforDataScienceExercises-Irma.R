### Purpose of the script: to help Irma improve R skill. It contains exercises from the ebook 
# 'R for Data Science" https://r4ds.had.co.nz/index.html


## Source: Section 3.2.4 First steps


install.packages("nycflights13")


# Exercises:
# 1. Run ggplot(data=mpg). What do you see?

library(tidyverse)
ggplot(data = mpg)

# Answer: nothing, but an empty in plots area.

# 2. How many rows are in mpg? How many columns?
# Answer: 234 rows and 11 columns

# 3. What does the drv variable describe? Read teh help for ?mpg to find out.
# Answer: drv is the type of drive train, f=front-wheel drive, r= rear wheel drive, 4=4wd.

# 4. Make a scatterplot of hwy vs cyl.
ggplot(data=mpg) +
  geom_point(mapping = aes(x=hwy, y= cyl))

# 5. What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data=mpg) +
  geom_point(mapping = aes(x=class,y=drv))
# It is not useful because drv and class are not neccssarily related. 





## Source: Section 3.3.1 Aesthetic mappings.


# Exercises:
# 1. What's gong wrong with this code? Why are the points not blue?
# ggplot (data=mpg) +
#    geom_point(mapping = aes (x=displ, y= hwy, color ="blue"))
# Answer: because color is not a variable in this case, so it should not in the aes function, but in ggplot function, which gives the property of a variable.  

library(tidyverse)
ggplot(data = mpg) +
    geom_point(mapping = aes(x=displ,y=hwy),color="blue")
               
# 2. Which variables in mpg are categorical? Which variables are continuous? How can you see this information when you run mpg?
# Answer: run?mpg to read. or use summary and head to see this df. In summary, with if mode is character, then this should be a categorical variable.
# Variables are continuous if they are numbers.
summary(mpg)
head(mpg)

# 3. Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical vs. continuous variables?
# Answer: the difference will be there's no linear/regression in categorical variables.
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy,color = year))
ggplot(data=mpg) +
  geom_point(mapping = aes(x=model,y=class,color=manufacturer))

# 4. What happens if you map the same variable to multiple aesthetics?
# Answer: it will be the same aesthetics, because same variable has same locations.

# 5. What does the stroke aesthetic do? What shapes does it work with?
# Answer: stroke aesthetic is to modify the width of the border of a variable in ggplot
ggplot(mpg,aes(displ,hwy))+
  geom_point(shape=21,color="blue",fill="yellow",size=5,stroke=2)
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ,y=hwy),stroke=2,color="blue")

# 6. What happens if you map an aesthetic to something other than a variable name, like aes(colour=displ<5)? Note, you'll also need to specify x and y.
# Answer: It will divide the variables into two colors, one is displ>=5, the other is <5.

ggplot(data=mpg)+
  geom_point(mapping = aes(x=hwy,y=cty,color=displ<5))





## Source: Section 3.5.1 Facets

# 1. What happened if you facet on a continuous variable?
# Answer: it will be a kind of too much, the continous variable will be transfered to categorical like and this will be too much.
ggplot(mpg,aes(displ,hwy))+
  geom_point(color="orange")+
  facet_grid(cyl~cty)
             
# 2. What do the empty cells in plot with facet_grid(drv~
#   cyl) mean? How do they relate to this plot?
# Answer: I think it just means that it doesn't have any variable in those
# points. It is the same empty area on facet. 
ggplot(data=mpg)+
  geom_point(mapping = aes(x=drv,y=cyl))
ggplot(mpg,aes(displ,hwy))+
  geom_point()+
  facet_grid(drv~cyl)

# 3. What plots does the following code make? What does . do?
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(drv ~.)

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(. ~ cyl)
# Answer: I think . positions the horizontal and vertical display of the plot. the facet varible(cyl)
# is on the top (horizontally alligned) of the plot, if with . at the beginning, and vice versa for drv.

# 4.Take the first faceted plot in this section:
ggplot(data=mpg)+
  geom_point(mapping= aes(x=displ,y=hwy))+
  facet_wrap(~ class,nrow=2)
# What are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages?
# How might the balance change if you had a larger dataset?

# Answer: I think using faceting gives a tidier organized visual look, especially with larger dataset. 
# Colour aesthetic is useful when dataset is not too big when people can see individual points and colors.
# It could be a disaster with too many data with different colours so the whole plot became colour clusters. 
# The disadvantages of using facets are with smaller number of data, or bigger number of catigories(more than 10).
# To balance out, I think facet is best used in smaller categories and with large number of data.

# 5. Read ?facet_wrap. What does nrow do? What does ncol do? What other options control the layout of the 
# individual panels? Why doesn't facet_grid have nrow and ncol arguments?

# Answer: nrow and ncol are the number of rows and columns of the panels displied on the plot.Other options  
# includes: labeller ( to label each facets), as.table (whether facets are laid out like tables), dir (h or v direction)
# Facet_grid doesn't have nrow or ncol because: 1, layout can be changed to vertical or horizontal by using . 2, it may have 
# two variables used in facets so number of coloums and rows are defined by variables.

# 6. When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?
# I think its probably depends on the data set, when I have more unique levels I'll try to make it more clear by giving 
# bigger space, which is more columns as I can always use landscape format for plots.






## Sources: Section 3.6.1 Geometric objects

# 1. What geom would you use to draw a line chart? A boxplot? A histogram? An area Chart?
# Answer: geom_smooth()


# 2. Run this code in your head adn predict what the output will look like. Then, run the 
# code in R and check your predictions.
# Answer: geom_smooth gives a line connets most of the points.
ggplot(data=mpg,mapping = aes(x=displ,y=hwy,color=drv)) +
  geom_point()+
  geom_smooth(se=FALSE)
  

# 3. What does show.legend = FALSE do? What happens if you remove it?
# Why do you think I used it earlier in the chapter?
# Answer: show.legend = FALSE removes of the legend of drv colors. You removed it because you 
# want to avoid confusion. You're comparing three groups together, and color code doesn't 
# apply the other two. 


# 4. What does the se argument to geom_smooth() do?
# Answer: se is standard error, the default is TRUE, so adding it shows the shadow around 
# the lines and gives the range of the variables.


# 5. Will these two graphs look different? Why/Why not?
ggplot(data=mpg, mapping = aes(x=displ,y=hwy)) +
  geom_point() +
  geom_smooth()

ggplot() + 
  geom_point(data=mpg, mapping = aes(x=displ,y=hwy)) +
  geom_smooth(data=mpg, mapping = aes(x=displ,y=hwy))

# Answer: no, they look the same. The first code is designed to be more concise.

# 6. Recreate the R code necessary to generate the following graphs.

ggplot(mpg,aes(displ,hwy))+
  geom_point()+
  geom_smooth(se=FALSE)
 
ggplot(mpg,aes(displ,hwy,group=drv))+
  geom_point()+
  geom_smooth(se=FALSE)

ggplot(mpg,aes(displ,hwy,color=drv),show.legend=TRUE)+
  geom_point()+
  geom_smooth(se=FALSE)

ggplot(mpg,aes(displ,hwy)) +
  geom_point(aes(color=drv),show.legend=TRUE) +
  geom_smooth(se=FALSE)

ggplot(mpg,aes(displ,hwy)) +
  geom_point(aes(color=drv),show.legend=TRUE) +
  geom_smooth(aes(linetype=drv),se=FALSE)

ggplot(mpg,aes(displ,hwy)) +
  geom_point(size=3,stroke=1,color="white") +
  geom_point(aes(color=drv))
 




## Source: Section 3.7 Statistical transformations

# 1. What is the default geom associated with stat_summary()? How could you rewrite the 
# previous plot to use that geom function instead of the stat function?

# Answer: According to the definition of stat_summary(), I think the default geom 
# is "pointrange". 
ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth  ),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth ),
    stat = "summary",
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
    )

### Here is what I have question, though I defined the endpoints with ymax and ymin, but it 
### doesn't show on the plot.


# 2. What does geom_col() do? How is it different to geom_bar()?

# Answer: geom_col() is to create bar chart with the heights of the bars to represet values 
# in the data, while geom_bar() makes teh height of the bar proportional to the nuomber of 
# cases in each group.


# 3. Most geoms and stats come in pairs that are almost always used in concert. Read through
# the documentation and make a list of all the pairs. What do they have in common?

# Answer: stat_bin == geom_histogram, geom_freqpoly
#         stat_count == geom_bar
#         stat_density == geom_density
#         stat_smooth == geom_smooth

# 4. What variable does stat_smooth() compute? What parameters control its behaviour?

# Answer: the varibles stat_smooth computes are: y (predicted value), ymin (lower pointwise
# confidence interval around the mean), ymax (upper pointwise confidence interval around the
# mean), se (standard error). Parameters that controls the behavior: formula, 


# 5. In our proportion bar chart, we need to set group=1. Why? In other words what is the 
# problem with these two graphs?

ggplot(data=diamonds) +
  geom_bar(mapping = aes(x=cut,y=..prop..))
ggplot(data=diamonds) +
  geom_bar(mapping = aes(x=cut,fill=color,y=..prop..))

# Answer: if we don't set group=1, it means every bar/coloum is one, whcih defeat the purpose of proportion.

ggplot(data=diamonds) +
  geom_bar(mapping = aes(x=cut,y=..prop..,group=1))
ggplot(data=diamonds) +
  geom_bar(mapping = aes(x=cut,y=..count../sum(..count..),fill = color))


## Source: Section 3.8 Postition adjustments

# 1. What is the problem with this plot? How could you improve it?

ggplot(data=mpg,mapping = aes(x=cty,y=hwy)) +
  geom_point()

# Answer: the problem is overploting with overlapping observations . Imparove code is:

ggplot(data=mpg,mapping = aes(x=cty,y=hwy)) +
  geom_jitter()

# 2. What parameters to geom_jitter() control the amount of jittering?

# Answer: width and height: amount of horizontal and vertical jitter. The jitter is added in both
# positive and negative directions, so the total sprea is twice teh value specified (40%).

ggplot(data=mpg,mapping = aes(x=cty,y=hwy)) +
  geom_jitter(width = 0.8,height = 0.8)

# 3. Compare contrast geom_jitter with geom_count

# Answer: they both identified all observations but in different way. geom_jitter gives extra dimentions 
# on observations and change their position a bit. geom-count gives the total number of the observations 
# and and no position change.
ggplot(data=mpg,mapping = aes(x=cty,y=hwy)) +
  geom_jitter()
ggplot(data=mpg,mapping = aes(x=cty,y=hwy)) +
  geom_count()


# 4. What's the default position adjustment for geom_boxplot()? Create a visualisation of the mpg dataset
# that demonstrates it.

# Answer: default position adjustment for geom_bosplot() is dodge2, which doesn't overlap each other.

ggplot(data = mpg,mapping=aes(x=cty,y=hwy,fill=drv))+
  geom_boxplot(position = "dodge")

ggplot(data=mpg)+
  geom_boxplot(mapping=aes(x=cty,y=hwy,fill=drv))
  






## Source: Section 3.9 Coordinate system

# 1.Turn a stacked bar chart into a pie chart using coord_polar.

ggplot(data = mpg) +
  geom_bar(mapping = aes(drv,fill=drv),
           show.legend = FALSE,
           width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x=NULL,y=NULL) +
  coord_polar()


# 2. What does labs() do? Read the documentation.

# Answer: labs() changes axis, legend and plot lables.
ggplot(data = mpg) +
  geom_bar(mapping = aes(drv,fill=drv),
           show.legend = FALSE,
           width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x="drv",y=NULL, title = "mpg") +
  coord_polar()

# 3. What's the difference between coord_quickmap() adn coord_map()?

# Answer: coord_quickmap is a quick approximation that dose preserve straight lines. It works best for 
# smaller areas closer to the equator. It sets the aspect ratio correctly for maps.
install.packages("maps")

library(maps)
nz <- map_data("nz")
ggplot(nz,aes(long,lat,group =group))+
  geom_polygon(fill="white",colour="black")
ggplot(nz,aes(long,lat,group =group))+
  geom_polygon(fill="white",colour="black")+
  coord_quickmap()

# 4. What does the plot below tell you about the relationship between city and highway mpg? Why is 
# coord_fixed() important? What does geom_abline() do?

ggplot(data = mpg,mapping = aes(x=cty,y=hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed()
# Answer: coord_fixed () fixes the geom_abline at 45 degree,so we can have better visual understanding 
# of the dataset. 






## Source: Section 4.4 'R for Data Science"


# Exercises: Tweek each of the following R commands so taht they run correctly

# library(tidyverse)
# ggplot(dota=mpg) +
#             geom_point(mapping=aes(x=displ,y=hwy))
# filter(mpg,cyl=8)
# filter(diamond,carat>3)

# Tweaked answers:

ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy))

filter(mpg,cyl==8)

filter(diamonds,carat>3)






## Source: Section 5.2 Filter rows with filter()

library(nycflights13)
library(tidyverse)

# 1. Find all flights that
# 1.1 Had an arrival delay of two or more hours
filter(flights,arr_delay>120)
# 1.2 Flew to Houston (IAH or HOU)
filter(flights,dest =="HOU" | dest =="IAH" )
# 1.3 Were operated by United, American, or Delta
filter(flights,carrier == "United" | carrier == "American" | carrier == "Delta")
# 1.4 Departed in summary (July,August,and September)
summary(filter(flights,month %in% c(7,8,9)))
# 1.5 Arrived more than two hours late, but didn't leave late
filter(flights,arr_delay >120 & dep_delay<=0)
# 1.6 Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights,dep_delay>=60 & dep_delay - arr_delay >30)

# 1.7 Departed between midnight and 6am (inclusive)
filter(flights,  dep_time<= 600 | dep_time >=2400)
       

# 2. Another useful dplyr filtering helper is between(). What does it do? Can you use it
# to simplify the code needed to answer the previous challenges?

# Answer: between(x,left,right) is x>= left and x<= right. Question 1.7
filter(flights,!between(dep_time,600,2400))

# 3. How many flights have a missing dep_time? What other variables are missing? What might
# these rows represent?
summary(flights$dep_time)
# 8255 flights have missing dep_time.
view(filter(flights,is.na(dep_time)))
# dep_delay, arr_time and other 3. It could mean those flights were cancled.

# 4. Why is NA^0 not missing? Why is NA|TRUE not missing? WHy is FALSE&NA not missing? 
# Can you figure out the general rule? 

# Because in math caluation, anything power 0 is 1. NA|TRUE means either NA or TRUE, so either way is 1.
# NA&FALSE is 1 because a FALSE is a FALSE, so is 1.





## Source: Section 5.3 Arrange rows with arrange()

# 1. How could you use arrange() to sort all missing values to the start? 

arrange(flights,desc(is.na(dep_time)))

# 2. Sort flights to find the most delayed flights. Fingd the flights that left earliest.

arrange(flights,desc(dep_delay))

# 3. Sort flights to find the fastest (highest speed) flights.

summary(flights)
flights_speed <- mutate(flights,distance/air_time)
arrange(flights_speed,desc(distance/air_time))

# 4. Which flights travelled the farthest? Which travelled the shortest?

arrange(flights,distance)






## Source: Section 5.4 Select columns with select()

# 1.Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time
# and arr_delay from flights.
select(flights,dep_time,dep_delay,arr_time)
select(flights,"dep_time","dep_delay","arr_time")
select(flights,matches("dep_time","dep_delay","arr_time"))
select(flights,contains("dep_time"),contains("dep_delay"),contains("arr_time"))
select(flights,one_of("dep_time","dep_delay","arr_time"))

# 2. What happens if you include the name of a variable multiple times in a select() call?
# Answer: it will only show up once.


# 3. What does the one_of() function do? why might it be helpful in conjunction with this vector?
vars <- c("year","month","day","dep_delay","arr_delay")
# Answer: one_of() function can act as "or" when selecting useful variables.


# 4. Does the result of running the following code surprise you? How do the select helpers
# deal with case by default? How can you change the default?
select(flights,contains("TIME"))

# Answer: contains() function does not recognize case, which is rare in R because R is case sensitive.
# The default of constains() is ignore.case=TRUE, so I think change that to FALSE should work.






## Source: Section 5.5: Add new variables with mutate()

# 1. Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with because
# they're not really continuous numbers. Convert them to a more convenient representation of number of
# minutes since midnight.

transmute(flights,new_dep_time = (dep_time%/%100)*60+dep_time%%100, 
          new_sched_dep_time=(sched_dep_time%/%100)*60 +sched_dep_time%%100)

# 2. Compare air_time with arr_time - dep_time. What do you expect to see? What do you see? 
# What do you need to do to fix it?
# Answer: I expect air_time is the difference between arr_time and dep_time.
travel_time<-transmute(flights,arr_time,dep_time,((arr_time%/%100)*60+arr_time%%100)-((dep_time%/%100)*60+dep_time%%100),air_time)
View(travel_time)
# Answer: I don't see air_time is actually is the difference between arr_time and dep_time. I wonder the
# definition of air_time. I also speculate my calculation does not relect time zone and midnight flights.
# For time zone, I'll need to consider the departure and arrival airport, and define the time zone difference. 
# For midnight flights, I'll be careful with those and redecide arr_time so it should be bigger 
# than dep_time.

# 3. Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?

# Answer: I suppose de_delay is the difference between sched_dep_time and dep_time. I think midnight flights 
# are where I have the number difference.

filter(flights,dep_time,sched_dep_time,dep_delay)
delayed_flights<-transmute(flights,dep_delay,((dep_time%/%100)*60+dep_time%%100)-((sched_dep_time%/%100)*60+sched_dep_time%%100))
View(delayed_flights)
# 4. Find the 10 most delayed flights using a ranking function. How do you want to handle ties? Carefully
# read the documentation for min_rank().

delay_flights <- select(flights,arr_delay)
rank <- min_rank(delay_flights)
most_delay_flights<-mutate(flights,rank)

view(most_delay_flights)

# 5. What does 1:3 + 1:10 return? Why?
1:3 +1:10
# it shows" Warning message: 
# In 1:3 + 1:10 :
# longer object length is not a multiple of shorter object length."
# Answer: I think it might be because 1:3 is included in 1:10, so R does kind of loop addition, so it gives 
# a warning message that coder can check if circled addition is what they want.


# 6. What trigonometric functions does R provide?

# R provides cos(x),sin(x),tan(x); acos(x),asin(x),atan(x),atan2(y,x); cospi(x),sinpi(x),tanpi(x)







## Source: Section 5.6: Grouped summaries with summaries()


# 1. Brainstorm at least 5 different ways to assess the typical delay characteristics of a group of flights. 
# Consider the following scenarios:
# - A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.
# - A flight is always 15 minutes late.
# - A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
# - 99% of the time a flight is on time. 1% of the time it's 2 hours late.
# Which is more important: arrival delay or departure delay?

# Answer: I think arrival delay is more important for passengers, pilots and crew members, departure delay 
# is more important for airports and carriers.


# 2.Come up with another approach that will give you the same output as not_cancelled %>% count(dest) and 
# not_cancelled %>% count(tailnum, wt=distance) (without using count()).

not_cancelled <- flights %>% filter(!is.na(dep_delay),!is.na(arr_delay))
not_cancelled %>% count(dest)
not_cancelled %>% count(tailnum,wt=distance)

# Answer:
not_cancelled %>% group_by(dest) %>% summarise(n=n())
not_cancelled %>% group_by(tailnum) %>% summarise(n=sum(distance))

# 3. Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay)) is slightly suboptimal. Why?
# Which is the most important column?

# Answer: I think our definition does not include the situations when flights that have departure time but 
# not arrival time, such as plane retures to departure airports, or lands to another airports due to weather
# or other cicumstantces. Using arr_delay could be more accurate in that sense.

# 4. Look at the number of cancelled flights per day. Is there a pattern? Is the proportion of cancelled 
# flights related to the average delay?


cancelled_daily <- flights %>%
  group_by(year,month,day) %>% 
  mutate(cancelled=is.na(dep_delay),is.na(arr_delay)) %>% 
  summarise(cancelled_flights=sum(cancelled),flights=n()) %>% 
  ungroup()
  
ggplot(cancelled_daily) +
  geom_point(mapping = aes(x=flights,y=cancelled_flights))

view(cancelled_daily)


cancelled_and_delay <-
  flights %>% 
  group_by(year,month,day)
  mutate(cancelled=is.na(dep_delay),is.na(arr_delay)) %>%
  summarise(cancelled_flights=tally(cancelled),
            delay_flights=sum(arr_delay)) %>% 
  ungroup()

** I still can't figure out why this code doesn't run.
  
# 5. Which carrier has the worst delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers?
# Why/why not? (Hint: think about flights %>% group_by(carrier,dest) %>% summarise(n()))

delays_carrier<- flights %>% 
  group_by(carrier) %>% 
  mutate(delay_flights=!is.na(arr_delay)) %>% 
  summarise(number_of_delays=sum(delay_flights),flights=n()) %>% 
  ungroup()
view(delays_carrier)

# Answer: 9E carrier is the worst since it has the highest number of delays

delays_airports<- flights %>% 
  group_by(origin,dest) %>% 
  mutate(delay_flights=!is.na(arr_delay)) %>% 
  summarise(number_of_delays=sum(delay_flights),flights=n()) %>% 
  ungroup()

View(delays_airports)
# JFK(origin), LUX(dest)
# 6. What does the sort argument to count() do. When might you use it?

# Count() is used for summarising that will call n() but calls group_by() before adn ungroup() after. 



  












## Source: Section 5.7 Grouped mutates (and filters)

# 1. Refer back to the lists of useful mutate and filtering functions. Describe how each operation 
# changes when you combine it with grouping.



# 2. Which plane (tailnum) has the worst on-time record?

worst_plane <- flights %>% 
  group_by(tailnum,year) %>% 
  filter(rank(desc(arr_delay))<10) %>% 
  ungroup()
view(worst_plane)
# Answer: N384HA

# 3. What time of day should you fly if you want to avoid delays as much as possible?

worst_time<- flights %>% 
  group_by(hour) %>% 
  summarise(arr_delay = mean(arr_delay,na.rm = TRUE)) %>% 
  ungroup()
view(worst_time)

# Answer: 9pm

# 4. For each destination, compute the total minutes of delay. For each flight, compute 
# the proportion of hte total delay for its destination.

delay_dest <-  flights %>% 
  group_by(dest) %>%
  filter(arr_delay>0) %>% 
  mutate(arr_total_delay_min = sum(arr_delay),
         arr_delay_prop =arr_delay / sum(arr_delay))%>% 
  select(dest,year,month,day,flight,arr_delay) %>% 
  ungroup()
  
view(delay_dest)


# 5. Delays are typically temporally correlated: even once the problem that caused the 
# initial delay has been resolved, later flights are delayed to allow earlier flights to 
# leave. Using lag(), explore how the delay of a flight is related to the delay of the 
# immediately preceding flight.

delay_lag <- flights %>% 
  group_by(origin,dep_time,flight) %>% 
  transmute(dep_delay_lag = lag(dep_delay)) %>% 
  na.omit() %>% 
  ungroup()
  
view(delay_lag)

# 6. Look at each destination. Can you find flights that are suspiciously fast?(i.e.flights
# that represent a potential data entry error). Compute the air time of a flight relative to 
# the shortest flight to that destination. Which flights were most delayed in the air?
 

ggplot(data=flights,mapping=aes(x=distance,y=air_time))+
  geom_point()+
  geom_smooth(se=FALSE)
# Answer: anthing if too above the line could be suspiciously fast
flight_speed <- flights %>% 
  mutate(speed=distance/air_time) %>% 
  arrange(desc(speed)) %>% 
 select(speed,flight,carrier,origin,dest,dep_time,arr_time,air_time,distance)
view(flight_speed)

ggplot(flight_speed)+
  geom_point(mapping=aes(x=speed,y=distance))
# Answer: from the graph, speed is higher than 9 could be very suspiciously fast.

# 7. Find all destinations that are flown by at least two carriers. Use that information
# to rank the carriers.

dest_carriers <- flights %>% 
  group_by(dest) %>% 
  mutate(num_carriers=n_distinct(carrier)) %>% 
  filter(num_carriers >=2) %>% 
  group_by(carrier) %>% 
  summarize(num_dest=n_distinct(dest)) %>% 
  ungroup()

view(dest_carriers)


# 8. For each plane, count the number of flights before the first delay of greater than 1 hour. 








## Source: Section 7.3 Variation


# 1. Explore the distribution of each of the x,y,and z variables in diamonds. What do you learn?
# Think about a diamond and how you might decide which dimension is the length, width, and depth.

ggplot(diamonds)+
  geom_freqpoly(mapping = aes(x= x),color="red")+
  geom_freqpoly(mapping = aes(x = y), color= "blue")+
  geom_freqpoly(mapping = aes(x=z),color="yellow")

ggplot(diamonds) +
  geom_freqpoly(mapping = aes(x = x))
ggplot(diamonds) +
  geom_freqpoly(mapping = aes(x = y))
ggplot(diamonds) +
  geom_freqpoly(mapping = aes(x = z))

summary(filter(diamonds,x,y,z))

# Answer: Looks like x and y are in the similar range and count distribution, but z has different
# distribution than x and y. There're possible errors on the max values for y and z.

# 2. Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: 
# Carefully think about the binwidth and make sure you try to wide range of values.)

ggplot(diamonds,mapping = aes(x = price)) +
  geom_histogram(binwidth = 10)

# Answer: there's no price around $1300. Most of the price are lower than 5000.

# 3. How many diamonds are 0.99 carat? How many are 1 carat? What do you think is the cause
# of the difference?

count_diamonds_are_0.99 <- diamonds %>% 
filter(carat == 0.99) %>% 
  count(carat)
view(count_diamonds_are_0.99)
count_diamonds_are_1 <- diamonds %>% 
  filter(carat == 1) %>% 
  count(carat)
view(count_diamonds_are_1)

# Answer: there're 23 diamonds are 0.99 carat, 1558 diamonds are 1 carat. I'm thinking of 
# may be 1 carat is a very important level for diamonds?

# 4. Compare and contrast coord_cartesian() vs xlim() or ylim() when zooming in on a histogram.
# What happens if you leave binwith unset? What happens if you try and zoom so only half a bar shows?

ggplot(diamonds)+
  geom_histogram(mapping = aes(x=x))+
  coord_cartesian()

ggplot(diamonds)+
  geom_histogram(mapping = aes(x=x))+
  coord_cartesian(xlim=c(0,12),ylim=c(0,100))

ggplot(diamonds)+
  geom_histogram(mapping = aes(x=x),binwidth = 1.5)+
  coord_cartesian(xlim=c(0,12),ylim=c(0,100))

# Answer: coord_cartesian() shows the whole range of the dataset, xlim() or ylim() gives a limit on what to show.
# The binwith seems affects the shape of the graph alot. 1.5 binwith shows more details of x count 
# when x is smaller.the system automatically uses bins=30, which is the same when setting binwidth = 0.3.








## Source: Section 7.4 Missing values

# 1. What happens to missing values in a histogram? What happens to missing values in a bar chart? Why is there a difference?

# Answer: geom_histogram() and geom_bar() will show warning that 9 rows containing unusual value are removed. 

diamonds2 <- diamonds %>% 
  mutate(y=ifelse(y<3|y>20,NA,y))

ggplot(diamonds2) +
  geom_histogram(mapping = aes(x=y),binwidth = 0.3)

ggplot(diamonds2)+
  geom_bar(mapping = aes(x=y))

# 2. What does na.rm = TRUE do in mean() and sum()?

# Answer: it will not calculate the missing data.








## Source: Section 7.5.1 Categorical and continuous variable Covariation

# 1. Use what you've learned to improve the visualisation of hte departure times of cancelled vs. non-cancelled flights.

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) +
  geom_freqpoly(mapping = aes(colour = cancelled),binwidth=1/4)

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
ggplot(mapping = aes(x=cancelled,y=sched_dep_time))+
geom_boxplot()

# 2. What variable in the diamonds dataset is most important for predicting the price of a diamond? How
# is that variable correlated with cut? Why does the combination of those two relationships lead to lower
# quality diamonds being more expensive?

summary(diamonds)
ggplot(data = diamonds, mapping = aes(x=clarity,y=price))+
  geom_boxplot()
ggplot(data = diamonds, mapping = aes(x=cut,y=price))+
  geom_boxplot()
ggplot(data = diamonds, mapping = aes(x=color,y=price))+
  geom_boxplot()
ggplot(data = diamonds, mapping = aes(x=price,y=carat))+
  geom_boxplot()

ggplot(data = diamonds, mapping = aes(x=cut,y=clarity))+
  geom_point()
ggplot(data = diamonds, mapping = aes(x=cut, y= color)) +
  geom_point()
ggplot(data = diamonds, mapping = aes(x=clarity, y= price, color=cut)) +
  geom_boxplot()
# Answer: From each plot above, the price could correlate with clarity and color. They don't correlate with 
# cut very much, because they are all categorical variables.

# 3. Install the ggstance package, and create a horizontal boxplot. How does this compare to using coord_flip()?

install.packages("ggstance")
library(ggstance)

ggplot(mpg) +
  geom_boxplot(mapping = aes(y=reorder(class,hwy,FUN = median),x=hwy)) 

# Answer: with ggstance, it allows to switch x and y axis, which could be difficult to do with coord_flip().

# 4. One problem with boxplots is that they were developed in an area of much smaller datasets and tend to 
# display a prohibitively large number of "outlying values". One approach to remedy this problem
# is the letter value plot. Install the lvplot package, and try using geom_lv() to display the distribution
# of price vs cut. What do you learn? How do you interpret the plots?

install.packages("lvplot")
library(lvplot)
ggplot(diamonds,mapping = aes(x=cut,y=price)) +
  geom_lv()
ggplot(diamonds,mapping = aes(x=cut,y=price)) +
  geom_point()
ggplot(diamonds,mapping = aes(x=cut,y=price)) +
  geom_boxplot()  

# Answer: geom_lv gives more direct vision of the distributions of data. 

# 5. Compare and contrast geom_violin() with a facetted geom_histogram(), or a coloured geom_greqpoly(). What 
# are the pros and cons of each method?

ggplot(diamonds, mapping = aes (x= cut, y= price, color=clarity))+
  geom_violin()

ggplot(diamonds, mapping = aes (x= price, color=clarity))+
  geom_histogram()+
  facet_wrap(~cut,nrow=1)

ggplot(diamonds, mapping = aes (x= price, color= cut))+
  geom_freqpoly()

# Answer: all of them give a direct vision on the distributions of data. I think with facet you can put more 
# parameters; with geom_violin I used 3 parameters (but it's not too good); I can only put 2 parameters for freqpoly

# 6. If you have a small dataset, it's sometimes useful to use geom_jitter() to see the relationship between 
# a continuous and categorical variable. The ggbeeswarm package provides a number of methods similar to geom_jitter()
# List them and briefly describe what each one does.

ggplot(diamonds, mapping = aes (x= cut, y= price))+
  geom_jitter()
# Answer: geom_jitter() is like a bars with different distributions of price
install.packages("ggbeeswarm")
library(ggbeeswarm)

ggplot(diamonds, mapping = aes(x= cut, y = price)) +
  geom_beeswarm()
# Answer: my computer refuses to run geom_beeswarm with this diamonds dataset.But it should be something between 
# geom_jitter and geom_quasirandom
ggplot(diamonds, mapping = aes(x= cut, y = price)) +
  geom_quasirandom()
# Answer: geom_quasirandom() is like a solid geom_violin






## Source: 7.5.2 Two categorical variables

# 1. How could you rescale the count dataset above to more clearly show the distribution of cut witin colour,
# or colour within cut?

diamonds %>% 
  count(color,cut) %>% 
ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))

diamonds %>% 
  count(color,cut) %>% 
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n),color="yellow")

# 2. Use geom_tile() together with dplyr to explore how average flight delays vary by destination and month of year.
# What makes the plot difficult to read? How could you improve it?

flights %>% 
  group_by(dest, month) %>% 
  select(arr_delay) %>% 
  ggplot(mapping=aes(x=month,y=dest,fill=arr_delay))+
  geom_tile()

install.packages("heatmaply")
library(heatmaply)

flights %>% 
  group_by(dest, month) %>% 
  select(!is.na(arr_delay)) %>%  
heatmaply()


# 3. Why is it slightly better to use aes(x = color, y = cut) rather than aes (x = cut, y = color) in the example above?

diamonds %>% 
  count(cut,color) %>% 
  ggplot(mapping = aes(x = cut, y = color)) +
  geom_tile(mapping = aes(fill = n))

# Answer: I can't really think why this is slightly better. May be because color is on y axis gives better understanding?









## Source 7.5.3 Two continuous variables

# 1. Instead of summarising the conditional distriution with a boxplot, you could use a frequency polygon. What do you 
# need to consider when using cut_width() vs cut_number()? How does that impact a visulisation of the 2d distribution
# of carat and price?

# Answer: cut_width() is to use bin width, which will give a more evenly divided bin width; while cut_number() is to use 
# number of bins, which could cause unevenly distributed bin width. 

smaller <- diamonds %>% 
  filter(carat <3)
ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping=aes(group=cut_width(carat,0.1)))
ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping=aes(group=cut_number(carat,20.1)))

# 2.Visualise the distribution of carat, partitioned by price.

ggplot(diamonds, mapping = aes(x=carat,y=price))+
  geom_boxplot(mapping=aes(group=cut_number(price,10)))

ggplot(diamonds, mapping = aes(x=carat,y=price))+
  geom_boxplot(mapping=aes(group=cut_width(price,1500)))

# 3.How does the price distribution of very large diamons compare to small diamonds? Is it as you expect. or does it surprise you?

ggplot(data=diamonds, mapping = aes(x=price, y = carat))+
  geom_point()

# Answer: big carat diamonds are not always with higest price, this is to guess there must be other factors can affect price. 

# 4. Combine two of the techniques you've learned to visualise the combined distribution of cut, carat, and price.

ggplot(diamonds, mapping = aes(carat, price)) +
  geom_boxplot(mapping = aes(color = cut_width(price, 3000),group=cut_width(price,1500)))

# 5. Two dimensional plots reveal outliers that are not visible in one dimensional plots. For example, some points in the plot below
# have an unusual combination of x and y values, which makes the points outliers even though their x and y values appear normal when 
# examined separately.
ggplot(data=diamonds) +
  geom_point(mapping = aes(x = x, y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4,11))
# Answer: outliers are not clearly show in this plot, because it is very clear this plot shows a very strong corelation between x and y. 
#













## Source: Section 10. Tibbles
library(tidyverse)
# 1. How can you tell if an object is a tibble? (Hint: try printing mtcars, which is a regular data frame).

mtcars %>% 
  view()
is_tibble(mtcars)
# Answer: mtcars is not a tibble

# 2. Compare and contrast the following operations on a data.frame and equivalent tibble. What is the 
# different? Why might the default data frame behaviours cause you frustration?

df <- data.frame(abc = 1, xyz = "a")
df$x
df[,"xyz"]
df[, c("abc","xyz")]

tablee <- as_tibble(df)
tablee $ x
tablee[,"xyz"]
tablee[, c("abc","xyz")]

# Answer: [] function work differently in dataframe and tibble. With data frame, [ sometimes returns a data
# frame, and sometimes returns a vector. With tibble, [ always returns another tibble.

# 3. If you have the name of a variable stored in an object, e.g. var <- "mpg", how can you extract the 
# referecne variable from a tibble?

# Answer: to extract a single column use [[]]  or $


# 4. Practice referring to non-syntactic names in the following data frame by:
# 4.1. Extracting the variable called 1.
# 4.2. Plotting a scatterplot of 1 vs 2.
# 4.3. Creating a new column called 3 whcih is 2 divided by1.
# 4.4. Renaming the columns to one, two and three.

annoying <- tibble(
  `1` = 1:10,
  `2` = `1`* 2 + rnorm(length(`1`))
  )

# 4.1 
annoying[[1]]
annoying$`1`

# 4.2
ggplot(annoying,mapping = aes(x=`1`,y=`2`)) +
  geom_point()

# 4.3

annoying <- annoying %>% 
  mutate(`3`=`2`/`1`)

# 4.4 
annoying %>% 
  rename(one=`1`, two = `2`, three =`3`)

# 5. What does tibble:enframe() do? When might you use it?

# Answer: tibble:enfram() converts named atomic vectors or lists to one or tow column data frames. 
# I might use it when I want to have a dataframe from vector or vectors.

# 6. What option controls how many additional column names are printed at the footer of a tibble?

# Answer: in print(x,...n,width,n_extra) function, n_extra is to control number of extra columns to 
# print abb info for. if NULL, the default, will print information about at most tibble.max_extra_cols extra columns





## Source: Section 11.2 Data Import

# 1. What function would you use to read a file where fields were separated with "|"?

# Answer: read_delim() function with the argument delim="|". 

# 2. Apart from file, skip, and comment, what other arguments do read_csv() and read_tsv() have in common?

# Answer: I think is col_names = FALSE; na = "."

# 3. What are the most important arguments to read_fwf()?

# read_fwf(file, col_positions) file and col_positions are most important, for the rest arguments are set defaults.

# 4. Sometimes strings in a CSV file contain commas. To prevent them from causing problems they need to be
# surrounded by a quoting character, like " or '. By default, read_csv() assumes that the quoting character
# will be ". What argument to read_csv() do you need to specify to read the following text into a data frame?

"x,y\n1,'a,b'"

read_csv(file,quote="'")

x,y
1 a,b

# 5. Identify what is wrong with each of the following inline CSV files. What happens when you run the code?

read_csv("a,b\n1,2,3\n4,5,6")
# it does not show 3 and 6 

read_csv("a,b,c\n1, 2\n1,2,3,4")
# missing value under c column; 4 is droped 

read_csv("a,b\n\"1")
# missing value under b

read_csv("a,b\n1,2\na,b")
# it has two (a, b)

read_csv("a;b\n1;3")
# it does not recognize ;, so treats ";" as a character






## Source: Section 11.3 Parsing a vector

# 1. What are the most important arguments to locale()?

# Answer: locale(date_names = "en", date_format = "%AD", time_format = "%AT",
#       decimal_mark = ".", grouping_mark = ",") are important.

# 2. What happens if you try and set decimal_mark and grouping_mark to the same character? What happens to the 
# default vaule of grouping_mark when you set decimal_mark to ","? What happens to the default value of 
# decimal_mark when you set the grouping_mark to "."?

# Answer: it will group decimal mark so it changes the value. It will treat "," as decimal, and group it all, and vice verse.

# I didn't discuss the date_format and time_format options to locale(). What do they do? Construct an example that
# shows when they might be useful.

locale(data_names="en",date_format="%AD", time_format = "%AT")

# 4. If you live outside the US, create a new locale object encapsulates the settings for the types of file you read most commonly.

locale(data_name="Lingling", date_formate="y/m/d", time_format = "00:00",
       decimal_mark = ".", grouping_mark = ",")

# 5. What's the difference between read_csv() and read_csv2()?

# Answer: read csv2() is to read semicolon separated files, 
# read_csv () reads comma delimited files.

# 6. What are the most common encodings used in Europe? What are the most c

# Answer: Europe is ISO-8859, Asian (Chinese and Japanese) is UTF-16

# 7. Generate the correct format string to parse each of the following dates and times:
 
 d1 <- "January 1, 2010"
 d2 <- "2015-Mar-07"
 d3 <- "06-Jun-2017"
 d4 <- c("August 19 (2015)","July 1 (2015)")
 d5 <- "12/30/14" # Dec 30,2014
 t1 <- "1705"
 t2 <- "11:15:10:12 PM"
 
parse_date(d1,"%B %d %Y") 
parse_date(d2,"%Y-%b-%d")
parse_date(d3,"%d-%b-%Y")
parse_date(d4,"%B %d %Y")
parse_date(d5,"%m/%d/%y")
parse_time(t1,"%H%M")
parse_time(t2,"%H:%M:%H:%M %p")











## Source: Section 12.2 Tidy data

# 1.Using prose, describe how the variables and observations are organised in each of the sample tables.
table1 
# tibble 6 x 4: country, year, cases, population are coloumn names(4 variables); 6 obersvations(rows)
table3
table4a
table4b

# 2. Compute the rate for table2, and table4a + table4b. You will need to perform 4 operations:
# 2.1 Extract the number of TB cases per country per year.
# 2.2 Extract the matching population per country per year.
# 2.3 divide cases by population, and multiply by 10000.
# 2.4 Store back in the appropriate place.
# Which representation is easiest to work with? Which is hardest? Why?

table_4a_4b <- tibble(country = table4a$country,
                      tb_cases_cap_1999= 10000*table4a$`1999`/table4b$`1999`,
                      tb_cases_cap_2000= 10000*table4a$`2000`/table4b$`2000`)
table4a %>% 
  mutate(rate1999=table_4a_4b$tb_cases_cap_1999,rate2000=table_4a_4b$tb_cases_cap_2000) %>% 
  select(country,`1999`,rate1999,`2000`,rate2000)

# 3. Recreate the plot showing change in cases over time using table2 instead of tabel1. What do you need to do first?
# it seems I accidently redefined table2 in previous sections, so my table2 is not the table2 stored within R.








## Source: Section 12.3 Pivoting

# 1.Why are pivot_longer() and pivot-wider() not perfectly symmetrical? Carefully consider the following example:
stocks <- tibble(
  year = c(2015,2015,2016,2016),
  half = c(1,2,1,2),
  return = c(1.88, 0.59,0.92,0.17)
)
stocks
stocks %>% 
  pivot_wider(names_from = year,values_from = return) %>% 
  pivot_longer(`2015`:`2016`,names_to = "year",values_to = "return")

stocks %>% 
  pivot_wider(names_from = year,values_from = return) %>% 
  pivot_longer(`2015`:`2016`,names_to = "year",values_to = "return",names_ptypes = list(half=double()))

# Answer: pivot_longer has a names_ptype argument, e.g. names_ptype = list (year=double()). The tibble will re-arragnge 
# the format according to that function.

# 2. Why does this code fail?

table4a %>% 
  pivot_longer(c(1999,2000),names_to = "year",values_to = "cases")

# Answer: It says location 1999 and 2000 don't exist, so I'm guessing is not extrcting non-syntactic names correctly.

# 3. What would happen if you widen this table? Why? How could you add a new column to uniquely identify each value?

people <- tribble(
  ~name, ~names, ~values,
  #------/------/-----
  "Phillip Woods", "age", 45,
  "Phillip Woods", "height",186,
  "Phillip Woods", "age", 50,
  "Jessica Cordero", "age", 37,
  "Jessica Cordero", "height", 156
 )

people %>% 
  pivot_wider(names_from = names, values_from = values) 
  
# Answer: It looks like has two "phillip woods", and pivot_wider function cant solve this. By carefully assessing people
# tibble, I found the only unique name is their row numbers, so I mutate that into new tabble.

people
people %>% 
  mutate(id=row_number()) %>% 
  pivot_wider(names_from = names,values_from = values)

# 4. Tidy the simple tibble below. Do you need to make it wider or longer? What are the variables?
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)
preg %>% 
pivot_longer(c(male,female),names_to = "sex",values_to = "number")






## Source: Section 12.4 Separating and uniting

# 2. Both unite() and separate() have a remove argument. What does it do? Why would you set it to FALSE?

# Answer: remove imput column from output data frame, so it removes the old column. I may set it to FALSE
# because I may want to keep the old column.






## Source: Section 12.5 Missing values

# 2. What does the direction argument to fill() do?

# Answer: fill (data,...,direction =("down","up")), direction controls the value filled in with previous or next value.





## Source: Section 12.6 Case study

# 3. I claimed that iso2 and iso3 were redundant with country. Confirm this claim.

who %>% 
    distinct(who$iso2,who$country,who$iso3, keep_all = TRUE) 

# Answer: I used distinct function to remove duplicate rows in data frame.It showed 
# It showed 219 rows are left. If I use filter ( n >1), it should come out none. But 
# somehow my filter() givers me error like this :Error in n > 1 : comparison (6) is possible only for atomic and list types
   





## Source: Section 13:2 nycflights13

# 1.Imagine you wanted to draw (approximately) the route each plane flies from its origin to its destination. 
# Waht variables would you need? What tables would you need to combine?

# Answer: I'll need origin, faa, dest, dep_time, arr_time, tailnum. Tables I need: airports, flights, planes.






## Source: Section 13:3 Keys

# 1. Add a surrogate key to flights.

# Answer: I'm thinking to mutate a column with flight id by just using row numbers







## Source: Section 13:4 Mutating joins

summary(flights)

nycflights13::airports

# 2.

airports1 <- select(airports,"faa","lat","lon")

flights %>% 
  left_join(airports1, c("dest" = "faa")) %>% 
  left_join(airports1, c("origin" = "faa"))





## Source: Section 13:5 Filtering joins

summary(flights)

# 2.Flilter flights to only show flights with planes that have flown at least 100 flights.

 freq_flights <- flights %>%
   count(flight) %>% 
   filter(n >= 100)

freq_flights

flights %>% 
  semi_join(freq_flights)








## Source: Section 14.2 String basics

x <- c("Apple","Banana","Pear")
str_sub(x,1,1) <- str_to_lower(str_sub(x,1,1))
x







## Source: Section 14.3.1  Matching patterns with regular expressions

# 1. Explain why each of these strings don't match a \: "\", "\\", "\\\".

# Answer: if \ is used as an escape character in regular expression, I'll need to escape it, creating the regexp \\.
# To create that regex, I need to use a string, which also needs to escape\. 







# #Source: Section 14.3.2 Anchors

# 1. How would you match the literal string "$^$"?

# Answer: I'll need to escape them, such as "\\$\\^\\$"








## Source: Section 14.3.3 Character classes and alternatives

# 5. Create a regular expression that will match telephone numbers as commonly written in your country.

x <- c("123-4567-8910","12345-67890")
str_view(x,"\\d\\d\\d-\\d\\d\\d\\d-\\d\\d\\d\\d")





## Source: Section 14.3.4 Repetition

# 1. Describe the equvalents of ?,+,* in {m,n} form.

# Answer: {m,n} {m,} {,m} 







## Source: Section 14.3.5 Grouping and backreferences

# 1. Describe, in words, what these expressions will match:
# 1.1 (.)\1\1
# 1.2 "(.)(.)\\2\\1"
# 1.3 (..)\1
# 1.4 "(.).\\1.\\1"
# 1.5 "(.)(.)(.)*\\3\\2\\1"

# Answer: one letter repeats three times; 
#         two letters followed by reverse order
#         two letters repeat once;
#         one letter followed by another ltter, repeat that letter followed by a different letter, then repeat that letter
#         three letters folllowed by zero or more letters, followed by a reversed ordered three letters








## Source: Section 14.4.1 Detect matches

# 1.For each of the following challenges, try solving it by using both a single regexp, and a combination of multiple str_detect() calls.
# 1.1 Find all words that start or end with x.
words[str_detect(words,"^x|x$")]

words_start_x <- str_detect(words,"^x") 
  words_end_x <- str_detect(words,"x$") 
  words[words_start_x|words_end_x]




  
  
  
## Source: Section 14.4.2 Extract matches

# 2. From the Harvard sentences data, extract: 
# 2.1 the first word from each sentence.

length(sentences)

first_word <- str_extract(sentences,"(\\w+)")
head(first_word)




## Source: Section 14.4.3 Grouped matches

noun <- "(a|the)([^]+)"
has_noun <- sentences %>% 
  str_subset(noun) %>% 
  head(10)
has_noun %>% 
  str_extract(noun)
# 1. Find all words that come after a "number" like "one","two","three" etc. Pull out both the number and the word.

word_after_number <- "\b(one|two|three|four|five|six|seven|eight|night|ten)+([a-zA-Z_]+)"
str_detect(sentences,word_after_number)
sentences[word_after_number]
### still trying to figure out the above question
  







## Source: Section 14.4.4 Replacing matches

# 1.Replace all forward slashes in a string with backslashes.

str_replace_all("me/mine/I","/","\\\\")






## Source: Section 14.4.5 Splitting

# Split up a string like "apples,pears,and bananas"into individual components.

x <- c("apples, pears, and bananas") %>% 
  str_split(", ")
print(x)




## Source: Section 14.5 Other types of patternString

# 2. In your own words, describe the difference betwwen the sep and collapse arguments to str_c

# Answer: sep is to separate the string by putting in whatever characters defined by sep. collapse is 
# to combine input vectors into single string, default is NULL.







## Source: Section 14.7 Stringi

# 1. Find the stringi functions that:
# 1.1 Count the number of words.
# 1.2 Find duplicated strings.
# 1.3 Generate random text.

# Answer: 1.1 stri_count
#         1.2 stri_duplicated
#         1.3 stri_rand_strings









## Source: Section 15.3 General Social Survey

# 2.What is the most common relig in this survey? What's the most common partyid?

# The most common relig is Protestant, the most common partyid is Independent.

most_common_partyid <- gss_cat %>% 
  count(partyid, sort = TRUE)
most_common_partyid









## Source: Section 15.4 Modifying factor order

# 1. There are some suspiciously high numbers in tvhours. Is the mean a good summary?

# Answre: mean is the average value, so probably is not so precise if there're some high numbers.
# so median is probably good value to use










## Source: Section 15.5 Modifying factor levels

# 2.How could you collapse rincome into a small set of categories?

levels(gss_cat$rincome)
gss_cat %>% 
  mutate(
    rincome=fct_collapse(rincome,
                         "Unknown"= c("No answer","Don't know","Refused","Not applicable"),
                         "Lt $10000" = c("Lt $1000","$1000 to 2999","$3000 to 3999","$4000 to 4999","$5000 to 5999","$6000 to 6999","$7000 to 7999","$8000 to 9999"))
  ) %>% 
  ggplot()+
  geom_bar(mapping=aes(x=rincome))




## Source: Section 16.2 Creating date/times
library(lubridate)
# 2. What does the tzone argument to today() do? Why is it important?

# Answer: it's today's time zone.









## Source: Section 16.3 Date-time components

# 2.Compare dep_time, sched_dep_time and dep_delay. Are they consistent? Explain your findings.

flights %>% select(dep_time,sched_dep_time,dep_delay)

# Answer: they are pretty consistent, it looks like dep_time = sched_dep_time + dep_delay









## Source: Section 16.4 Time spans

# 1.Why is there months() but no dmonths()?

# I think is because month has different days in different months.









## Source: Section 18

rnorm(100) %>% 
  matrix(ncol = 2) %>% 
  plot() %>% 
  str()

rnorm(100) %>% 
  matrix(ncol = 2) %T>% 
  plot() %>% 
  str()


