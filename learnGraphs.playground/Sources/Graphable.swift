protocol Graphable {
    associatedtype Element: Hashable // 1
    var description: CustomStringConvertible { get } // ets you define custom behavior to print out the contents of a graph. This can help with debugging!
    
    func createVertex(data: Element) -> Vertex<Element>
    func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) // add an edge between two vertices. You can specify the weight as well as whether an edge is directed or undirected.
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? // get the weight of an edge between two vertices.
    func edges(from source: Vertex<Element>) -> [Edge<Element>]? // provides a utility to retrieve all the edges that source vertex connects to.
}
