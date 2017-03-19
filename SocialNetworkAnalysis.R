install.packages("sna")
install.packages("igraph")

library(sna)
library(igraph)
directdata <- read.table("directed.txt")
indirectdata <- read.table("undirected.txt")
graph1 <- graph_from_data_frame(indirectdata, directed = FALSE, vertices = NULL)
plot(graph1)

g_full <- make_full_graph(8, directed = FALSE)
plot(g_full)

g_ring <- make_ring(12, directed = FALSE, mutual = FALSE, circular = TRUE)
plot(g_ring)

g_star <- make_star(10, center = 1)
plot(g_star)

g_gnp <- sample_gnp(20, 0.3, directed = FALSE, loops = FALSE)
plot(g_gnp)

g_gnm <- sample_gnm(15, 50, directed = FALSE, loops = FALSE)
plot(g_gnm)

g_gnm2 <- sample_gnm(15, 25, directed = FALSE, loops = FALSE)
plot(g_gnm2)

g_gpa <- sample_pa(20, power = 1)
plot(g_gpa)

# 
g1 <- sample_pa(12, power = 1)
plot(g1)

