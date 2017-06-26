import SpriteKit

class Grid: SKSpriteNode{

    // Grid array dimensions:
    let rows = 8
    let columns = 10
    
    // Individual cell dimensions, calculated in setup
    var cellWidth = 0
    var cellHeight = 0
    
    // Generation and Population
    var generation = 0
    var population = 0
    
    var gridArray = [[Creature]]()

    // Called when touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // There will only be one touch as multi touch is not enabled by default
        let touch = touches.first!
        let location = touch.location(in: self)
    
        // Calculate grid array position
        let gridX = Int (location.x) / cellWidth
        let gridY = Int (location.y) / cellHeight
        
        let creature = gridArray[gridX][gridY]
        creature.isAlive = !creature.isAlive
    }
    
    // For subclass working
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /* Enable own touch implementation for this node */
        isUserInteractionEnabled = true
        
        /* Calculate individual cell dimensions */
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
     
        populateGrid()
    }
    
    func addCreatureAtGrid(x: Int, y: Int) {
        
        // New Creature object
        let creature = Creature()
        
        // Calculate position on screen
        let gridPosition = CGPoint(x: x * cellWidth, y: y * cellHeight)
        creature.position = gridPosition
        
        // Set default isAlive as false
        creature.isAlive = false
        
        // Add creature to grid node
        addChild(creature)
        
        // Add creature to grid array
        gridArray[x].append(creature)

    }
    
    func populateGrid(){
    
        // Loop trough collumns
        for gridX in 0..<columns {
            
            //Initialize empty column
            gridArray.append([])
            
            // Loop through rows
            for gridY in 0..<rows{
                
                // Create new creature at coolumn/rows position
                addCreatureAtGrid(x: gridX, y: gridY)
            }
        }
    }
    
    func countNeighbors(){
        
        for gridX in 0..<columns {
            
            for gridY in 0..<rows {
                
                // Create current creature and set count of neighbore to 0
                let currentCreature = gridArray[gridX][gridY]
                currentCreature.neighborCount = 0
                
                for innerGridX in (gridX - 1)...(gridX + 1){
                    
                    // Ensure inner grid is in the grid
                    if innerGridX < 0 || innerGridX >= columns { continue }
                    
                    for innerGridY in (gridY - 1)...(gridY + 1){
                        
                        // Ensure inner grid Y is in the grid
                        if innerGridY < 0 || innerGridY >= rows { continue }
                        
                        // Creature can't count itself
                        if innerGridY == gridY && innerGridX == gridX { continue }
                        
                        let adjacentCreature: Creature = gridArray[innerGridX][innerGridY]
                        
                        if adjacentCreature.isAlive{
                            currentCreature.neighborCount += 1
                        }
                    }
                }
            }
        }
    }
    
    func updateCreatures(){
        
        population = 0
        
        for gridX in 0..<columns{
            for gridY in 0..<rows{
                
                let currentCreature = gridArray[gridX][gridY]
                
                switch currentCreature.neighborCount {
                case 3:
                    currentCreature.isAlive = true
                    break;
                case 0...1, 4...8:
                    currentCreature.isAlive = false
                    break;
                default:
                    break;
                }
                
                if currentCreature.isAlive{
                    population += 1
                }
            }
        }
    }
    
    func evolve(){
    
        countNeighbors()
        
        updateCreatures()
        
        generation += 1
    }
}













