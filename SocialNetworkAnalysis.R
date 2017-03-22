install.packages("sna")
install.packages("igraph")

library(sna)
library(igraph)
?sna

directdata <- read.table("directed.txt")
indirectdata <- read.table("undirected.txt")
graph1 <- graph_from_data_frame(indirectdata, directed = FALSE, vertices = NULL)
plot(graph1)

??g_full
g_full <- make_full_graph(8, directed = FALSE)
plot(g_full)

g_ring <- make_ring(12, directed = FALSE, mutual = FALSE, circular = TRUE)
plot(g_ring)

g_star <- make_star(10, center = 1)
plot(g_star)

# Erdos-Renyi, g(n,p) model:

?sample_gnp
g_gnp <- sample_gnp(20, 0.3, directed = FALSE, loops = FALSE)
plot(g_gnp)

# Erdos-Renyi, g(n,m) model:

?sample_gnm
g_gnm <- sample_gnm(15, 50, directed = FALSE, loops = FALSE)
plot(g_gnm)

g_gnm2 <- sample_gnm(15, 25, directed = FALSE, loops = FALSE)
plot(g_gnm2)

# Preferential attachment (Barabasi-Albert model): 
?sample_pa
g_gpa <- sample_pa(20, power = 1, directed = FALSE)
plot(g_gpa)

# 
g1 <- sample_pa(12, power = 1, directed = FALSE)
plot(g1)
# Degree for each vertex in graph:
degree(g1)
# [g1] 3 6 2 2 1 1 1 2 1 1 1 1
# So, Node #1 = 3 connections, Node #2 = 6 connections, etc........

# Measure betweeness of each vertex, 
# higher betweeness score = higher bridging role within that network!
g1 <- sample_pa(20, power = 1, directed = FALSE)
plot(g1)
betweenness(g1)
# [g1]  18 150  51  64   0   0   0  18   0  35   0   0   0   0  18   0   0  18   0   0
# Vertex #1 = 18 (low score), Vertex #2 = 150 (highest score), etc... 

# Calculate network density:

g1 <- sample_pa(12, power = 1, directed = FALSE)
plot(g1)
ed <- edge_density(g1, loops = FALSE)
ed # 0.166666667 = 2/12

g2 <- sample_pa(20, power = 1, directed = FALSE)
plot(g2)
ed2 <- edge_density(g2, loops = FALSE)
ed2 # 0.1 = 2/20

g3 <- sample_pa(40, power = 1, directed = FALSE)
plot(g3)
ed3 <- edge_density(g3, loops = FALSE)
ed3 # 0.05 = 2/40


gnp1 <- sample_gnp(20, 0.3, directed = FALSE, loops = FALSE)
plot(gnp1)
ed4 <- edge_density(gnp1, loops = FALSE)
ed4 # 0.3 or 0.2421053 or 0.2789474, or.....

# Identify cliques in SNA: a clique is defined as a group of 
# vertices where all possible links are present
gnp <- sample_gnp(20, 0.3, directed = FALSE, loops = FALSE)
plot(gnp)
# Calculate size of largest clique: 
clique_num(gnp)
# 4 
# Cliques with minimum 4 vertices("members"):
gnp %>% cliques(., min = 4)
# 4 cliques with min. of 4 vertices.
gnp %>% cliques(., min = 4, max = 6)

# If increase prob of any individual node/link occuring from 0.3 >>> 0.6    : 
gnp2 <- sample_gnp(20, 0.5, directed = FALSE, loops = FALSE)
plot(gnp2)
gnp2 %>% clique_num()
gnp2 %>%  cliques(., min = 4, max = 6)

# Components: a group of connected network nodes

set.seed(1)
# gnp <- sample_gnp(30, 0.06, directed = FALSE, loops = FALSE)
# plot(gnp)

gnp
plot.igraph(gnp, vertex.label = V(gnp)$name, vertex.size = 20,
            vertex.label.color = "black", vertex.label.font = 2,
            vertex.color = "white", edge.color = "black",
            vertex.frame.color = "blue")

#  [1]  5-- 6  9--10  2--11 11--14 12--14  7--16  2--17 17--19 10--20  8--21 19--22 17--23  4--25  8--25
# [15] 19--26  9--28  3--29 10--29 14--30 16--30
# Color code components so they look like separate departments/sections/cliques! 


