struct Boundary {    
    struct Direction: OptionSet {
        let rawValue: Int
        init(rawValue: Int) { self.rawValue = rawValue }
        
        static let forward = Direction(rawValue: 1 << 0)
        static let backward = Direction(rawValue: 1 << 1)
        static let both: Direction = [forward, backward]
    }
    
    let progress: Double
    let block: TweenObserverBlock
    let direction: Direction
}
