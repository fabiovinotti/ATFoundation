//
//  UserDefaultsElegible.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation

/// A type that can be stored in the user defaults.
public protocol UserDefaultsElegible {}

extension Bool: UserDefaultsElegible {}
extension Int: UserDefaultsElegible {}
extension UInt: UserDefaultsElegible {}
extension Double: UserDefaultsElegible {}
extension String: UserDefaultsElegible {}
extension URL: UserDefaultsElegible {}
extension Data: UserDefaultsElegible {}
extension Date: UserDefaultsElegible {}
extension Array: UserDefaultsElegible where Element: UserDefaultsElegible {}
extension Dictionary: UserDefaultsElegible where Key: StringProtocol, Value: UserDefaultsElegible {}
