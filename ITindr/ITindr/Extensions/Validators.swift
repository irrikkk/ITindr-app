import Foundation

protocol Validator {
    func validate(text: String?) -> String?

}

struct RequiredFieldValidator: Validator {

    func validate(text: String?) -> String? {
        if text == nil || text?.trimmingCharacters(in: .whitespaces).isEmpty == true {
            return "Введите пароль"
        }
        return nil
    }
}

struct EmailValidator: Validator {
    func validate(text: String?) -> String? {
        if text == nil || text?.isEmpty == true {
            return "Введите email"
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: text!) ? nil : "Некорректный формат почты"
    }
}

struct PasswordMatchValidator: Validator {
    let originalPassword: () -> String

    func validate(text: String?) -> String? {
        if text == nil || text?.isEmpty == true {
            return "Подтвердите пароль"
        }
        if text != originalPassword() {
            return "Пароли не совпадают"
        }
        return nil
    }
}
