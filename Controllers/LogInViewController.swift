//
//  LogInViewController.swift
//  Reverb
//
//  Created by Kamakshi Raya on 19/11/21.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var arrowLogIn: UIButton!
    @IBOutlet weak var errorLogIn: UILabel!
    @IBOutlet weak var passwordInputLogIn: UITextField!
    @IBOutlet weak var nameEmailInputLogIn: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpError()
        // Do any additional setup after loading the view.
    }
    
    func setUpError(){
        errorLogIn.alpha=0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logInTapped(_ sender: Any) {
        
    }
}
