//
//  ViewController.swift
//  phidget
//
//  Created by Matthew Toms-Zuberec on 2020-02-04.
//  Copyright © 2020 Matthew Toms-Zuberec. All rights reserved.
//

import UIKit
import Phidget22Swift

class ViewController: UIViewController {
    
    let redLed = DigitalOutput()
    
    func attachHandler(sender:Phidget){
        print("Red Light is attached")
        do{
            try redLed.setState(true)
        } catch {
        print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        do{
            // enable discovery
            try Net.enableServerDiscovery(serverType: .deviceRemote)
            // setup phidget address
            try redLed.setDeviceSerialNumber(528068)
            try redLed.setHubPort(1)
            try redLed.setIsHubPortDevice(true)
            let _ = redLed.attach.addHandler(attachHandler)
            // turn red LED on
            try redLed.open()
        } catch {
            print(error)
        }
    }


}

