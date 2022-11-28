//
//  ATLogger.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation
import os.log

public class ATLogger {

    public let uuid = UUID()

    public var isEnabled: Bool = true

    public let subsystem: String

    public let category: String

    /// A readable identifier of the logger.
    public var name: String {
        "\(subsystem).\(category)"
    }

    private let logger: Logger

    public init(subsystem: String, category: String) {
        self.subsystem = subsystem
        self.category = category
        logger = Logger(subsystem: subsystem, category: category)
    }

    // MARK: - Logging Messages

    public func debug(
        _ message: String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: Int = #line
    ) {
        log(
            level: .debug,
            message,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber)
    }

    public func info(
        _ message: String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: Int = #line
    ) {
        log(
            level: .info,
            message,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber)
    }

    public func error(
        _ message: String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: Int = #line
    ) {
        log(
            level: .error,
            message,
            fileName: fileName,
            functionName: functionName,
            lineNumber: lineNumber)
    }

    public func log(
        level: Severity = .debug,
        _ message: String,
        fileName: String = #file,
        functionName: String = #function,
        lineNumber: Int = #line
    ) {
        guard isEnabled else { return }

        let scopeInfo = "\(fileName.lastPathComponent):\(lineNumber) \(functionName)"
        logger.log(level: level.systemLevel, "\(scopeInfo) > \(message)")
    }

}

// MARK: - ATLogger

extension ATLogger: Equatable {
    public static func ==(lhs: ATLogger, rhs: ATLogger) -> Bool {
        lhs.uuid == rhs.uuid
    }
}
