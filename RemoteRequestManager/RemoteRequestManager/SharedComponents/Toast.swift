import Foundation
import UIKit

class Toast {
    
    static func show(
        message: String,
        color: UIColor = UIColor.black.withAlphaComponent(0.8),
        duration: TimeInterval = 1.5,
        completion: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            guard let rootViewController = SharedMethods.shared.getWindowRootViewController()
            else { return }
            guard let topController = SharedMethods.shared.getTopViewController(from: rootViewController)
            else { return }
            let controller = topController
            let toastContainer = UIView(frame: CGRect())
            toastContainer.backgroundColor =  color
            toastContainer.alpha = 0.0
            toastContainer.layer.cornerRadius = 25;
            toastContainer.clipsToBounds  =  true
            let toastLabel = UILabel(frame: CGRect())
            toastLabel.font = UIFont(name: "Poppins-SemiBold", size: 16.0)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font.withSize(12.0)
            toastLabel.text = message
            toastLabel.clipsToBounds  =  true
            toastLabel.numberOfLines = 0
            toastContainer.addSubview(toastLabel)
            controller.view.addSubview(toastContainer)
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            toastContainer.translatesAutoresizingMaskIntoConstraints = false
            
            let a1 = NSLayoutConstraint(item: toastLabel,
                                        attribute: .leading,
                                        relatedBy: .equal,
                                        toItem: toastContainer,
                                        attribute: .leading,
                                        multiplier: 1,
                                        constant: 15)
            
            let a2 = NSLayoutConstraint(item: toastLabel,
                                        attribute: .trailing,
                                        relatedBy: .equal,
                                        toItem: toastContainer,
                                        attribute: .trailing,
                                        multiplier: 1,
                                        constant: -15)
            
            let a3 = NSLayoutConstraint(item: toastLabel,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: toastContainer,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: -15)
            
            let a4 = NSLayoutConstraint(item: toastLabel,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: toastContainer,
                                        attribute: .top,
                                        multiplier: 1,
                                        constant: 15)
            
            toastContainer.addConstraints([a1, a2, a3, a4])
            
            let c1 = NSLayoutConstraint(item: toastContainer,
                                        attribute: .leading,
                                        relatedBy: .equal,
                                        toItem: controller.view,
                                        attribute: .leading,
                                        multiplier: 1, constant: 65)
            
            let c2 = NSLayoutConstraint(item: toastContainer,
                                        attribute: .trailing,
                                        relatedBy: .equal,
                                        toItem: controller.view,
                                        attribute: .trailing,
                                        multiplier: 1,
                                        constant: -65)
            
            if KeyboardStateListener.shared.isVisible {
                let c3 = NSLayoutConstraint(item: toastContainer,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: controller.view,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: -(35 + KeyboardStateListener.shared.keyboardheight))
                
                controller.view.addConstraints([c1, c2, c3])
            }else {
                let c3 = NSLayoutConstraint(item: toastContainer,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: controller.view,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: -75)
                
                controller.view.addConstraints([c1, c2, c3])
            }
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: .curveEaseIn,
                           animations: {
                toastContainer.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.5,
                               delay: duration,
                               options: .curveEaseOut,
                               animations: {
                    toastContainer.alpha = 0.0
                }, completion: {_ in
                    toastContainer.removeFromSuperview()
                    completion?() // Call completion handler after toast is dismissed
                })
            })
        }
    }
}
