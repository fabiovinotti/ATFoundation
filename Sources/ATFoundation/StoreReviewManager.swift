//
//  StoreReviewManager.swift
//  ATFoundation
//
//  Copyright © 2022 Fabio Vinotti. All rights reserved.
//  Licensed under MIT License.
//

import StoreKit

public class StoreReviewManager {

    private static let lastRequestDate = UserDefault<Date>(
        key: "review-manager.last-request-date",
        value: Date(timeIntervalSince1970: 0))

    private static let lastVersionDetected = UserDefault<String>(
        key: "review-manager.last-version-detected",
        value: "")

    private static let newVersionDetectedDate = UserDefault<Date>(
        key: "review-manager.new-version-detected-date",
        value: Date(timeIntervalSince1970: 0))

    // MARK: - Properties

    /// The minimum amount of days that must elapse before asking for a new request.
    public var daysThreshold: Int = 0

    /// The last time the user was prompted to rate or review the app.
    public var lastRequestDate: Date {
        Self.lastRequestDate.value
    }

    /// When a new version of the app has been detected.
    public var versionChangedDate: Date {
        Self.newVersionDetectedDate.value
    }

    public let appID: String

    public var productURL: URL {
        let urlString = "https://apps.apple.com/app/id\(appID)"

        guard let url = URL(string: urlString) else {
            fatalError("productURL creation failed.")
        }

        return url
    }

    /// Whether the conditions to request a review are met.
    private var shouldRequestReview: Bool {
        let daysSinceLastRequest = Calendar.current.elapsedDays(since: lastRequestDate)
        let daysSinceVersionChanged = Calendar.current.elapsedDays(since: versionChangedDate)

        if daysSinceLastRequest < daysThreshold || daysSinceVersionChanged < daysThreshold {
            return false
        }

        for condition in requirements {
            if condition() == false {
                return false
            }
        }

        return true
    }

    /// An array of closures that must all return true in order to prompt users.
    private var requirements = [() -> Bool]()

    // MARK: - Methods

    public init(appID: String) {
        self.appID = appID

        // Check app version
        let currentAppVersion = Bundle.main.version
        if Self.lastVersionDetected.value != currentAppVersion {
            Self.lastVersionDetected.value = currentAppVersion
            Self.newVersionDetectedDate.value = Date()
            Self.lastRequestDate.value = Date(timeIntervalSince1970: 0)
        }
    }

    /// Prompts the user to rate or review the app if the requirements are met.
    public func requestReviewIfNeeded() {
        guard shouldRequestReview else { return }
        requestReview()
    }

    /// Prompts the user to rate or review the app.
    public func requestReview() {
        DispatchQueue.main.async() {
            guard let activeScene = UIWindowScene.foregroundActive else { return }
            SKStoreReviewController.requestReview(in: activeScene)
            Self.lastRequestDate.value = Date()
        }
    }

    /// Add a requirement that must be satified in order to prompt the user for a review.
    ///
    /// Provide a closure that returns true when your requirement is satisfied.
    public func addRequirement(_ requirement: @escaping () -> Bool) {
        requirements.append(requirement)
    }

    /// Opens a page on which users can write a review in the App Store.
    public func writeReviewInStore() {
        let reviewURLString = productURL.absoluteString + "?action=write-review"
        guard let reviewURL = URL(string: reviewURLString) else { return }
        UIApplication.shared.open(reviewURL, options: [:])
    }

}
