
class Layer {

	var pixels: [Int]
	var height: Int
	var width: Int

	init(pixels: [Int]? = nil, height: Int, width: Int) {
		self.pixels = pixels ?? [Int](repeating: 2, count: height * width)
		self.height = height
		self.width = width
	}

	func printLayer(){
		var string = ""
		for i in 0...(height-1) {
			for j in 0...(width-1){
				string += String(pixels[(i*width) + j])
			}
			string += "\n"
		}
		print(string)
	}
	
}


let image: [Int] = (readLine() ?? "").map {Int(String($0))!}

var layers: [Layer] = []
let height: Int = 6
let width: Int = 25

var i = 0

while i < image.count {
	let j = i + ( height * width )
	layers.append( Layer(pixels: Array(image[i..<j]), height: height, width: width) )
	i += height * width 
}


var message = Layer(height: height, width: width)
message.printLayer()

for layer in layers {
	for i in 0...(layer.pixels.count - 1) {
		if(message.pixels[i] == 2){
			message.pixels[i] = layer.pixels[i]
		}
	}
}

message.printLayer()
