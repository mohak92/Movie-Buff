//
//  Movie_BuffUITestsLaunchTests.swift
//  Movie-BuffUITests
//
//  Created by Mohak Tamhane on 4/17/24.
//

// swiftlint:disable all
import XCTest

final class MovieBuffUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testFirstLaunch() {
        let app = XCUIApplication()
        app.launchArguments += ["onboarding", "false"]
        app.launch()
    }
    

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchArguments += ["onboarding", "true"]
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testNavigation() throws {
        let app = XCUIApplication()
        app.launchArguments += ["onboarding", "true"]
        app.launch()
        
        let tabBar = XCUIApplication().tabBars["Tab Bar"]

        tabBar.buttons["Actor"].tap()
        tabBar.buttons["Lists"].tap()
    }

    func navigateSubViews() throws {
        let app = XCUIApplication()
        app.launchArguments += ["onboarding", "true"]
        app.launch()
        let scrollViewsQuery = app.scrollViews
        let trendingElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier: "Trending")
        // swiftlint:disable:next line_length
        trendingElementsQuery.children(matching: .scrollView).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 0).tap()

        let monkeyManElement = scrollViewsQuery.otherElements.containing(.staticText, identifier: "Monkey Man").element
        monkeyManElement.swipeUp()

        let monkeyManElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier: "Monkey Man")
        monkeyManElementsQuery.children(matching: .other).element.swipeUp()

        let elementsQuery = scrollViewsQuery.otherElements.scrollViews.otherElements
        elementsQuery.buttons["Pitobash"].swipeUp()
        monkeyManElement.swipeUp()
        elementsQuery.buttons["Dev Patel"].tap()
        // swiftlint:disable:next line_length
        scrollViewsQuery.otherElements.containing(.staticText, identifier: "Dev Patel").children(matching: .other).element.swipeUp()

        let backButton = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Back"]
        backButton.tap()
        // swiftlint:disable:next line_length
        monkeyManElementsQuery.children(matching: .button).matching(identifier: "See All").element(boundBy: 0).staticTexts["See All"].tap()
        app.navigationBars["Cast"].buttons["Back"].tap()
        backButton.tap()
        // swiftlint:disable:next line_length
        trendingElementsQuery.children(matching: .button).matching(identifier: "See All").element(boundBy: 0).staticTexts["See All"].tap()
        app.navigationBars["Trending"].buttons["Back"].tap()
    }

    func testButtons() throws {
        let app = XCUIApplication()
        app.launchArguments += ["onboarding", "true"]
        app.launch()
        
        let trendingElementsQuery = app.scrollViews.otherElements.containing(.staticText, identifier: "Trending")
        // swiftlint:disable:next line_length
        trendingElementsQuery.children(matching: .button).matching(identifier: "See All").element(boundBy: 0).staticTexts["See All"].tap()
        app.navigationBars["Trending"].buttons["Back"].tap()

        // swiftlint:disable:next line_length
        let ttgc7swiftui32navigationstackhostingNavigationBar2 = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"]
        let ttgc7swiftui32navigationstackhostingNavigationBar = ttgc7swiftui32navigationstackhostingNavigationBar2
        ttgc7swiftui32navigationstackhostingNavigationBar/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".otherElements[\"Search\"].buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Search"].buttons["Back"].tap()
        trendingElementsQuery.children(matching: .button).element(boundBy: 0).tap()
    }
}

extension XCUIApplication {
    func uninstall(name: String? = nil) {
        self.terminate()

        let timeout = TimeInterval(10)
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

        let appName: String
        if let name = name {
            appName = name
        } else {
            let uiTestRunnerName = Bundle.main.infoDictionary?["CFBundleName"] as! String
            appName = uiTestRunnerName.replacingOccurrences(of: "UITests-Runner", with: "")
        }

        /// use `firstMatch` because icon may appear in iPad dock
        let appIcon = springboard.icons[appName].firstMatch
        if appIcon.waitForExistence(timeout: timeout) {
            appIcon.press(forDuration: 2)
        } else {
            XCTFail("Failed to find app icon named \(appName)")
        }

        let removeAppButton = springboard.buttons["Remove App"]
        if removeAppButton.waitForExistence(timeout: timeout) {
            removeAppButton.tap()
        } else {
            XCTFail("Failed to find 'Remove App'")
        }

        let deleteAppButton = springboard.alerts.buttons["Delete App"]
        if deleteAppButton.waitForExistence(timeout: timeout) {
            deleteAppButton.tap()
        } else {
            XCTFail("Failed to find 'Delete App'")
        }

        let finalDeleteButton = springboard.alerts.buttons["Delete"]
        if finalDeleteButton.waitForExistence(timeout: timeout) {
            finalDeleteButton.tap()
        } else {
            XCTFail("Failed to find 'Delete'")
        }
    }
}
// swiftlint:enable all
