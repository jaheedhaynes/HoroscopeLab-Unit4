//
//  HoroscopeDetailVC.swift
//  HoroscopeLab-Unit4
//
//  Created by Jaheed Haynes on 1/14/20.
//  Copyright © 2020 Jaheed Haynes. All rights reserved.
//

import UIKit

class HoroscopeDetailVC: UIViewController {

    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    func loadHoroscopeData(){
        HoroscopeAPI.fetchHoroscope(for: title ?? "") {[weak self] (result) in
            switch result {
            case.failure(let appError):
                print(appError)
            case .success(let sign):
                DispatchQueue.main.async {
                    self?.textView.text = sign.horoscope
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHoroscopeData()
        
    }

}
