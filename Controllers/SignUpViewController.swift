//
//  SignUpViewController.swift
//  Reverb
//
//  Created by Kamakshi Raya on 19/11/21.
//
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var arrowSignUp: UIButton!
    @IBOutlet weak var passwordInputSignUp: UITextField!
    @IBOutlet weak var usernameInputSignUp: UITextField!
    @IBOutlet weak var emailInputSignUp: UITextField!
    @IBOutlet weak var errorSignUp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpError()
        usernameInputSignUp.delegate = self
        emailInputSignUp.delegate = self
        passwordInputSignUp.delegate = self
        // Do any additional setup after loading the view.
    }
    func setUpError(){
        errorSignUp.alpha=0
    }
    func validateSignUpFields() -> String?{
        //check all fields are filled
        if(usernameInputSignUp.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || emailInputSignUp.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || passwordInputSignUp.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            return "Please fill in all the fields"
        }
        //check if password is secure
        let cleanedPassword = passwordInputSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(SignUpViewController.isPasswordValid(cleanedPassword) == false){
            return "the password should be 8 characters long, contain a special character and a number"
        }
        //
        return nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signUpTapped(_ sender: UIButton) {
        //validate fields
        emailInputSignUp.endEditing(true)
        passwordInputSignUp.endEditing(true)
        usernameInputSignUp.endEditing(true)
        let error = validateSignUpFields()
        if(error != nil){
            showError(error!)
        }
        else{
            //create cleaned versions of data
            let Username = usernameInputSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Email = emailInputSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let Password = passwordInputSignUp.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //create user
            Auth.auth().createUser(withEmail: Email, password: Password) { result, err in
                //check for errors
                if err != nil{
                    //err?.localizedDescription
                    //there's an error
                    self.showError("Error creating user")
                }
                else{
                    //user was created successfully
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["Username": Username, "uid": result!.user.uid]){(error) in
                        if error != nil{
                            //show error message
                            self.showError("Error! Try after sometime")
                        }
                    }
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameInputSignUp.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(usernameInputSignUp.text != ""){
            return true
        }
        else{
            errorSignUp.text = "Please fill in all the fields"
            return false
        }
    }
    static func isPasswordValid(_ password : String) -> Bool{
        let passwordTest=NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func showError(_ message: String){
        errorSignUp.text=message
        errorSignUp.alpha=1
    }
    func profileFromSignUp(){
        let pvc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.ProfileViewController) as? ProfileViewController
        view.window?.rootViewController = pvc
        view.window?.makeKeyAndVisible()
    }
}
