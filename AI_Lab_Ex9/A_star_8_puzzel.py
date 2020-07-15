import numpy as np

start_arr = np.array([[0, 5, 2],[1, 8, 3],[4, 7, 6]])
goal_arr = np.array([[1, 2, 3],[4, 5, 6,], [7, 8, 0]])
frontier = []
visited = []
heuristic = None
def h1(current, target):
    return np.sum(~(current == target))

def h2(current, target):
    dist = 0
    for i in range(1,9):
        row_c, col_c = np.where(current == i) # pylint: disable=unbalanced-tuple-unpacking
        row_t, col_t = np.where(target == i)  # pylint: disable=unbalanced-tuple-unpacking
        dist = dist + (abs(col_c - col_t) + abs(row_c - row_t))
    return dist

class state:
    def __init__(self, current_state, goal_state, g, heuristic = 1):
        self.current_state = current_state
        self.g = g
        if heuristic == 1:
            self.h = h1(current_state, goal_state)
        else:
            self.h = h2(current_state, goal_state)
        self.f = self.g + self.h
        self.new_states = []
        

def span_states(current):
    new_states_temp = []
    new_states = []
    x, y = np.where(current.current_state == 0)   # pylint: disable=unbalanced-tuple-unpacking
    moves = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
    for x_i, y_i in moves:
        temp = (current.current_state).copy()
        if x_i in range(0,3) and y_i in range(0,3):
        #if x_i >= 0 and x_i < 3 and y_i >= 0 and y_i < 3:
            temp[x_i, y_i], temp[x, y] = temp[x, y], temp[x_i, y_i]
            new_states_temp.append(temp)
    for s in new_states_temp:
        new_states.append(state(s, goal_arr, current.g + 1, heuristic))
    current.new_states = new_states
    for s in new_states:
        if s not in visited:
            frontier.append(s)
    
def min_f_state():
    f_list = [s.f for s in frontier]
    f_min_loc = f_list.index(min(f_list))
    f_min_s = frontier.pop(f_min_loc)
    visited.append(f_min_s)
    return f_min_s
            
def select_state(current, goal_state):
    while (current.current_state != goal_state).any():
        span_states(current)
        current = min_f_state()
    return current.current_state, current.f

if __name__ == "__main__":
    """
    heuristic = 1
    final_state, total_cost = select_state(state(start_arr, goal_arr, 0, heuristic), goal_arr)
    print("Heuristic Function : ", "Tiles out-of-place")
    print("Initial State : \n", start_arr)
    print("Final State : \n", final_state)
    print("Total Cost: ", int(total_cost))
    print("Number of Nodes Expanded : ", len(visited))
    print()
    """
    heuristic = 2
    final_state, total_cost = select_state(state(start_arr, goal_arr, 0, heuristic), goal_arr)
    print("Heuristic Function : ", "Manhattan Distance")
    print("Heuristic Function : ", "Tiles out-of-place")
    print("Initial State : \n", start_arr)
    print("Final State : \n", final_state)
    print("Total Cost: ", int(total_cost))
    print("Number of Nodes Expanded : ", len(visited))
    print()
