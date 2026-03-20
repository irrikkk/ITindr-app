import XCTest

final class ITindrUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    @MainActor
    func testWelcomeScreenElementsAreVisible() throws {
        let logoImage = app.images["logoImageView"]
        XCTAssertTrue(logoImage.waitForExistence(timeout: 2))
        XCTAssertTrue(logoImage.isHittable)

        let title = app.staticTexts["logoLabel"]
        XCTAssertTrue(title.waitForExistence(timeout: 2))

        let background = app.images["backgroundImageView"]
        XCTAssertTrue(background.waitForExistence(timeout: 2))

        let registrationButton = app.otherElements["registrationButton"]
        XCTAssertTrue(registrationButton.waitForExistence(timeout: 2))
        XCTAssertTrue(registrationButton.isEnabled)

        let loginButton = app.otherElements["loginButton"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 2))
        XCTAssertTrue(loginButton.isEnabled)
        XCTAssertTrue(loginButton.isHittable)
    }

    @MainActor
    func testBackButtonFromRegistrationReturnsToWelcomeScreen() throws {
        let registrationButton = app.otherElements["registrationButton"]
        XCTAssertTrue(registrationButton.waitForExistence(timeout: 2))
        registrationButton.tap()

        let backButton = app.otherElements["registerBackButton"]
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        let logoImage = app.images["logoImageView"]
        XCTAssertTrue(logoImage.exists)
    }

    @MainActor
    func testBackButtonFromLoginReturnsToWelcomeScreen() throws {
        let loginButton = app.otherElements["loginButton"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 2))
        loginButton.tap()

        let backButton = app.otherElements["loginBackButton"]
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        let logoImage = app.images["logoImageView"]
        XCTAssertTrue(logoImage.exists)
    }

    @MainActor
    func testNavigationToMainScreen() throws {
        let registrationButton = app.otherElements["registrationButton"]
        XCTAssertTrue(registrationButton.waitForExistence(timeout: 2))
        registrationButton.tap()

        let emailField = app.otherElements["emailTextField"]
        XCTAssertTrue(emailField.exists)
        emailField.tap()
        emailField.typeText("test@mail.com")

        let passwordField = app.otherElements["passwordTextField"]
        XCTAssertTrue(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("123456")

        let confirmPasswordField = app.otherElements["confirmPasswordTextField"]
        XCTAssertTrue(confirmPasswordField.exists)
        confirmPasswordField.tap()
        confirmPasswordField.typeText("123456")

        app.tap()

        let registerButton = app.otherElements["registerSubmitButton"]
        XCTAssertTrue(registerButton.isEnabled)
        registerButton.tap()

        let skipButton = app.buttons["skipButton"]
        skipButton.tap()

        let mainScreen = app.otherElements["mainScreen"]
        XCTAssertTrue(mainScreen.exists)
    }

    @MainActor
    func testRegistrationScreenElementsAreVisible() throws {
        let registrationButton = app.otherElements["registrationButton"]
        XCTAssertTrue(registrationButton.waitForExistence(timeout: 2))
        registrationButton.tap()

        let title = app.staticTexts["registrationTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 2))

        let emailField = app.otherElements["emailTextField"]
        XCTAssertTrue(emailField.exists)

        let passwordField = app.otherElements["passwordTextField"]
        XCTAssertTrue(passwordField.exists)

        let confirmPasswordField = app.otherElements["confirmPasswordTextField"]
        XCTAssertTrue(confirmPasswordField.exists)

        let registerSubmitButton = app.otherElements["registerSubmitButton"]
        XCTAssertTrue(registerSubmitButton.exists)

        let backButton = app.otherElements["registerBackButton"]
        XCTAssertTrue(backButton.exists)

    }

    @MainActor
    func testLoginScreenElementsAreVisible() throws {
        let loginButton = app.otherElements["loginButton"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 2))
        loginButton.tap()

        let title = app.staticTexts["loginTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 2))

        let emailField = app.otherElements["emailTextField"]
        XCTAssertTrue(emailField.exists)

        let passwordField = app.otherElements["passwordTextField"]
        XCTAssertTrue(passwordField.exists)

        let loginSubmitButton = app.otherElements["loginSubmitButton"]
        XCTAssertTrue(loginSubmitButton.exists)

        let backButton = app.otherElements["loginBackButton"]
        XCTAssertTrue(backButton.exists)
    }
}
