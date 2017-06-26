//
//  GameScene.swift
//  Game Of Life
//
//  Created by Saken Sydykov on 23.06.17.
//  Copyright © 2017 Strixit. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // UI Objects
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    var stepButton: MSButtonNode!
    var populationNumberLabel: SKLabelNode!
    var generationNumberLabel: SKLabelNode!
    var gridNode: Grid!
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        // Connect ui objects with scene
        playButton = childNode(withName: "playButton") as! MSButtonNode
        pauseButton = childNode(withName: "pauseButton") as! MSButtonNode
        stepButton = childNode(withName: "stepButton") as! MSButtonNode
        populationNumberLabel = childNode(withName: "populationNumberLabel") as! SKLabelNode
        generationNumberLabel = childNode(withName: "generationNumberLabel") as! SKLabelNode
        gridNode = childNode(withName: "gridNode") as! Grid
        
        // Step button clicked
        stepButton.selectedHandler = {
            
            self.stepSimulation()
        }
        
        // Play button clicked
        playButton.selectedHandler = {
            
            self.isPaused = false
        }
        
        // Pause button clicked
        pauseButton.selectedHandler = {
            
            self.isPaused = true
        }
        
        /* Create an SKAction based timer, 0.5 second delay */
        let delay = SKAction.wait(forDuration: 0.5)
        
        /* Call the stepSimulation() method to advance the simulation */
        let callMethod = SKAction.perform(#selector(stepSimulation), onTarget: self)
        
        /* Create the delay,step cycle */
        let stepSequence = SKAction.sequence([delay,callMethod])
        
        /* Create an infinite simulation loop */
        // let simulation = SKAction.repeatActionForever(stepSequence)
        let simulation = SKAction.repeatForever(stepSequence)
        
        /* Run simulation action */
        self.run(simulation)
        
        /* Default simulation to pause state */
        self.isPaused = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }

    func stepSimulation(){
        
        // Start next step of simulation
        gridNode.evolve()
        
        // Updating label 
        populationNumberLabel.text = String(gridNode.population)
        generationNumberLabel.text = String(gridNode.generation)
    }
}
