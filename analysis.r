library(readr)
library(dplyr)
library(readr)
library(plotly)
#importing libraries

forkmeans <- read_csv("C:/Users/mudit/Google Drive/for project/4th year project/forkmeans.csv")
#reading dataset
forkmeans1 <-remove_missing(forkmeans)
#removing missing values
forkmeans1 <-subset(forkmeans1, select = -c(Time,Humidity)) 
#subsetting values of time and temperature
forkmeans1$Value <- if_else(forkmeans1$Temperature >27,1,0)
##creating a new column based on a condition

plot(forkmeans1)
#creating a simple plot

#Scaling each column in the data to zero mean and unit standard deviation (z-scores).
#This prevents one attribute with a large range to dominate the others 
#for the distance calculation.
forkmeans1_scaled <- scale(forkmeans1)
plot(forkmeans1_scaled)

#Clustering method 1
#k-means Clustering
#Assumes Euclidean distances. We use k=2 clusters and run the algorithm 10 times 
#with random initialized centroids. The best result is returned.
km <- kmeans(forkmeans1_scaled, centers=2, nstart=10)
km

#plotting for kmeans
plot(forkmeans1_scaled, col=km$cluster)
points(km$centers, pch=3, cex=2) # this adds the centroids
text(km$centers, labels=1:2, pos=2) # this adds the cluster ID

#printing about clusters from the results of k-means
centers <- km$centers[km$cluster, ] 
print(forkmeans1_scaled[km$cluster])
km$cluster
km$cluster[10]
print(forkmeans1_scaled[km$cluster[10]])
forkmeans1_scaled[km$cluster==1]
forkmeans1_scaled[km$cluster==2]

#unscaling
forkmeans1_scaled <- unscale(forkmeans1_scaled,forkmeans1_scaled)


# Inspecting the centroids (cluster profiles)
km$centers



#Clustering method 2
#Density-based clustering with DBSCAN
library(dbscan)
#loading dbscan library

#Parameters: minPts is often chosen as dimensionality of the data +1.
#Decide on epsilon using the knee in the kNN distance plot

#running the dbscan function
db <- dbscan(forkmeans1_scaled, eps=2, minPts=2)

#plotting dbscan results
db
str(db)
plot(forkmeans1_scaled, col=db$cluster+1L)

#Alternative visualization from package dbscan
hullplot(forkmeans1_scaled, db)

#printing values from the results of dbscan
print(forkmeans1_scaled[db$cluster])
db$cluster[10]
print(forkmeans1_scaled[db$cluster[10]])
forkmeans1_scaled[db$cluster==1]
forkmeans1_scaled[db$cluster==2]
