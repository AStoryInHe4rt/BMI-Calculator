//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Maurice-School on 8/11/18.
//  Copyright © 2018 Maurice-School. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {

    @IBOutlet weak var measurementSwitch: UISwitch!
    @IBOutlet weak var measurementLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    
    var weight: Float = 0.0
    var height: Float = 0.0

    
    /*
    let heightValueArray: [String] = ["4'8", "4'9", "4'10", "4'11", "5'0", "5'1",
                                      "5'2", "5'3", "5'4", "5'5", "5'6", "5'7", "5'8",
                                      "5'9", "5'10", "5'11", "6'0", "6'1", "6'2", "6'3",
                                      "6'4", "6'5", "6'6", "6'7", "6'8", "6'9", "6'10",
                                      "6'11", "7'0", "7'1", "7'2", "7'3", "7'4", "7'5"]
    */
    
    
    
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        bmiLabel.isHidden = false
        resultLabel.isHidden = false
        weight = ((weightTextField.text! as NSString).floatValue)
        height = ((heightTextField.text! as NSString).floatValue)
        
        if measurementSwitch.isOn {
            bmiLabel.text = String (calculateBMIMetric(weightInKG: weight, heightInCM: height))
            calculateBMIZone(bmi: calculateBMIMetric(weightInKG: weight, heightInCM: height))
        } else {
            bmiLabel.text = String (calculateBMIImperial(weightInPounds: weight, heightInInches: height))
            calculateBMIZone(bmi: calculateBMIImperial(weightInPounds: weight, heightInInches: height))
        }
    }
    
    
    @IBAction func switchMeasurement(_ sender: UISwitch) {
        if sender.isOn {
            measurementLabel.text = "Measurement system: Metric"
        } else {
            measurementLabel.text = "Measurement system: Imperial"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 8.0
        calculateButton.layer.borderWidth = 1.5
        calculateButton.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateBMIMetric(weightInKG: Float, heightInCM: Float) -> Float {
        var BMI: Float = 0.0
        
        if (heightInCM <= 0.0 || weightInKG <= 0.0) {
            return 0.0
        }
        
        BMI = (weightInKG / (heightInCM * heightInCM))
        
        return BMI.truncate(places: 1)
        
    }
    
    func calculateBMIImperial(weightInPounds: Float, heightInInches: Float) -> Float {
        var BMI: Float = 0.0
        
        if (heightInInches <= 0.0 || weightInPounds <= 0.0) {
            return 0.0
        }
        
        BMI = (weightInPounds  / (heightInInches * heightInInches)) * 703
        
        return BMI.truncate(places: 1)
    }
    
    func calculateBMIZone(bmi: Float) {
        if (bmi < 18.5) {
            resultLabel.text = "Your BMI value falls within the underweight range."
            self.view.backgroundColor = UIColor.cyan
        } else if (bmi >= 18.5 && bmi < 25.0) {
            resultLabel.text = "Your BMI value falls within the normal range."
            self.view.backgroundColor = UIColor.green
        } else if (bmi >= 25.0 && bmi < 30.0) {
            resultLabel.text = "Your BMI value falls within the overweight range."
            self.view.backgroundColor = UIColor.yellow
        } else if (bmi > 30.0) {
            resultLabel.text = "Your BMI value falls within the obese range."
            self.view.backgroundColor = UIColor.orange
        }
    }
       

}

extension Float {
    
    func truncate(places : Int) -> Float {
        
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
    }
}

