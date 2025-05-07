//
//  EditProfileViewUITests.swift
//  TrainoraUITests
//
//  Created by Lahiru Hashan on 5/7/25.
//

import XCTest

final class EditProfileViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.textFields["emailTextField"].tap()
        app.textFields["emailTextField"].typeText("lahiru")

        app.secureTextFields["passwordSecureField"].tap()
        app.secureTextFields["passwordSecureField"].typeText("123")

        app.buttons["signInButton"].tap()
        XCTAssertTrue(app.staticTexts["Trainora"].waitForExistence(timeout: 5))
        app.buttons["profileIconButton"].tap()
        let signUpTitle = app.staticTexts["My Profile"]
        XCTAssertTrue(
            signUpTitle.waitForExistence(timeout: 3),
            "Should navigate to my profile")
        
        app.buttons["Edit Profile"].tap()
        XCTAssertTrue(
            app.staticTexts["Edit Profile"].waitForExistence(timeout: 3),
            "Should navigate to my profile")

    }

    func testTextFieldsArePresent() throws {
        XCTAssertTrue(app.textFields["firstNameField"].exists)
        XCTAssertTrue(app.textFields["lastNameField"].exists)
        XCTAssertTrue(app.textFields["emailField"].exists)
        XCTAssertTrue(app.textFields["mobileNumberField"].exists)
        XCTAssertTrue(app.textFields["weightField"].exists)
        XCTAssertTrue(app.textFields["heightField"].exists)
        XCTAssertTrue(app.segmentedControls["experienceLevelSegmented"].exists)
    }

    func testCanSelectExperienceLevel() throws {
        app.segmentedControls["experienceLevelSegmented"].buttons[
            "Intermediate"
        ].tap()
        XCTAssertTrue(
            app.segmentedControls["experienceLevelSegmented"].buttons[
                "Intermediate"
            ].isSelected)
    }

    func testSaveButtonIsEnabled() throws {
        XCTAssertTrue(app.buttons["saveProfileButton"].exists)
        XCTAssertTrue(app.buttons["saveProfileButton"].isEnabled)
    }

    func testSaveProfileButtonDismissesView() throws {
        app.buttons["saveProfileButton"].tap()
        XCTAssertFalse(app.navigationBars["Edit Profile"].exists)
    }
}
