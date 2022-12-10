//
//  UserDefaultTests.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import XCTest
import ATFoundation

final class UserDefaultTests: XCTestCase {

    private var testDefault: UserDefault<String>!

    override func setUp() {
        let testKey = "user-default-test-key"
        let testDefaultValue = "user-default-test-value"

        testDefault = UserDefault<String>(
        key: testKey,
        value: testDefaultValue,
        store: .standard)

        XCTAssertEqual(testDefault.key, testKey)
        XCTAssertEqual(testDefault.defaultValue, testDefaultValue)
        XCTAssertEqual(testDefault.value, testDefaultValue)
    }

    override func tearDown() {
        testDefault.store.removeObject(forKey: testDefault.key)
        XCTAssertNil(testDefault.store.string(forKey: testDefault.key))
        testDefault = nil
    }

    func testSettingValue() {
        let newValue = "new-value"
        testDefault.value = newValue
        XCTAssertEqual(testDefault.value, newValue)

        let valueInDefaults = testDefault.store.string(forKey: testDefault.key)
        XCTAssertEqual(valueInDefaults, newValue)
    }

    func testReset() {
        testDefault.value = "new-value"
        XCTAssertNotEqual(testDefault.value, testDefault.defaultValue)

        testDefault.reset()
        XCTAssertEqual(testDefault.value, testDefault.defaultValue)

        let valueInDefaults = testDefault.store.string(forKey: testDefault.key)
        XCTAssertEqual(valueInDefaults, testDefault.defaultValue)
    }

}
