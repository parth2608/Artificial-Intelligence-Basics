import copy
start_state = [[0, 5, 2], [1, 8, 3], [4, 7, 6]]
goal_state = [[1, 2, 3], [4, 5, 6], [7, 8, 0]]


def childNodeBFS(arr, i, j):
    child = []
    a = [i+1, j]
    b = [i-1, j]
    c = [i, j+1]
    d = [i, j-1]
    options = [a, b, c, d]
    for k in options:
        if((k[0] >= 0 and k[0] < 3) and (k[1] >= 0 and k[1] < 3)):
            if arr[k[0]][k[1]] == 0:
                child.clear()
                child.append([k[0], k[1]])
                break
            child.append([k[0], k[1]])
    return child


def childNodeDFS(i, j): 
	child = []
	options = [[i, j-1], [i, j+1], [i-1, j], [i+1, j]]
	for k in options:
		if((k[0] >= 0 and k[0] < 3) and (k[1] >= 0 and k[1] < 3)):
			child.append([k[0], k[1]])
	return child


def index(k, arr):
    for i in range(0, 3):
            for j in range(0, 3):
                if arr[i][j] == k:
                    p = i
                    m = j
    return p, m


def bfs(s, g):
    frontier = [s]
    traverse = [s]
    while True:
        e = frontier.pop(0)
        if e == g:
            print('Goal State')
            print(e)
            break
        r, c = index(0, e)
        child = childNodeBFS(e, r, c)
        for k in child:
            temp = copy.deepcopy(e)
            temp[r][c] = temp[k[0]][k[1]]
            temp[k[0]][k[1]] = 0
            flag = 0
            for x in range(0, len(traverse)):
                if traverse[x] == temp:
                    flag = 1
                    break
            if flag != 1:
                frontier.append(temp)
                traverse.append(temp)
    return traverse


def dfs(s, g):
    frontier = [s]
    traverse = [s]
    while True:
        e = frontier.pop(0)
        if e == g:
            print('Goal State')
            print(e)
            break
        r, c = index(0, e)
        child = childNodeDFS(r, c)
        for k in child:
            temp = copy.deepcopy(e)
            temp[r][c] = temp[k[0]][k[1]]
            temp[k[0]][k[1]] = 0
            flag = 0
            for x in range(0, len(traverse)):
                if traverse[x] == temp:
                    flag = 1
                    break
            if flag != 1:
                frontier.insert(0, temp)
                traverse.append(temp)
    return traverse


print(start_state)
ans = bfs(start_state, goal_state)
print('Nodes in BFS = ', len(ans))
a = dfs(start_state, goal_state)
print('Nodes in DFS = ', len(a))
