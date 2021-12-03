//
//  ProfileViewController.swift
//  Reverb
//
//  Created by Kamakshi Raya on 19/11/21.
//

import UIKit
class ProfileViewController: UIViewController {

    @IBOutlet weak var arrowNextProfile: UIButton!
    @IBOutlet weak var dobProfile: UIDatePicker!
    @IBOutlet weak var nameInputProfile: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let b = SignUpViewController.usernameInputSignUp
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
