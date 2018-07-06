//
//  ScanViewController.swift
//  QRReader
//
//  Created by hiraya.shingo on 2018/07/06.
//  Copyright © 2018 shingo hiraya. All rights reserved.
//

import UIKit
import ZXingObjC
import SafariServices

class ScanViewController: UIViewController {

    private let capture = ZXCapture()
    private var captured = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capture.delegate = self
        capture.camera = capture.back()
        capture.layer.frame = view.bounds
        view.layer.addSublayer(capture.layer)
        capture.start()
    }
    
    @IBAction func closeButtonTap(_ sender: Any) {
        capture.layer.removeFromSuperlayer()
        dismiss(animated: true)
    }
}

extension ScanViewController: ZXCaptureDelegate {
    
    func captureResult(_ capture: ZXCapture!, result: ZXResult!) {
        guard !captured else { return }
        captured = true
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        capture.stop()
        guard let urlString = result.text, let url = URL(string: urlString) else { return }
        present(SFSafariViewController(url: url), animated: true)
    }
    
    func captureCameraIsReady(_ capture: ZXCapture!) {
        print(#function)
    }
}
