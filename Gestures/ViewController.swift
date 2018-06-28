import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addDoubleTapGestureRecognizer()
    }

    func addDoubleTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGestureRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func didTapView(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: view)
        let circleView = addCircleView(in: location)

        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchView))
        circleView.addGestureRecognizer(pinchGestureRecognizer)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanView))
        circleView.addGestureRecognizer(panGestureRecognizer)
    }

    func addCircleView(in location: CGPoint) -> UIView {
        let circleView = UIView()
        let colors = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
        circleView.backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))].withAlphaComponent(0.8)
        let size: CGFloat = 200
        circleView.frame = CGRect(x: location.x, y: location.y, width: size, height: size).offsetBy(dx: -size/2, dy: -size/2)
        circleView.layer.cornerRadius = size / 2
        view.addSubview(circleView)
        return circleView
    }

@objc func didPinchView(gestureRecognizer: UIPinchGestureRecognizer) {
    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
        guard let transform = gestureRecognizer.view?.transform else { return }
        let scale = gestureRecognizer.scale
        gestureRecognizer.view?.transform = transform.scaledBy(x: scale, y: scale)
        gestureRecognizer.scale = 1.0
    }
}

@objc func didPanView(sender: UIPanGestureRecognizer) {
    let viewToMove = sender.view!
    view.bringSubview(toFront: viewToMove)
    let translation = sender.translation(in: view)
    let newCenter = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)
    viewToMove.center = newCenter
    sender.setTranslation(CGPoint.zero, in: view)
}
}
