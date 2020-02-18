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
    
    let leftMotors = DCMotor()
    let rightMotors = DCMotor()
    let sonar = DistanceSensor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        do{
            //Connect to wireless rover
            try Net.addServer(serverName: "", address: "192.168.100.1", port: 5661, flags: 0)
            //Address
            try leftMotors.setHubPort(5)
            try leftMotors.setChannel(0)
            try rightMotors.setHubPort(5)
            try rightMotors.setChannel(1)
            //Open
            try leftMotors.open()
            try rightMotors.open()
            try sonar.setHubPort(2)
        } catch {
            print(error)
        }
    }
    // MARK
    @IBAction func moveRover(_ sender: Any, distance:UInt32) {
    do  {
            //Move forward at full speed
            try leftMotors.setTargetVelocity(-1.0)
            try rightMotors.setTargetVelocity(-1.0)
            //Wait for 1 second
            sleep(1)
            //Stop motors
            try leftMotors.setTargetVelocity(0.0)
            try rightMotors.setTargetVelocity(0.0)
            sleep(2)
            try leftMotors.setTargetVelocity(1.0)
            try rightMotors.setTargetVelocity(-1.0)
            sleep(1)
            try leftMotors.setTargetVelocity(0.0)
            try rightMotors.setTargetVelocity(0.0)
        }catch{
            print(error)
        }
    }

}

