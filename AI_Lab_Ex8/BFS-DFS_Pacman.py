from queue import PriorityQueue

def dfs(graph, start, goal):
    visited = []
    path = [start]
    fringe = PriorityQueue()
    fringe.put((0, start, path, visited))

    while not fringe.empty():
        _, current_node, path, visited = fringe.get()

        if current_node == goal:
            return path + [current_node]

        visited = visited + [current_node]

        child_nodes = graph[current_node]
        for node in child_nodes:
            if node not in visited:
                if node == goal:
                    return path + [node]
                depth_of_node = len(path)
                fringe.put((-depth_of_node, node, path + [node], visited))

    return path


def bfs(graph, start, goal):

    explored = []
    queue = [[start]]
    if start == goal:
        return "Start = goal"

    while queue:
        path = queue.pop(0)
        node = path[-1]
        if node not in explored:
            neighbours = graph[node]

            for neighbour in neighbours:
                new_path = list(path)
                new_path.append(neighbour)
                queue.append(new_path)
                if neighbour == goal:
                    return new_path

            explored.append(node)

    return "Path Not exist"


if __name__ == "__main__":
    maze = [["#", "#", "#", "#", "#", "#", "#", "#"],
            ["#", "-", "-", "-", "-", "-", "-", "#"],
            ["#", "-", "#", "#", "#", "-", "-", "#"],
            ["#", "-", "#", "-", "#", "-", "-", "#"],
            ["#", "-", "-", "-", "#", "-", "-", "#"],
            ["#", "-", "#", "#", "#", "-", "-", "#"],
            ["#", "-", "-", "-", "-", "-", "-", "#"],
            ["#", "#", "#", "#", "#", "#", "#", "#"]]

    graph = {(i+1, j+1): [] for i in range(8) for j in range(8)}

    for i in range(8):
        for j in range(8):
            if maze[i][j] == "-":
                if maze[i+1][j] == "-":
                    graph[(i+1, j+1)].append((i+2, j+1))
                if maze[i][j+1] == "-":
                    graph[(i+1, j+1)].append((i+1, j+2))
                if maze[i][j-1] == "-":
                    graph[(i+1, j+1)].append((i+1, j))
                if maze[i-1][j] == "-":
                    graph[(i+1, j+1)].append((i, j+1))

    start = (7, 2)
    goal = (4, 4)

    path = bfs(graph, start, goal)
    print("BFS path", path)

    path = dfs(graph, start, goal)
    print("DFS path", path)
