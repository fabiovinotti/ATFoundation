//
//  ATLogger+Severity.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import os.log

extension ATLogger {

    /// The severity level of a log.
    public enum Severity {

        case debug, info, error

        public var name: String {
            switch self {
            case .debug: return "debug"
            case .info: return "info"
            case .error: return "error"
            }
        }

        public var systemLevel: OSLogType {
            switch self {
            case .debug: return .debug
            case .info: return .info
            case .error: return .error
            }
        }

    }

}
