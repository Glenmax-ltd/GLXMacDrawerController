//
//  CenterViewController.swift
//  GLXMacDrawerController
//
//  Created by Andriy Gordiychuk on 07/05/2017.
//  Copyright © 2017 Glenmax Ltd. All rights reserved.
//

import Foundation
import Cocoa

class CenterViewController:NSViewController {
    
    @IBAction func toggleDrawer(_ sender:NSButton) {
        
        guard let drawer = self.drawer else {return}
        
        if drawer.isOpen {
            drawer.close(animated: true)
            sender.title = "Open drawer"
        }
        else {
            drawer.open(animated: false)
            sender.title = "Close drawer"
        }
    
    }
    
}
