//
//  GLXMacDraweController.swift
//  theoryTest
//
//  Created by Andriy Gordiychuk on 21/03/2017.
//
//

import Foundation
import Cocoa

public extension NSViewController {
    public var drawer:GLXMacDrawerController? {
        if let parent = self.parent {
            if let drawer = parent as? GLXMacDrawerController {
                return drawer
            }
            else {
                return parent.drawer
            }
        }
        return nil
    }
}

open class GLXMacControllerSegue: NSStoryboardSegue {
    override open func perform() {
        if self.destinationController is NSViewController {
            assert(true)
        }
        else {
            assert(false)
        }
    }
}

open class GLXMacDrawerController:NSViewController {
    
    open var isOpen = false {
        didSet {
            centerButton.isHidden = !isOpen
        }
    }
    
    open var openDrawerWidth:CGFloat = 300 {
        didSet {
            widthConstraint?.constant = openDrawerWidth
        }
    }
    
    open var centerViewBackgroundColor = NSColor(calibratedRed: 0.92, green: 0.92, blue: 0.92, alpha: 1.0) {
        didSet {
            self.centerBox.fillColor = self.centerViewBackgroundColor
        }
    }
    
    open lazy var centerBox:NSBox = {
        let box = NSBox()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.titlePosition = .noTitle
        box.boxType = .custom
        box.borderType = .noBorder
        box.fillColor = self.centerViewBackgroundColor
        box.contentViewMargins = NSSize(width: 0, height: 0)
        return box
    }()
    
    open lazy var centerButton:NSButton = {
        let button = NSButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isBordered = false
        button.target = self
        button.action = #selector(closeAnimated)
        button.title = ""
        button.setButtonType(.momentaryChange)
        return button
    }()
    
    open var centerViewController:NSViewController? {
        willSet {
            if let controller = self.centerViewController {
                controller.removeFromParentViewController()
                controller.view.removeFromSuperview()
            }
        }
        didSet {
            if let viewController = centerViewController {
                if !childViewControllers.contains(viewController) {
                    self.addChildViewController(viewController)
                    centerBox.addSubview(viewController.view)
                    viewController.view.translatesAutoresizingMaskIntoConstraints = false
                    viewController.view.topAnchor.constraint(equalTo: centerBox.topAnchor).isActive = true
                    viewController.view.bottomAnchor.constraint(equalTo: centerBox.bottomAnchor).isActive = true
                    viewController.view.trailingAnchor.constraint(equalTo: centerBox.trailingAnchor).isActive = true
                    viewController.view.leadingAnchor.constraint(equalTo: centerBox.leadingAnchor).isActive = true
                }
            }
        }
    }
    
    open var leftViewController:NSViewController? {
        willSet {
            if let controller = self.leftViewController {
                controller.removeFromParentViewController()
                controller.view.removeFromSuperview()
            }
        }
        didSet {
            if let viewController = leftViewController {
                if !childViewControllers.contains(viewController) {
                    self.insertChildViewController(viewController, at: 0)
                    self.view.addSubview(viewController.view, positioned: .below, relativeTo: centerBox)
                    viewController.view.translatesAutoresizingMaskIntoConstraints = false
                    viewController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                    viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                    viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                    widthConstraint = viewController.view.widthAnchor.constraint(equalToConstant: openDrawerWidth)
                    widthConstraint?.isActive = true
                }
            }
        }
    }
    
    fileprivate var leadingNavigationConstraint:NSLayoutConstraint?
    fileprivate var trailingNavigationConstraint:NSLayoutConstraint?
    fileprivate var widthConstraint:NSLayoutConstraint?
    
    convenience init(leftController:NSViewController,centerController:NSViewController) {
        self.init()
        self.leftViewController = leftController
        self.centerViewController = centerController
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        if self.storyboard != nil {
            self.performSegue(withIdentifier: "center_controller", sender: self)
            self.performSegue(withIdentifier: "left_controller", sender: self)
        }
        
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(centerBox, positioned: .above, relativeTo: leftViewController?.view)
        self.view.topAnchor.constraint(equalTo: centerBox.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: centerBox.bottomAnchor).isActive = true
        
        self.leadingNavigationConstraint = centerBox.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        self.leadingNavigationConstraint?.isActive = true
        self.trailingNavigationConstraint = centerBox.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.trailingNavigationConstraint?.isActive = true
        
        self.view.addSubview(centerButton, positioned: .above, relativeTo: centerBox)
        self.view.topAnchor.constraint(equalTo: centerButton.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: centerButton.bottomAnchor).isActive = true
        centerBox.leadingAnchor.constraint(equalTo: centerButton.leadingAnchor).isActive = true
        centerBox.trailingAnchor.constraint(equalTo: centerButton.trailingAnchor).isActive = true
        
        centerButton.isHidden = true
    }
    
    override open func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "center_controller" {
            self.centerViewController = (segue.destinationController as! NSViewController)
        }
        else if segue.identifier == "left_controller" {
            self.leftViewController = (segue.destinationController  as! NSViewController)
        }
        else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    open func open(animated:Bool) {
        self.isOpen = true
        
        if animated {
            NSAnimationContext.runAnimationGroup({[unowned self] (context) in
                context.duration = 0.25
                self.leadingNavigationConstraint?.animator().constant = self.openDrawerWidth
                self.trailingNavigationConstraint?.animator().constant = self.openDrawerWidth
            }, completionHandler: nil)
        }
        else {
            self.leadingNavigationConstraint?.constant = self.openDrawerWidth
            self.trailingNavigationConstraint?.constant = self.openDrawerWidth
        }
        
    }
    
    open func close(animated:Bool) {
        self.isOpen = false
        
        if animated {
            NSAnimationContext.runAnimationGroup({[unowned self] (context) in
                context.duration = 0.25
                self.leadingNavigationConstraint?.animator().constant = 0
                self.trailingNavigationConstraint?.animator().constant = 0
            }, completionHandler: nil)
        }
        else {
            self.leadingNavigationConstraint?.constant = 0
            self.trailingNavigationConstraint?.constant = 0
        }
        
    }
    
    open func closeAnimated() {
        self.close(animated: true)
        
    }
    
}
