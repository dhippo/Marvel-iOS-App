//
//  ViewController.swift
//  trainingApp
//
//  Created by Reda Mimouni on 09/01/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userNameTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?

    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClick() {
        if self.viewModel.onClick(
            login: userNameTextField?.text,
            password: passwordTextField?.text
        ) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController")
                        
            self.present(detailViewController, animated: true)
                    

        } else {
            let alertFailure = UIAlertController(title: "Erreur", message: "Erreur de login/mot de passe", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "Ok", style: .default)
            alertFailure.addAction(action)
            self.present(alertFailure, animated: true)
        }
    }
}

