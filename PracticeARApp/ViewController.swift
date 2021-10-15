//
//  ViewController.swift
//  PracticeARApp
//
//  Created by Harsha Karanth on 9/27/21.
//

import UIKit
import RealityKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cancellable: AnyCancellable? = nil;
        let sphereAnchor = AnchorEntity(world: SIMD3(x:0, y:0, z:-50));
        cancellable = ModelEntity.loadModelAsync(named: "toy_biplane", in:nil).collect().sink(receiveCompletion: {error in print("Error: \(error)")
            cancellable?.cancel()
        }, receiveValue: { entities in
            //var object : ModelEntity = entity
            for entity in entities {
                entity.setScale(SIMD3<Float>(0.75,0.75,0.75), relativeTo: sphereAnchor)
                entity.generateCollisionShapes(recursive: true)
                sphereAnchor.addChild(entity);
            }
            
        });
        
        arView.scene.addAnchor(sphereAnchor);
    }
}
