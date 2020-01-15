//
//  DetailViewController.swift
//  HoroscopeLab-Unit4
//
//  Created by Jaheed Haynes on 1/13/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit

class HoroscopePickerVC: UIViewController {
    
    @IBOutlet weak var horoscopeSignLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var name = ""
    
    let signs = ["aquarius", "pisces", "aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn"].sorted()
    
    private var list: String?
    
    var horoscope: Horoscope?
    
   
    //---------------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
       pickerView.delegate = self
        pickerView.dataSource = self
        
        list = signs.first
        textField.delegate = self
        
        saveData()
    }
    
    //---------------------------------------------------------------------------------------------------

    
    @IBAction func saveUserDataButton(_ sender: Any) {
        
        horoscopeSignLabel.text = "\(list ?? "leo")"
        
        let name = textField.text?.lowercased()
        
        let welcomeMessage = "\(name ?? "Jaheed")"
        
        nameLabel.text = welcomeMessage
        
        resignFirstResponder()
        
        updateUI()
        
    }
    
    
    
    let defaults = UserDefaults.standard
    
    
    
     func updateUI() {
         defaults.set(textField.text, forKey: UserPreferenceKey.userName)
         defaults.set(horoscopeSignLabel.text, forKey: UserPreferenceKey.sign)
         defaults.set(list, forKey: UserPreferenceKey.listName)
     }
    
    

     func saveData() {
        
         let name = defaults.value(forKey: UserPreferenceKey.userName) as? String ?? ""
        nameLabel.text = "\(name)".uppercased()
         
         let horoSigns = defaults.value(forKey: UserPreferenceKey.sign) as? String ?? ""
         horoscopeSignLabel.text = horoSigns
         
         let signArr = defaults.value(forKey: UserPreferenceKey.listName) as? String ?? ""
         list = signArr
         
     }
    
    @IBAction func horoscopeButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    
    
}



//-----------------------------------------------------------
// MARK: EXTENSIONS

extension HoroscopePickerVC: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return signs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       list = signs[row]
    }
 
}

extension HoroscopePickerVC: UIPickerViewDelegate {
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return signs[row]
      }
}

extension HoroscopePickerVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        resignFirstResponder()
        
        return true
        
    }
}
