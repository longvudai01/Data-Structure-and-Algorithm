import Foundation

public struct HashTable<Key: Hashable, Value> {
    private typealias Element = (Key: Key, Value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    private(set) public var count = 0
    var isEmpty: Bool {
        return count == 0
    }
    
    public init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: [], count: capacity)
    }
    
    public func index(for key: Key) -> Int {
        return abs(key.hashValue) % buckets.count
    }
    
    //value retrieal
    public subscript (key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let value = newValue {
                update(value: value, key: key)
            }
            else {
                remove(for: key)
            }
        }
    }
    
    public func value(for key: Key) -> Value? {
        let index = self.index(for: key)
        return buckets[index].first { $0.Key == key}?.Value
    }
    
    //inserting values
    @discardableResult
    public mutating func update(value: Value, key: Key) -> Value? {
        //get index in buckets
        let index = self.index(for: key)
        
        //check if value already existed in chain
        if let (i, element) = buckets[index].enumerated().first (where: { $0.1.Key == key }) {
            let oldValue = element.Value
            buckets[index][i].Value = value
            return oldValue
        }
        //if the key not matching
        buckets[index].append((Key: key, Value: value))
        count += 1
        return nil
    }
    
    @discardableResult
    public mutating func remove(for key: Key) -> Value? {
        let index = self.index(for: key)
        
        if let (i, element) = buckets[index].enumerated().first(where: {$0.1.Key == key}) { //$0.1.key ~ tuple(i, ele).ele.key
            buckets[index].remove(at: i)
            count -= 1
            return element.Value
        }
        return nil
    }
}
