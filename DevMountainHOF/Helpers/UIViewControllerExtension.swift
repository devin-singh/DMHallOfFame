//
//  UIViewControllerExtension.swift
//  DevMountainHOF
//
//  Created by Devin Singh on 1/23/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
