T = {
    'A': ['B', 'C', 'D'],
    'B': ['E', 'F'],
    'C': ['G', 'H'],
    'D': ['I', 'J'],
    'E': ['K', 'L'],
    'F': ['M'],
    'G': ['N'],
    'H': ['O'],
    'I': ['P', 'Q'],
    'J': ['R'],
    'K': ['S'],
    'L': ['T'],
    'M': [],
    'N': [],
    'O': [],
    'P': ['U'],
    'Q': [],
    'R': [],
    'S': [],
    'T': [],
    'U': [],
}

visited = []

def dfs(T, s, g):
    if g in visited:
        return visited
    if s not in visited:
        visited.append(s)
        for i in T[s]:
            dfs(T, i, g)
    return visited

def bfs(T,s,g):
    flag = False
    travelled = []
    nodes_to_travel = []
    visited_flag = [False]*21
    nodes_to_travel.append(s)
    visited_flag[ord(s)-65] = True
    for i in range(0, 21):
        temp = nodes_to_travel[i]
        travelled.append(nodes_to_travel[i])
        if nodes_to_travel[i] == g:
            flag = True
        for j in T.get(temp):
            if not visited_flag[ord(j)-65]:
                visited_flag[ord(j)-65] = True
                nodes_to_travel.append(j)
        if flag is True:
            break
    return travelled

print("Tree:")
print("Node     Connected nodes")
for node in T.keys():
    print(str(node) + "       ", T.get(node))
print()
print("BFS Traversal")
bfs_cost = bfs(T, 'A', 'N')
print(bfs_cost)
print("Cost: ", len(bfs_cost))
print()
print("DFS Traversal")
dfs_cost = dfs(T, 'A', 'N')
print(dfs_cost)
print("Cost: ", len(dfs_cost))