//
//  ViewController.swift
//  kasra compony
//
//  Created by Kiarash Karimian on 9/12/22.
//

import UIKit


enum Error {
    
    case regularEXP
}
class ViewController: UIViewController, UITextFieldDelegate {

   @IBOutlet weak var TxtcheckResulat: UITextField! // check regular expression
   
    //salam halet khobe?
    
    let viewNib = UIView() // for constraint
    let imgLogo = UIImageView() // for constraint logo from viewNib
    let lbltitle = UILabel() // for constraint title from viewNib
    let btnChangeText = UIButton() //for constraint and reverse code
    let btnSaveText = UIButton() //for constraint and save code
    
    var arrChar : [Character] = [] // array for reverse word
    var reverseStr = "" //first summery of revers value
    var temp = ""  //temp summery of revers value
    
    let dbFetchSave = data()// fetch and save from data base
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TxtcheckResulat.delegate = self
        dbFetchSave.fetchDB(TxtcheckResulat)
        
    }

@IBAction func regular(_ sender: UITextField) {
        
    let pattern = "[a-zA-Z0-9.<>:,!@#$%^&*()_+?><.~}{|]{4,}"

    let text = TxtcheckResulat.text
    
  
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            if regex.firstMatch(in: text!, options: [], range: NSMakeRange(0, text!.count)) != nil {
                 
                let alert = UIAlertController(title: "Format is wrong", message: "you must enter similar format. abc-def", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                    
                    self.TxtcheckResulat.text?.removeLast()
                   
                }))
                self.present(alert, animated: true, completion: nil)

            }
        }
        catch {return}
    }
   
    
    @IBAction func popup(_ sender: UIButton) {
        
// MARK: viewNib on View

       
        viewNib.backgroundColor = .lightGray
        viewNib.layer.cornerRadius = 20
        viewNib.layer.shadowColor = UIColor.black.cgColor
        viewNib.layer.shadowOpacity = 0.5
        view.addSubview(viewNib)
        
      
        let viewNibTopAndBottom:Double = (self.view.frame.height * 20.0)/100.0
        let ViewNibLeftAndRight:Double = (self.view.frame.width * 10.0)/100.0
        
        showObj(item: viewNib, toitem: view, top: viewNibTopAndBottom, bottom: viewNibTopAndBottom, left: ViewNibLeftAndRight, right: ViewNibLeftAndRight)
        
// MARK: Logo on viewNib----------------------------------------------------

        imgLogo.image = UIImage(named: "kasra-80.jpg")
        viewNib.addSubview(imgLogo)
        
        let imgLogoTopAndBottom:Double = (self.view.frame.height * 40.0)/100.0
        let imgLogoLeftAndRight:Double = (self.view.frame.width * 25.0)/100.0
        
        showObj(item: imgLogo, toitem: viewNib, top: 20, bottom: imgLogoTopAndBottom, left: imgLogoLeftAndRight, right: imgLogoLeftAndRight)
        
// MARK: title on viewNib---------------------------------------------------
        
        
        lbltitle.text = "شرکت مهندسی کسرا"
        lbltitle.textAlignment = .center
        lbltitle.textColor = .white
        lbltitle.font = UIFont.systemFont(ofSize: 20)
        lbltitle.layer.cornerRadius = 20
        lbltitle.layer.shadowColor = UIColor.black.cgColor
        lbltitle.layer.shadowOpacity = 1
        viewNib.addSubview(lbltitle)
        
        let titleTopAndBottom:Double = (self.view.frame.height * 35.0)/100.0
        let titleLeftAndRight:Double = (self.view.frame.width * 15.0)/100.0
        
        showObj(item: lbltitle, toitem: viewNib, top: 115 , bottom: titleTopAndBottom, left: titleLeftAndRight, right: titleLeftAndRight)
        
// MARK: button reverse text--------------------------------------------------
        
        btnChangeText.setTitle("Reverse code", for: .normal)
        btnChangeText.setTitleColor(.blue, for: .normal)
        btnChangeText.layer.cornerRadius = 5
        btnChangeText.layer.shadowColor = UIColor.black.cgColor
        btnChangeText.addTarget(self, action: #selector(ReverseText), for: .touchUpInside)
        
        viewNib.addSubview(btnChangeText)
        
        let changeTextTopAndBottom:Double = (viewNib.frame.height * 10.0)/100.0
        let changeTextLeftAndRight:Double = (viewNib.frame.width * 10.0)/100.0
        showObj(item: btnChangeText, toitem: viewNib, top: 350 , bottom: changeTextTopAndBottom, left: changeTextLeftAndRight-150, right: changeTextLeftAndRight)
        

// MARK: button save text-----------------------------------------------------
        
        btnSaveText.setTitle("Save code", for: .normal)
        btnSaveText.setTitleColor(.blue, for: .normal)
        btnSaveText.layer.cornerRadius = 5
        btnSaveText.layer.shadowColor = UIColor.black.cgColor
        btnSaveText.addTarget(self, action: #selector(SaveTexts), for: .touchUpInside)
        
        viewNib.addSubview(btnSaveText)
        
        let saveTextTopAndBottom:Double = (viewNib.frame.height * 10.0)/100.0
        let saveTextLeftAndRight:Double = (viewNib.frame.width * 10.0)/100.0
        showObj(item: btnSaveText, toitem: viewNib, top: 350 , bottom: saveTextTopAndBottom, left: saveTextLeftAndRight+180, right: saveTextLeftAndRight)
    
}
    @objc func ReverseText() { //for example : abc-def ---> cba-fed
        
        if TxtcheckResulat.text?.isEmpty != true  {
            
            let string : String = TxtcheckResulat.text!
            let characters = Array(string)
            
            for i in 0..<characters.count
            {
                if characters[i] != "-"{
                    
                   arrChar.append(characters[i])
                
            }else{
                
                    for each in arrChar
                    {
                        reverseStr = String(each) + reverseStr
                    }
                        reverseStr = reverseStr + "-"
                        arrChar.removeAll()
               
                }
           }

            for each in arrChar
            {
                temp = String(each) + temp
            }
                
                
                TxtcheckResulat.text = reverseStr + temp
                arrChar.removeAll()
                temp = ""
                reverseStr = ""
            
                removeAllViewNibObj()
        }else{
              
                 let alert = UIAlertController(title: "Enter your code please", message: nil, preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                 self.present(alert, animated: true, completion: nil)
               }
        
    }
    
    @objc func SaveTexts() { // Fetch and Save text
        
        
        dbFetchSave.saveDB(TxtcheckResulat)
        
        removeAllViewNibObj()
             
    }
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
    }
// MARK: Touch
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
            let touch = touches.first
            if touch?.view == self.view {

                removeAllViewNibObj()
   }
}

  func removeAllViewNibObj() { // remove all objects are in viewNib
        
            viewNib.removeFromSuperview()
            imgLogo.removeFromSuperview()
            lbltitle.removeFromSuperview()
            btnChangeText.removeFromSuperview()
    }
}

// MARK: implement all Constraints
extension ViewController{
    
   public func showObj(item : UIView,toitem: UIView , top : Double, bottom : Double, left : Double, right : Double) {
        
        item.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint(item: item,
                                   attribute: .topMargin,
                                   relatedBy: .equal,
                                   toItem: toitem,
                                   attribute: .topMargin,
                                   multiplier: 1,
                                   constant: top).isActive = true

                NSLayoutConstraint(item: item,
                                   attribute: .bottomMargin,
                                   relatedBy: .equal,
                                   toItem: toitem,
                                   attribute: .bottomMargin,
                                   multiplier: 1,
                                   constant: -bottom).isActive = true
            
                NSLayoutConstraint(item: item,
                                   attribute: .leadingMargin,
                                   relatedBy: .equal,
                                   toItem: toitem,
                                   attribute: .leadingMargin,
                                   multiplier: 1,
                                   constant: left).isActive = true
            
                NSLayoutConstraint(item: item,
                                   attribute: .trailingMargin,
                                   relatedBy: .equal,
                                   toItem: toitem,
                                   attribute: .trailingMargin,
                                   multiplier: 1,
                                   constant: -right).isActive = true

        
    }
}

