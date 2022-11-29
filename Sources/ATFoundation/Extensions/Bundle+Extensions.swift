//
//  Bundle+Extensions.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation

extension Bundle {

    /// CFBundleName in Info.plist.
    public var name: String {
        string(forInfoDictionaryKey: "CFBundleName")
    }

    /// CFBundleShortVersionString in Info.plist.
    public var shortVersion: String {
        string(forInfoDictionaryKey: "CFBundleShortVersionString")
    }

    /// CFBundleVersion in Info.plist.
    public var version: String {
        string(forInfoDictionaryKey: "CFBundleVersion")
    }

    public func string(forInfoDictionaryKey key: String) -> String {
        guard let s = object(forInfoDictionaryKey: key) as? String else {
            fatalError("Couldn't find string object in the Info Dictionary for key: \(key)")
        }
        return s
    }

}