g <- make_empty_graph() %>%
  add_vertices(3, color = "red") %>%
  add_vertices(2, color = "green") %>%
  add_edges(c(1,2, 2,3, 3,4, 4,5))
g
V(g)[[]]
plot(g)

g_2 <- make_empty_graph(directed = FALSE) %>%
  add_vertices(3, color = "red") %>%
  add_vertices(5, color = "green") %>%
  add_vertices(8, color = "light blue") %>% 
  add_edges(c(1,2, 2,3, 3,1, 4,5, 2,3, 7,6, 6,7, 5,6, 5,7, 4,7, 2,1, 4,6, 5,4,
              11,10, 10,11, 12,10, 8,5, 13,12, 9,13, 10,13, 13,10, 11,13, 9,15,
              12,8, 2,12, 12,2))
plot(g_2)

plot.igraph(g_2, vertex.label = V(g_2)$name, vertex.size = 20,
            vertex.label.color = "black", vertex.label.font = 2,
            edge.color = "black", edge.width = 1.5,
            vertex.frame.color = "black")


g_3 <- make_empty_graph(directed = FALSE) %>% 
  add_vertices(10, color = "red") %>% 
  add_vertices(15, color = "green") %>% 
  add_vertices(12, color = "light blue") %>% 
  add_edges(c(1,2, 1,3, 4,5, 5,6, 1,4, 4,6, 7,10, 6,5, 7,6, 1,6, 20,14,
              3,5, 11,12, 12,11, 13,11, 11,13, 12,13, 15,14, 16,17, 17,16,
              18,17, 15,12, 13,15, 8,2, 18,14, 12,18, 15,12, 30,29, 2,6, 2,5,
              37,34, 35,36, 28,29, 30,31, 31,30, 26,25, 11,25, 13,17, 11,15, 34,26,
              26,34, 26,37, 21,24, 20,19, 24,20, 19,22, 23,24, 23,14, 20,18, 32,10,
              32,31, 32,30, 34,35, 36,37, 3,7, 5,32, 5,30, 18,17, 14,15, 1,5, 5,1,
              1,2, 1,2, 3,1, 3,1, 3,1, 1,3, 1,3, 25,26, 25,26, 25,26, 25,26,
              26,34, 26,34, 26,34, 26,34, 26,34, 26,34, 19,22, 19,22, 19,22))

plot.igraph(g_3, vertex.size = (V(g_3)$size = degree(g_3)*1.2),
            edge.color = "black", edge.width = 1.5,
            vertex.frame.color = "black", vertex.label = NA)

# vertex.label = NA
tkplot(g_3, vertex.label.dist = 1, layout = layout.circle)
?tkplot()
g_3
edge_attr(g_3)
?set_edge_attr()
?add_vertices()
# Some nodes that don't have connections! 
components(gnp)
# $membership: #1 in Component 1, #2 in Component 1, #3 in Component 2,
# #16 in Component 6 (ex. by itself), etc....
# $csize: Component 1 = 20 nodes, COmponent 2 = 2 nodes, etc...
# $no: total number of components in graph. 

# Random walk: 
g1 <- sample_gnp(30, 0.08, directed = FALSE, loops = FALSE)
plot(g1)
random_walk(g1, 23, 8, stuck = "return")
# 23 >>> 7 >>> 26 >>> 24 >>> 26 >>> 7 >>> 23 >>> 13
random_walk(g1, 23, 8, stuck = "return")
# 23 >>> 12 >>> 23 >>> 28 >>> 12 >>> 12 >>>28
random_walk(g1, 27, 8, stuck = "return")
# 27 (because it is a solitary node...)

# Visualization, change colors for vertex + edges: 
g1 <- sample_gnp(30, 0.1, directed = FALSE, loops = FALSE)
plot(g1)
g2 <- sample_gnp(30, 0.08, directed = FALSE, loops = FALSE) %>% 
  set_vertex_attr("color", value = "blue") %>% 
  set_edge_attr("color", value = "green") %>% 
  set_vertex_attr("vertex.label.color", value = "red")

plot(g2)
V(g2)
plot.igraph(g2, vertex.label = V(g2)$name, vertex.size = 20,
            vertex.label.color = "yellow", vertex.label.font = 2,
            vertex.color = "darkblue", edge.color = "red",
            vertex.frame.color = "green")
?igraph.plotting
# layout = layout.circl() 