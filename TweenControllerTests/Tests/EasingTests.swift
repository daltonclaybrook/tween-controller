import TweenController
import XCTest

class EasingTests: XCTestCase {

    let testValues = [0.25, 0.33, 0.5, 0.66, 0.75]

    // MARK: - Tests

    // MARK: - Linear

    func testLinear() {
        let expected = [0.25, 0.330_000_000_000_000_02, 0.5, 0.660_000_000_000_000_03, 0.75]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.linear))
    }

    // MARK: - Quad

    func testEaseInQuad() {
        let expected = [0.062_5, 0.108_900_000_000_000_01, 0.25, 0.435_600_000_000_000_04, 0.562_5]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInQuad))
    }

    func testEaseOutQuad() {
        let expected = [0.437_5, 0.551_100_000_000_000_03, 0.75, 0.884_399_999_999_999_96, 0.937_5]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutQuad))
    }

    func testEaseInOutQuad() {
        let expected = [0.125, 0.217_800_000_000_000_02, 0.5, 0.768_800_000_000_000_04, 0.875]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutQuad))
    }

    // MARK: - Cubic

    func testEaseInCubic() {
        let expected = [0.015_625, 0.035_937_000_000_000_004, 0.125, 0.287_496_000_000_000_03, 0.421_875]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInCubic))
    }

    func testEaseOutCubic() {
        let expected = [0.578_125, 0.699_237_000_000_000_11, 0.875, 0.960_695_999_999_999_99, 0.984_375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutCubic))
    }

    func testEaseInOutCubic() {
        let expected = [0.062_5, 0.143_748_000_000_000_01, 0.5, 0.842_783_999_999_999_98, 0.937_5]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutCubic))
    }

    // MARK: - Quart

    func testEaseInQuart() {
        let expected = [0.003_906_25, 0.011_859_210_000_000_002, 0.062_5, 0.189_747_360_000_000_03, 0.316_406_25]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInQuart))
    }

    func testEaseOutQuart() {
        let expected = [-1.316_406_25, -1.201_511_209_999_999_8, -1.062_5, -1.013_363_36, -1.003_906_25]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutQuart))
    }

    func testEaseInOutQuart() {
        let expected = [0.031_25, 0.094_873_680_000_000_016, 0.5, 0.893_093_120_000_000_07, 0.968_75]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutQuart))
    }

    // MARK: - Quint

    func testEaseInQuint() {
        let expected = [0.000_976_562_5, 0.003_913_539_300_000_001_1, 0.031_25, 0.125_233_257_600_000_04,
                        0.237_304_687_5]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInQuint))
    }

    func testEaseOutQuint() {
        let expected = [0.762_695_312_5, 0.864_987_489_300_000_02, 0.968_75, 0.995_456_457_600_000_01, 0.999_023_437_5]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutQuint))
    }

    func testEaseInOutQuint() {
        let expected = [0.015_625, 0.062_616_628_800_000_018, 0.5, 0.927_303_321_600_000_06, 0.984_375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutQuint))
    }

    // MARK: - Sine

    func testEaseInSine() {
        let expected = [0.076_120_467_488_713_262, 0.131_368_485_561_808_8, 0.292_893_218_813_452_43,
                        0.490_958_584_249_628_68, 0.617_316_567_634_910_16]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInSine))
    }

    func testEaseOutSine() {
        let expected = [0.382_683_432_365_089_78, 0.495_458_668_432_407_6, 0.707_106_781_186_547_46,
                        0.860_742_027_003_943_64, 0.923_879_532_511_286_74]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutSine))
    }

    func testEaseInOutSine() {
        let expected = [0.146_446_609_406_726_21, 0.245_479_292_124_814_34, 0.499_999_999_999_999_94,
                        0.740_876_837_050_857_72, 0.853_553_390_593_273_73]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutSine))
    }

    // MARK: - Expo

    func testEaseInExpo() {
        let expected = [0.005_524_271_728_019_902_9, 0.009_618_315_729_257_163_9, 0.031_25, 0.094_732_285_406_899_916,
                        0.176_776_695_296_636_89]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInExpo))
    }

    func testEaseOutExpo() {
        let expected = [0.823_223_304_703_363_13, 0.898_468_450_455_470_52, 0.968_75, 0.989_691_344_447_086_73,
                        0.994_475_728_271_980_05]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutExpo))
    }

    func testEaseInOutExpo() {
        let expected = [0.015_625, 0.047_366_142_703_449_958, 0.5, 0.945_590_589_793_992_24, 0.984_375]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutExpo))
    }

    // MARK: - Circ

    func testEaseInCirc() {
        let expected = [0.031_754_163_448_145_745, 0.056_019_067_989_188_653, 0.133_974_596_215_561_4,
                        0.248_734_401_160_282, 0.338_562_172_233_852_32]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInCirc))
    }

    func testEaseOutCirc() {
        let expected = [0.661_437_827_766_147_68, 0.742_361_098_118_698_66, 0.866_025_403_784_438_6,
                        0.940_425_435_640_699_8, 0.968_245_836_551_854_26]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeOutCirc))
    }

    func testEaseInOutCirc() {
        let expected = [0.066_987_298_107_780_702, 0.124_367_200_580_141, 0.5, 0.866_606_055_596_467_2,
                        0.933_012_701_892_219_3]
        XCTAssertTrue(verify(expectedResults: expected, of: Easing.easeInOutCirc))
    }

    // MARK: - Private

    func verify(expectedResults: [Double], of easingFunc: @escaping (Double) -> (Double)) -> Bool {
        guard expectedResults.count == testValues.count else { return false }
        return zip(testValues, expectedResults).reduce(true) { $0 && (easingFunc($1.0) == $1.1) }
    }
}
