//
//  UIViewController+Extensions.swift
//  Mindbody Demo
//
//  Created by Sohil Memon on 11/03/23.
//

import UIKit

//MARK: - UIViewController Extensions
/// Extensions which can be used inside controller
extension UIViewController {
    
    /// Show Spinner
    func showHUD(with message: String) {
        SwiftLoader.show(title: message, animated: true)
    }
    
    /// Hide Spinner
    func hideHUD() {
        SwiftLoader.hide()
    }
    
    /// Show Alert with two Button & Actions
    func showAlert(title: String = Constants.APP_NAME, message: String, leftButtonTitle: String, leftCompletionHandler: ((UIAlertAction) -> Void)? = nil, rightButtonTitle: String, rightCompletionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: leftButtonTitle, style: .default, handler: leftCompletionHandler))
        alert.addAction(UIAlertAction(title: rightButtonTitle, style: .default, handler: rightCompletionHandler))
        present(alert, animated: true, completion: nil)
    }
}
