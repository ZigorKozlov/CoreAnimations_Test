//
//  ViewController.swift
//  CATest
//
//  Created by Игорь Козлов on 21.03.2021.
//

import UIKit

class ViewController: UIViewController {

    var viewToAnimate: UIView!
    
    lazy var myButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Animate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewToAnimate = createViewToAnimate(frame: CGRect(x: 75, y: 75, width: 75, height: 75), color: .red)
        view.backgroundColor = .white
        
        confugurateAnimateButton()
    }


}

//MARK: - Constraints
extension ViewController {
    private func setButtonConstraints() {
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    private func confugurateAnimateButton() {
        view.addSubview(myButton)
        self.setButtonConstraints()
        myButton.addTarget(self, action: #selector(animateButtonPressed(sender:)), for: .touchUpInside)
    }
}

//MARK: - Selectors
extension ViewController {
    @objc private func animateButtonPressed(sender: UIButton) {
        if sender === myButton {
            startAnimate()
        }
    }
}

//MARK: - AnimateFunc-s
extension ViewController {
    
    private func startAnimate() {
        
        //let duratuin = 3.0
        let scaleXDuration = 1.0
        let scaleYDuration = 0.5
        let conerRadiusDuration = 5.0
        let rotationDuration = 1.5
        
        let startPoint = viewToAnimate.center // АНИМАЦИЯ ОБЪЕКТА ИДËТ ОТ ЕГО ЦЕНТРА!!!!
        //let endPoint = CGPoint(x: 300, y: 800)
        
        //let positionAnimation = createPositionAnimation(startPoint, endPoint, duratuin)
        //viewToAnimate.layer.add(positionAnimation, forKey: "position")
        //viewToAnimate.layer.position = endPoint //For anchor new center point
        
        let scaleXAnimation = createScaleXAnimation(duration: scaleXDuration)
        viewToAnimate.layer.add(scaleXAnimation, forKey: "transform.scale.x")
        
        let scaleYAnimation = createScaleYAnimation(duration: scaleYDuration)
        viewToAnimate.layer.add(scaleYAnimation, forKey: "transform.scale.y")
    
        let cornerRadiusAnimation = createCornerRadiusAnimation(duration: conerRadiusDuration)
        viewToAnimate.layer.add(cornerRadiusAnimation, forKey: "cornerRadius")
        
        let rotationAnimation = createRotationAnimation(duration: rotationDuration)
        viewToAnimate.layer.add(rotationAnimation, forKey: "transform.rotation")
        
        let opacityAnimation = createOpacityAnimation(duration: 2.0)
        viewToAnimate.layer.add(opacityAnimation, forKey: "opacity")
        
        let colorAnimation = createColorAnimation()
        viewToAnimate.layer.add(colorAnimation, forKey: "backgroundColor")
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addCurve(to: startPoint, controlPoint1: CGPoint(x: startPoint.x + 400, y: startPoint.y + 700), controlPoint2: CGPoint(x: startPoint.x - 200, y: startPoint.y + 600))
        
        let animationForCurve = positionAnimationByCureve(path: path, duraion: 4.0)
        viewToAnimate.layer.add(animationForCurve, forKey: "position")
    }
    private func positionAnimationByCureve(path: UIBezierPath, duraion: Double) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        //animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunctions = [CAMediaTimingFunction(name: .easeIn)]
        animation.duration = duraion
        
        return animation
    }
    
    private func createColorAnimation() -> CAKeyframeAnimation {
        let colorAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorAnimation.values = [
            UIColor.green.cgColor,
            UIColor.purple.cgColor,
            UIColor.blue.cgColor,
            UIColor.orange.cgColor,
            UIColor.red.cgColor
        ]
        colorAnimation.keyTimes = [ // Делим всё время duration между состояниями [0, 0.172, ...
            0.0,
            0.25,
            0.5,
            0.7,
            0.9
        ]
        colorAnimation.autoreverses = true
        colorAnimation.duration = 10
        colorAnimation.repeatCount = .infinity
        colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        return colorAnimation
    }
    private func createOpacityAnimation(duration: Double = 1.0) -> CABasicAnimation {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.5
        opacityAnimation.repeatCount = .infinity
        opacityAnimation.autoreverses = true
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        opacityAnimation.duration = duration
        
        return opacityAnimation
    }
    private func createRotationAnimation(duration: Double) -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        return rotationAnimation
    }
    
    private func createCornerRadiusAnimation(duration: Double) -> CABasicAnimation{
        let cornerRadionsAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadionsAnimation.fromValue = 0
        cornerRadionsAnimation.toValue = 20
        cornerRadionsAnimation.duration = duration
        cornerRadionsAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        cornerRadionsAnimation.autoreverses = true
        cornerRadionsAnimation.repeatCount = .infinity
        
        return cornerRadionsAnimation
    }
    fileprivate func createScaleYAnimation(duration: CFTimeInterval) -> CABasicAnimation {
        let scaleYAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        scaleYAnimation.fromValue = 1.0
        scaleYAnimation.toValue = 0.5
        scaleYAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        scaleYAnimation.autoreverses = true
        scaleYAnimation.repeatCount = .infinity
        
        scaleYAnimation.duration = duration
        
        return scaleYAnimation
    }
    fileprivate func createScaleXAnimation(duration: CFTimeInterval) -> CABasicAnimation {
        let scaleXAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        scaleXAnimation.fromValue = 1.0
        scaleXAnimation.toValue = 0.5
        scaleXAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        scaleXAnimation.autoreverses = true
        scaleXAnimation.repeatCount = .infinity
        
        scaleXAnimation.duration = duration
        
        return scaleXAnimation
    }
    
    private func createPositionAnimation(_ startPoint: CGPoint, _ endPoint: CGPoint, _ duratuin: Double) -> CABasicAnimation {
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = NSValue(cgPoint: startPoint)
        positionAnimation.toValue = NSValue(cgPoint: endPoint)
        positionAnimation.duration = duratuin
        positionAnimation.autoreverses = true //Афтовозрат
        positionAnimation.repeatCount = .infinity //Повтор бесконечно
        positionAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        return positionAnimation
    }
    
    private func createViewToAnimate(frame: CGRect, color: UIColor) -> UIView {
        let viewToAnimate = UIView(frame: frame)
        viewToAnimate.backgroundColor = color
        view.addSubview(viewToAnimate)
        
        return viewToAnimate
    }
}
