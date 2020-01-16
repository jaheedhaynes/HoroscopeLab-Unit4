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
    @IBOutlet weak var textView: UITextView!
    
    var name = ""
    
    let signs = ["aquarius", "pisces", "aries", "taurus", "gemini", "cancer", "leo", "virgo", "libra", "scorpio", "sagittarius", "capricorn"].sorted()
    
    var zodiacSign: String?
    
    var horoscope: Horoscope?
    
    let defaults = UserDefaults.standard
    
   
    //---------------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        zodiacSign = signs.first
        textField.delegate = self
        
        loadHoroscopeData()
        
        saveData()
    }
    
    //---------------------------------------------------------------------------------------------------

    
    @IBAction func saveUserDataButton(_ sender: Any) {
        
        horoscopeSignLabel.text = "\(zodiacSign ?? "leo")"
        
        name = textField.text?.lowercased() ?? ""
        
        let topNameLabel = "\(name)"
        
        nameLabel.text = topNameLabel
        
        resignFirstResponder()
        
        updateUI()
        
    }
    
    
    
   
    
    
    
     func updateUI() {
        
         defaults.set(textField.text, forKey: UserPreferenceKey.userName)
        
         defaults.set(horoscopeSignLabel.text, forKey: UserPreferenceKey.sign)
        
         defaults.set(zodiacSign, forKey: UserPreferenceKey.listName)
     }
    
    

     func saveData() {
        
         let name = defaults.value(forKey: UserPreferenceKey.userName) as? String ?? ""
        nameLabel.text = "\(name)".uppercased()
         
         let horoSigns = defaults.value(forKey: UserPreferenceKey.sign) as? String ?? ""
         horoscopeSignLabel.text = horoSigns
         
         let signArr = defaults.value(forKey: UserPreferenceKey.listName) as? String ?? ""
         zodiacSign = signArr
         
     }
    
    func loadHoroscopeData(){
        // getting the "title" to the detailVC
        HoroscopeAPI.fetchHoroscope(for: title ?? "") {[weak self] (result) in
            
            switch result {
            case.failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "OK", message: "can't retrieve horoscope")
                    print(appError)
                }

            case .success(let sign):
                DispatchQueue.main.async {
                    self?.textView.text = sign.horoscope
                    // self?.signLabel.text =
                }
            }
        }
    }
    
    @IBAction func horoscopeButtonSegue(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Segue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
       zodiacSign = signs[row]
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
