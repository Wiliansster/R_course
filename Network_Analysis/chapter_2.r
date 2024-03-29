# Directed igraph objects
# In this exercise you will learn how to create a directed graph 
# from a dataframe, how to inspect whether a graph object is directed 
# and/or weighted and how to extract those vertices at the beginning 
# and end of directed edges.

library(igraph)
library(readr)

# measles dataset
measles <- 
    read_csv("~/Documents/R_course/Network_Analysis/Datasets/measles.csv")

# Convert the dataframe measles into an igraph graph object using the function graph_from_data_frame() 
# and ensure that it will be a directed graph by setting the second argument to TRUE.


# --- Ex 1
# Get the graph object
g <- graph_from_data_frame(measles, directed = TRUE)

# is the graph directed?
is.directed(g)

# Is the graph weighted?
is.weighted(g)

# Where does each edge originate from?
table(head_of(g, E(g)))

# --- Ex 2

# Identifying edges for each vertex
# In this exercise you will learn how to identify particular edges. You will learn how to
# determine if an edge exists between two vertices as well as finding all vertices connected 
# in either direction to a given vertex.

# Make a basic plot
plot(g, 
    vertex.label.color = "black", 
    edge.color = 'gray77',
    vertex.size = 0,
    edge.arrow.size = 0.1,
    layout = layout_nicely(g))

# Is there an edge going from vertex 184 to vertex 178?
g['184', '178']

# Is there an edge going from vertex 178 to vertex 184?
g['178', '184']

# Show all edges going to or from vertex 184
incident(g, '184', mode = c("all"))

# Show all edges going out from vertex 184
incident(g, '184', mode = c("out"))


# --- Ex 3
# Neighbors
# Often in network analysis it is important to explore the patterning of connections 
# that exist between vertices. One way is to identify neighboring vertices of each vertex

# Identify all neighbors of vertex 12 regardless of direction
neighbors(g, '12', mode = c('all'))

# Identify other vertices that direct edges towards vertex 12
neighbors(g, '12', mode = c('in'))

# Identify any vertices that receive an edge from vertex 42 and direct an edge to vertex 124
n1 <- neighbors(g, '42', mode = c('out'))
n2 <- neighbors(g, '124', mode = c('in'))
intersection(n1, n2)

# --- Ex 3
# Distances between vertices
# The inter-connectivity of a network can be assessed by examining the number and length of paths between vertices

# Which two vertices are the furthest apart in the graph ?
farthest_vertices(g) 

# Shows the path sequence between two furthest apart vertices.
get_diameter(g)  

# Identify vertices that are reachable within two connections from vertex 42
ego(g, 2, '42', mode = c('out'))

# Identify vertices that can reach vertex 42 within two connections
ego(g, 2, '42', mode = c('in'))

# --- Ex 4

# Identifying key vertices
# Perhaps the most straightforward measure of vertex importance is the degree of a vertex.

# Calculate the out-degree of each vertex
g.outd <- degree(g, mode = c("out"))

# View a summary of out-degree
table(g.outd)

# Make a histogram of out-degrees
hist(g.outd, breaks = 30)

# Find the vertex that has the maximum out-degree
which.max(g.outd)

# --- Ex 5

# Betweenness
# Another measure of the importance of a given vertex is its betweenness

# Calculate betweenness of each vertex
g.b <- betweenness(g, directed = TRUE)

# Show histogram of vertex betweenness
hist(g.b, breaks = 80)

# Create plot with vertex size determined by betweenness score
plot(g, 
    vertex.label = NA,
    edge.color = 'black',
    vertex.size = sqrt(g.b)+1,
    edge.arrow.size = 0.05,
    layout = layout_nicely(g))

# --- Ex 6

# Visualizing important nodes and edges
# One issue with the measles dataset is that there are three individuals for 
# whom no information is known about who infected them.

# Make an ego graph
g184 <- make_ego_graph(g, diameter(g), nodes = '184', mode = c("all"))[[1]]

# Get a vector of geodesic distances of all vertices from vertex 184 
dists <- distances(g184, "184")

# Create a color palette of length equal to the maximal geodesic distance plus one.
colors <- c("black", "red", "orange", "blue", "dodgerblue", "cyan")

# Set color attribute to vertices of network g184.
V(g184)$color <- colors[dists+1]

# Visualize the network based on geodesic distance from vertex 184 (patient zero).
plot(g184, 
    vertex.label = dists, 
    vertex.label.color = "white",
    vertex.label.cex = .6,
    edge.color = 'black',
    vertex.size = 7,
    edge.arrow.size = .05,
    main = "Geodesic Distances from Patient Zero"
    )