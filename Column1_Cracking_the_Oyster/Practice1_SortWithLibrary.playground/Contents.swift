import Foundation
import PlaygroundSupport

/**
 <unknown>:0: Test Case '-[__lldb_expr_9.MyTests testSort]' measured [Time, seconds] average: 2.840, relative standard deviation: 1.264%, values: [2.935805, 2.873546, 2.823807, 2.808163, 2.822844, 2.834610, 2.836129, 2.824337, 2.819522, 2.822635], performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , polarity: prefers smaller, maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, maxRegression: 0.100, maxStandardDeviation: 0.100
 */
class SortWithLibrary {
    
    func solution() {
        let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = "Output.txt"
        let outputFileUrl = docDirectory.appendingPathComponent(fileName)

        do {
            try readFileLines()
                .compactMap(Int.init)
                .sorted()
                .map(String.init)
                .joined(separator: "\n")
                .write(to: outputFileUrl, atomically: true, encoding: .utf8)
            print("Scucess write file to \(outputFileUrl)")
        } catch {
            print("Failure error: \(error)")
        }
    }
    
    private func readFileLines() -> [String] {
        guard let filePath = Bundle.main.path(forResource: "Input", ofType: "txt") else {
            print("Cannot file path")
            return []
        }
        
        do {
            let data = try String(contentsOfFile: filePath, encoding: .utf8)
            return data.components(separatedBy: .newlines)
        } catch {
            print("error: \(error)")
            return []
        }
    }
    
}

import XCTest

class MyTests: XCTestCase {
    func testSort() {
        measure {
            SortWithLibrary().solution()
        }
    }
}

MyTests.defaultTestSuite.run()
