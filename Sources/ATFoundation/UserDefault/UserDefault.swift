//
//  UserDefault.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation
import Combine

public class UserDefault<Value> : ObservableObject where Value : Equatable {

    @Published
    public var value: Value {
        didSet {
            guard value != oldValue else { return }
            registerNewValue(value)
        }
    }

    public let key: String
    public let defaultValue: Value
    public let store: UserDefaults

    private let registerNewValue: (Value) -> Void

    public init(
        key: String,
        value defaultValue: Value,
        store: UserDefaults = .standard
    ) where Value: UserDefaultsElegible {

        self.key = key
        self.defaultValue = defaultValue
        self.store = store

        if let currentValue = store.value(forKey: key) as? Value {
            value = currentValue
        } else {
            value = defaultValue
            store.register(defaults: [key: defaultValue])
        }

        registerNewValue = { v in
            store.set(v, forKey: key)
        }
    }

    public init(
        key: String,
        value defaultValue: Value,
        store: UserDefaults = .standard
    ) where Value : RawRepresentable, Value.RawValue : UserDefaultsElegible {

        self.key = key
        self.defaultValue = defaultValue
        self.store = store

        if let rawValue = store.value(forKey: key) as? Value.RawValue,
           let v = Value(rawValue: rawValue) {

            value = v
        } else {
            value = defaultValue
            store.register(defaults: [key: defaultValue.rawValue])
        }

        registerNewValue = { v in
            store.set(v.rawValue, forKey: key)
        }
    }

    /// Resets the value of the default to its default value.
    public func reset() {
        value = defaultValue
    }

}
