

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
var meIndex: Int = 0
var santaIndex: Int = 0

while let input = readLine() {

	//Create node
	let keys: [String] = input.split(separator: ")").map{String($0)}	
	var newNode: Node = Node(key: keys[1], parentKey: keys[0])

	if(newNode.key == "YOU"){
		meIndex = graph.count
	}

	if(newNode.key == "SAN"){
		santaIndex = graph.count
	}

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

print("Me: ", meIndex)
print("Santa: ", santaIndex)

func findParents(node: Node, graph: [Node]) -> [Node] {

	if let parent = graph.first(where: {$0.key == node.parentKey}){
		return [parent] + findParents(node: parent, graph: graph)
	}

	return []

}

func printNodes(nodes: [Node]) -> Void {
	for node in nodes {
		print(node.toString())
	}
}

var meParents = findParents(node: graph[meIndex], graph: graph)
var santasParents = findParents(node: graph[santaIndex], graph: graph)

print("My parents")
//printNodes(nodes: meParents)
print("Santas parents")
//printNodes(nodes: santasParents)

var distance = 0

for i in 0...(meParents.count-1) {
	for j in 0...(santasParents.count-1) {
		if(distance==0){print(meParents[i].key , santasParents[j].key)}
		if(meParents[i].key == santasParents[j].key && distance == 0){
			distance = i + j
		}
	}
}

print(distance)