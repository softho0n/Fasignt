//
//  FirstViewController.swift
//  sign
//
//  Created by Jason on 2022/02/21.
//

import UIKit

class Line {
    var startPoint:CGPoint
    var endPoint:CGPoint
    
    init (start:CGPoint , end:CGPoint) {
        startPoint = start
        endPoint = end
    }
}

class FirstViewController: UIViewController {
    @IBOutlet weak var drawBoard: UIImageView!
    var lines :[Line] = []
    var lastPoint:CGPoint!
    let drawingLayer = CAShapeLayer()
    let shapeLayer:CAShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor.gray.cgColor
        let frameSize = self.drawBoard.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
            shapeLayer.bounds = shapeRect
            shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = color
            shapeLayer.lineWidth = 2
            shapeLayer.lineJoin = CAShapeLayerLineJoin.round
            shapeLayer.lineDashPattern = [6,3]
            shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 4).cgPath
        
        drawBoard.layer.addSublayer(shapeLayer)
        drawBoard.layer.addSublayer(drawingLayer)
    }
    
    func removeSignFromBoard() {
        drawingLayer.removeFromSuperlayer()
        drawingLayer.path = nil
        lines.removeAll()
        drawBoard.layer.addSublayer(drawingLayer)
    }
    
    @IBAction func reset(_ sender: Any) {
        removeSignFromBoard()
    }
    
    @IBAction func save(_ sender: Any) {
        shapeLayer.removeFromSuperlayer()
        
        let image: UIImage!
        UIGraphicsBeginImageContext(drawBoard.frame.size)
        drawBoard.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        let alert = UIAlertController(title: "알림", message: "저장되었습니다!", preferredStyle: UIAlertController.Style.alert)
        let defaultAction =  UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        alert.addAction(defaultAction)
        self.present(alert, animated: false)
        
        removeSignFromBoard()
        drawBoard.layer.addSublayer(shapeLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first?.location(in: self.drawBoard)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch  = touches.first
        {
            let newPoint = touch.location(in:self.drawBoard)
            lines.append(Line(start: lastPoint, end: newPoint))
            lastPoint = newPoint
            updateDrawingOverlay()
        }
    }
    
    func updateDrawingOverlay() {
        let path = CGMutablePath()

        for line in lines {
            path.move(to: line.startPoint)
            path.addLine(to: line.endPoint)
        }

        drawingLayer.frame = self.drawBoard.frame
        drawingLayer.path = path
        drawingLayer.lineWidth = 5
        drawingLayer.strokeColor = UIColor.black.cgColor
    }
}
