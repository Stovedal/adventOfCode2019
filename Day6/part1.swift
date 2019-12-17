

struct Node {

	var key: String
	var parentKey: String = " none"
	var weight: Int = 0
	var children: [String] = []

	init(key: String, parentKey: String){
		self.key = key
		self.parentKey = parentKey
	}

	func toString() -> String {
		return "Node \(key) has children: \(children) and parent: \(parentKey)"
	}
}


var graph: [Node] = []

while let input = readLine() {

	//Create node
	let keys: [String] = input.split(separator: ")").map{String($0)}	
	var newNode: Node = Node(key: keys[1], parentKey: keys[0])

	// Add children
	let children = graph.filter({$0.parentKey == newNode.key})
	for child in children {
		newNode.children.append(child.key)
	}
	
	// Add parent
	if let parentIndex = graph.firstIndex(where: {$0.key == newNode.parentKey}) {
		graph[parentIndex].children.append(newNode.key)
	}

	// Append to graph
	graph.append(newNode)
}


var weights = 0

func calcOrbits(node: Node, graph: [Node], weight: Int) -> Void {

	weights += 1;

	for childKey in node.children {
		if let child = graph.first(where: {$0.key == childKey} ){
			calcOrbits(node: child, graph: graph, weight: weight + 1)
		}
	}

}

for node in graph {
	calcOrbits(node: node, graph: graph, weight: 0)
}

print(weights)
