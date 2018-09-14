public protocol TweenIntervalType {
    var interval: Range<Double> { get }
    var easingFunction: Easing.Function { get }
    var isIntervalClosed: Bool { get set }
    func contains(progress: Double) -> Bool
    func handleProgressUpdate(_ progress: Double)
}

extension TweenIntervalType {
    public func contains(progress: Double) -> Bool {
        return interval.contains(progress) || (isIntervalClosed && interval.upperBound == progress)
    }
}

public final class TweenDescriptor<T: Tweenable>: TweenIntervalType {
    public let fromValue: T
    public let toValue: T
    public let interval: Range<Double>
    public let easingFunction: Easing.Function
    public var isIntervalClosed: Bool = false
    public var updateBlock: ((T) -> Void)?

    init(fromValue: T, toValue: T, interval: Range<Double>, easingFunction: @escaping Easing.Function) {
        self.fromValue = fromValue
        self.toValue = toValue
        self.interval = interval
        self.easingFunction = easingFunction
    }

    public func handleProgressUpdate(_ progress: Double) {
        guard let block = updateBlock, contains(progress: progress) else { return }
        let percent = percentFromProgress(progress)
        let easedPercent = easingFunction(percent)
        block(T.valueBetween(fromValue, toValue, percent: easedPercent))
    }

    // MARK: - Private

    private func percentFromProgress(_ progress: Double) -> Double {
        return (progress - interval.lowerBound) / (interval.upperBound - interval.lowerBound)
    }
}
