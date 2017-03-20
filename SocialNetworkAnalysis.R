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



g <- make_empty_graph() %>%
  add_vertices(3, color = "red") %>%
  add_vertices(2, color = "green") %>%
  add_edges(c(1,2, 2,3, 3,4, 4,5))
g
V(g)[[]]
plot(g)



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