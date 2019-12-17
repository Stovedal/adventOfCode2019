
class Layer {

	var pixels: [Int]
	var height: Int
	var width: Int
	var zeros: Int {
		return pixels.filter{$0==0}.count
	}
	var ones: Int {
		return pixels.filter{$0==1}.count
	}
	var twos: Int {
		return pixels.filter{$0==2}.count
	}

	init(pixels: [Int], height: Int, width: Int) {
		self.pixels = pixels
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

var zeros = layers[0].zeros
var ans = layers[0].ones * layers[0].twos
for layer in layers {
	layer.printLayer()
	if(layer.zeros < zeros){
		zeros = layer.zeros
		ans = layer.ones * layer.twos
	}
}

print(ans)