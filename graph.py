visited = set()

def dfs(node, goalValue, visited):
    if node.value is goalValue:
        return True

    visited.add(node)
    for neighbor in node.neighbors():
        if neighbor not in visited:
            if dfs(neighbor, goalValue, visited):
                return True

    return False


def dfs2(startNode, value):
    visited = set()
    stack = [startNode]

    while len(stack) > 0:
        node = stack.pop()
        if node in visited:
            continue

        visited.add(node)
        if node.value is value:
            return True

        for n in node.neighbors:
            if n not in visited:
                stack.append(n)

    return False
