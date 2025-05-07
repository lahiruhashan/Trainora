//
//  SignInViewUITests.swift
//  TrainoraUITests
//
//  Created by Lahiru Hashan on 5/7/25.
//

import XCTest

final class SignInViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testEmptyEmailAndPassword_ShowsAlert() {
        // Tap Sign In without entering email or password
        app.buttons["signInButton"].tap()

        // Assert alert is shown
        let alert = app.alerts["Invalid Email or Password"]
        XCTAssertTrue(alert.waitForExistence(timeout: 2), "Alert should appear for empty fields")
    }

    func testInvalidEmailAndPassword_ShowsAlert() {
        let emailTextField = app.textFields["emailTextField"]
        let passwordSecureField = app.secureTextFields["passwordSecureField"]

        emailTextField.tap()
        emailTextField.typeText("wrong@example.com")

        passwordSecureField.tap()
        passwordSecureField.typeText("wrongpass")

        app.buttons["signInButton"].tap()

        let alert = app.alerts["Invalid Email or Password"]
        XCTAssertTrue(alert.waitForExistence(timeout: 2), "Alert should appear for invalid credentials")
    }

    func testValidEmailAndPassword_NoAlert() {
        let emailTextField = app.textFields["emailTextField"]
        let passwordSecureField = app.secureTextFields["passwordSecureField"]

        emailTextField.tap()
        emailTextField.typeText("lahiru") // use a valid test account from your mock/CoreData

        passwordSecureField.tap()
        passwordSecureField.typeText("123") // use matching password

        app.buttons["signInButton"].tap()

        let alert = app.alerts["Invalid Email or Password"]
        XCTAssertFalse(alert.waitForExistence(timeout: 2), "Alert should NOT appear for valid credentials")
    }

    func testSignUpNavigation() {
        app.buttons["signUpButton"].tap()

        let signUpTitle = app.staticTexts["Create Account"]
        XCTAssertTrue(signUpTitle.waitForExistence(timeout: 3), "Should navigate to Sign Up screen")
    }
}
