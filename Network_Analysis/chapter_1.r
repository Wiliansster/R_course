
########################################
# video 1

# Load igraph
library(igraph)
library(readr) # for read the csv

# --- Ex1

# Import friedns data
friends <- 
    read_csv("~/Documents/R_course/Network_Analysis/Datasets/friends.csv")

# Inspect the first few rows of the dataframe 'friends'
head(friends)

# Convert friends dataframe to a matrix
friends.mat <- as.matrix(friends)

# Convert friends matrix to an igraph object
g <- graph.edgelist(friends.mat, directed = FALSE)


# Make a very basic plot of the network
plot(g)

# --- Ex2

# Subset vertices and edges
V(g)
E(g)

# Count number of edges
gsize(g)

# Count number of vertices
gorder(g)

####################################################
####################################################
# video 2
# --- Ex1
genders <- 
    c("M" ,"F", "F" ,"M" ,"M" ,"M" ,"F", "M", "M" ,"F" ,"M" ,"F", "M", "F" ,"M" ,"M")
ages <-
    c(18 ,19 ,21 ,20 ,22 ,18 ,23 ,21 ,22 ,20 ,20 ,22 ,21 ,18 ,19 ,20)

# Inspect the objects 'genders' and 'ages'
genders
ages

# Create new vertex attribute called 'gender'
g <- 
    set_vertex_attr(g, "gender", value = genders)

# Create new vertex attribute called 'age'
g <- 
    set_vertex_attr(g, "age", value = ages)

# View all vertex attributes in a list
vertex_attr(g)

# View attributes of first five vertices in a dataframe
V(g)[[1:5]] 

# --- Ex2 

hours <-
    c(1, 2, 2 ,1 ,2 ,5 ,5 ,1 ,1 ,3 ,2 ,1 ,1 ,5 ,1 ,2 ,4 ,1 ,3 ,1 ,1 ,1, 4 ,1 ,3 ,3 ,4)

# View hours
hours

# Create new edge attribute called 'hours'
g <- set_edge_attr(g, "hours", value = hours)

# View edge attributes of graph object
edge_attr(g)

# Find all edges that include "Britt"
E(g)[[inc('Britt')]]  

# Find all pairs that spend 4 or more hours together per week
E(g)[[hours>=4]]  

# --- Ex3 
# In this exercise we will learn how to create igraph objects with attributes directly from dataframes and 
# how to visualize attributes in plots. We will use a second network of friendship connections between students.

# Import friedns data
friends1_edges <- 
    read_csv("~/Documents/R_course/Network_Analysis/Datasets/friends1_edges.csv")

friends1_nodes <- 
    read_csv("~/Documents/R_course/Network_Analysis/Datasets/friends1_nodes.csv")

# Create an igraph object with attributes directly from dataframes
g1 <- graph_from_data_frame(d = friends1_edges, vertices = friends1_nodes, directed = FALSE)


# Subset edges greater than or equal to 5 hours
E(g1)[[hours >= 5]]  

# Set vertex color by gender
V(g1)$color <- ifelse(V(g1)$gender == "F", "orange", "dodgerblue")

# Plot the graph
plot(g1, vertex.label.color = "black")

# --- Ex4 
# igraph layout

# Plot the graph object g1 in a circle layout
plot(g1, vertex.label.color = "black", layout = layout_in_circle(g1))

# Plot the graph object g1 in a Fruchterman-Reingold layout 
plot(g1, vertex.label.color = "black", layout = layout_with_fr(g1))

# Plot the graph object g1 in a Tree layout 
m <- layout_as_tree(g1)
plot(g1, vertex.label.color = "black", layout = m)

# Plot the graph object g1 using igraph's chosen layout 
m1 <- layout_nicely(g1)
plot(g1, vertex.label.color = "black", layout = m1)


# --- Ex5

# Visualizing edges
# In this exercise you will learn how to change the size of edges in a network based on
# their weight, as well as how to remove edges from a network which can sometimes be helpful 
# in more effectively visualizing large and highly clustered networks. In this introductory chapter, 
# we have just scratched the surface of what's possible in visualizing igraph networks. 
# You will continue to develop these skills in future chapters.


# Create a vector of weights based on the number of hours each pair spend together
w1 <- E(g1)$hours

# Plot the network varying edges by weights
m1 <- layout_nicely(g1)
plot(g1, 
        vertex.label.color = "black", 
        edge.color = 'black',
        edge.width = w1,
        layout = m1)


# Create a new igraph object by deleting edges that are less than 2 hours long 
g2 <- delete_edges(g1, E(g1)[hours < 2])


# Plot the new graph 
w2 <- E(g2)$hours
m2 <- layout_nicely(g2)

plot(g2, 
     vertex.label.color = "black", 
     edge.color = 'black',
     edge.width = w2,
     layout = m2)

######################
# Quiz on igraph objects

# How many edges does Jasmine have in the network g1
E(g1)[[inc('Jasmine')]]