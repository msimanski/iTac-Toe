//
//  ViewController.swift
//  iTac-Toe
//
//  Created by Michael Simanski on 4/10/18.
//  Copyright © 2018 Michael Simanski. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    let locMan: CLLocationManager = CLLocationManager() //Location stuff
    
    let UKLatitude: CLLocationDegrees = 51.5074
    let UKLongitude: CLLocationDegrees = 0.1278
    
    var currentBoard = [[Int]](repeating: [Int](repeating: 0, count: 3), count: 3) //This is the master array that controls the state of the game. 0 represents an open spot ("_"), 1 represents X, 2 represents O. X is controlled by the player, O is controlled by the computer.
    
    struct gameMove
    { //Structure to represent a move in the game.
        var row: Int
        var col: Int
    }
    
    func anyMovesLeft(board: [[Int]]) -> Bool
    { //Function that returns true if a blank spot is on the current board.
        
        for i in 0...2
        {
            for j in 0...2
            {
                if board[i][j] == 0
                {
                    return true //The algorithm found a blank spot.
                }
            }
        }
        
        return false //The algorithm failed to find a blank spot.
        
    }
    
    func scoreBoard(board: [[Int]]) -> Int
    { //Function that scores the board. 0 is given for a draw, 1 for the player (X) winning, -1 for the computer (O) winning.
        
        for row in 0...2 //Traverse the rows.
        {
            
            if ((board[row][0] == board[row][1]) && (board[row][1] == board[row][2])) //Inspect rows for a winning position.
            {
                
                if (board[row][0] == 1)
                {
                    return 1
                }
                else if (board[row][0] == 2)
                {
                    return -1
                }
                
            }
            
        }
        
        for col in 0...2 //Inspect cols for a winning position.
        {
            
            if ((board[0][col] == board[1][col]) && (board[1][col] == board[2][col])) //Inspect rows for a winning position.
            {
                
                if (board[0][col] == 1)
                {
                    return 1
                }
                else if (board[0][col] == 2)
                {
                    return -1
                }
                
            }
            
        }
        
        if ((board[0][0] == board[1][1]) && (board[1][1] == board[2][2])) //We're taking this baby sideways! Inspect diagonals for a wiinging position.
        {
            
            if (board[0][0] == 1)
            {
                return 1
            }
            else if (board[0][0] == 2)
            {
                return -1
            }
            
        }
        
        if ((board[0][2] == board[1][1]) && (board[1][1] == board[2][0])) //Does the above for the other direction.
        {
            
            if (board[0][2] == 1)
            {
                return 1
            }
            else if (board[0][2] == 2)
            {
                return -1
            }
            
        }
        
        return 0 //If the function gets to this point the current board is a draw.
        
    }
    
    func miniMax(board: [[Int]], depth: Int, isMax: Bool) -> Int
    { //This is the algorithm that powers the AI. The method it uses is called Mini-Max and it has been in use since the 40s. It works very well for determinate games like Tic-Tac-Toe. At one point I knew exactly how it worked, but I have a headache and I don't want to think about it right now.
        
        var board = board //I had to do this for some reason. Why do they have to complicate things?
        
        var score: Int = scoreBoard(board: board) //Obtains the score of the current board.
        
        if score == 1 //Check to see if the player won.
        {
            return score
        }
        if score == -1 //Check to see if the computer won.
        {
            return score
        }
        if anyMovesLeft(board: board) == false //Check to see if it is a draw.
        {
            return 0
        }
        
        if isMax == true //Proceed assuming it is the player turn.
        {
            
            var best: Int = -1000
            
            for i in 0...2
            {
                for j in 0...2
                {
                    
                    if board[i][j] == 0
                    {
                        
                        board[i][j] = 1 //Perform the move.
                        best = max(best, miniMax(board: board, depth: depth + 1, isMax: !(isMax))) //See if the move is any good. This starts to build the tree.
                        board[i][j] = 0 //Reset the cell.
                        
                    }
                    
                }
            }
            
            return best //Send it back!
            
        }
        
        else //Minimax assuming CPU turn.
        {
            
            var best: Int = 1000
            
            for i in 0...2
            {
                for j in 0...2
                {
                    
                    if board[i][j] == 0
                    {
                        
                        board[i][j] = 2 //Perform the move.
                        best = max(best, miniMax(board: board, depth: depth + 1, isMax: !(isMax))) //See if the move is any good. This starts to build the tree.
                        board[i][j] = 0 //Reset the cell.
                        
                    }
                    
                }
            }
            
            return best //Send it back!
            
        }
        
    } //I got a massive headache typing this one out.
    
    func findBestMove(board: [[Int]]) -> gameMove
    { //Implementation of minimax that finds the best move for given CPU board.
        
        var board = board
        
        var bestVal = -1000
        var bestMove: gameMove = gameMove(row: -1, col: -1)
        
        for i in 0...2 //Traverse the cells.
        {
            for j in 0...2
            {
                
                if board[i][j] == 0
                {
                    
                    board[i][j] = 1 //Do the move.
                    var moveVal: Int = miniMax(board: board, depth: 0, isMax: false) //Get the heuristic.
                    board[i][j] = 0 //Reset the board.
                    
                    if moveVal > bestVal //See if this is best for the CPU based on the heuristic obtained above.
                    {
                        bestMove.row = i
                        bestMove.col = j
                        bestVal = moveVal
                    }
                    
                }
                
            }
        }
        
        return bestMove //Send 'er back!
        
    }
    
    @IBAction func btn1Click(_ sender: Any)
    {
        currentBoard[0][0] = 1
        gameTurn()
    }
    @IBAction func btn2Click(_ sender: Any)
    {
        currentBoard[1][0] = 1
        gameTurn()
    }
    @IBAction func btn3Click(_ sender: Any)
    {
        currentBoard[2][0] = 1
        gameTurn()
    }
    @IBAction func btn4Click(_ sender: Any)
    {
        currentBoard[0][1] = 1
        gameTurn()
    }
    @IBAction func btn5Click(_ sender: Any)
    {
        currentBoard[1][1] = 1
        gameTurn()
    }
    @IBAction func btn6Click(_ sender: Any)
    {
        currentBoard[2][1] = 1
        gameTurn()
    }
    @IBAction func btn7Click(_ sender: Any)
    {
        currentBoard[0][2] = 1
        gameTurn()
    }
    @IBAction func btn8Click(_ sender: Any)
    {
        currentBoard[1][2] = 1
        gameTurn()
    }
    @IBAction func btn9Click(_ sender: Any)
    {
        currentBoard[2][2] = 1
        gameTurn()
    }
    
    func gameTurn() -> Void
    { //Does a turn of the game. Essentially just a driver for the other functions.
        
        if scoreBoard(board: currentBoard) == 0
        {
            
            changeLetters()
            var aimove: gameMove = findBestMove(board: currentBoard) //Get best move for CPU.
            var x: Int
            var y: Int
            x = aimove.row
            y = aimove.col
            currentBoard[x][y] = 2 //Set it in board array.
            changeLetters()
            
        }
        
        if scoreBoard(board: currentBoard) == 1 //If you won.
        {
            let alert = UIAlertController(title: "You Won!", message: "A winner is you!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("Player won game.")
            }))
            self.present(alert, animated: true, completion: nil)
            resetGame()
        }
        if scoreBoard(board: currentBoard) == -1 //If you lost.
        {
            let alert = UIAlertController(title: "You lost!", message: "You bring dishonor to famiry!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("CPU won game.")
            }))
            self.present(alert, animated: true, completion: nil)
            resetGame()
        }
        if anyMovesLeft(board: currentBoard) == false //If you draw.
        {
            let alert = UIAlertController(title: "Draw!", message: "Do you feel lucky punk?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("Draw occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            resetGame()
        }
        
    }
    
    func changeLetters() -> Void
    { //Function that changes the lettering for the game buttons.
        
        if currentBoard[0][0] == 2
        {
            btn1.setTitle("O", for: .normal)
            btn1.setTitleColor(UIColor.red, for: .normal)
            btn1.isEnabled = false
            
        }
        if currentBoard[1][0] == 2
        {
            btn2.setTitle("O", for: .normal)
            btn2.setTitleColor(UIColor.red, for: .normal)
            btn2.isEnabled = false
        }
        if currentBoard[2][0] == 2
        {
            btn3.setTitle("O", for: .normal)
            btn3.setTitleColor(UIColor.red, for: .normal)
            btn3.isEnabled = false
        }
        if currentBoard[0][1] == 2
        {
            btn4.setTitle("O", for: .normal)
            btn4.setTitleColor(UIColor.red, for: .normal)
            btn4.isEnabled = false
        }
        if currentBoard[1][1] == 2
        {
            btn5.setTitle("O", for: .normal)
            btn5.setTitleColor(UIColor.red, for: .normal)
            btn5.isEnabled = false
        }
        if currentBoard[2][1] == 2
        {
            btn6.setTitle("O", for: .normal)
            btn6.setTitleColor(UIColor.red, for: .normal)
            btn6.isEnabled = false
        }
        if currentBoard[0][2] == 2
        {
            btn7.setTitle("O", for: .normal)
            btn7.setTitleColor(UIColor.red, for: .normal)
            btn7.isEnabled = false
        }
        if currentBoard[1][2] == 2
        {
            btn8.setTitle("O", for: .normal)
            btn8.setTitleColor(UIColor.red, for: .normal)
            btn8.isEnabled = false
        }
        if currentBoard[2][2] == 2
        {
            btn9.setTitle("O", for: .normal)
            btn9.setTitleColor(UIColor.red, for: .normal)
            btn9.isEnabled = false
        }
        if currentBoard[0][0] == 1
        {
            btn1.setTitle("X", for: .normal)
            btn1.setTitleColor(UIColor.red, for: .normal)
            btn1.isEnabled = false
        }
        if currentBoard[1][0] == 1
        {
            btn2.setTitle("X", for: .normal)
            btn2.setTitleColor(UIColor.red, for: .normal)
            btn2.isEnabled = false
        }
        if currentBoard[2][0] == 1
        {
            btn3.setTitle("X", for: .normal)
            btn3.setTitleColor(UIColor.red, for: .normal)
            btn3.isEnabled = false
        }
        if currentBoard[0][1] == 1
        {
            btn4.setTitle("X", for: .normal)
            btn4.setTitleColor(UIColor.red, for: .normal)
            btn4.isEnabled = false
        }
        if currentBoard[1][1] == 1
        {
            btn5.setTitle("X", for: .normal)
            btn5.setTitleColor(UIColor.red, for: .normal)
            btn5.isEnabled = false
        }
        if currentBoard[2][1] == 1
        {
            btn6.setTitle("X", for: .normal)
            btn6.setTitleColor(UIColor.red, for: .normal)
            btn6.isEnabled = false
        }
        if currentBoard[0][2] == 1
        {
            btn7.setTitle("X", for: .normal)
            btn7.setTitleColor(UIColor.red, for: .normal)
            btn7.isEnabled = false
        }
        if currentBoard[1][2] == 1
        {
            btn8.setTitle("X", for: .normal)
            btn8.setTitleColor(UIColor.red, for: .normal)
            btn8.isEnabled = false
        }
        if currentBoard[2][2] == 1
        {
            btn9.setTitle("X", for: .normal)
            btn9.setTitleColor(UIColor.red, for: .normal)
            btn9.isEnabled = false
        }
        if currentBoard[0][0] == 0
        {
            btn1.setTitle(" ", for: .normal)
            btn1.isEnabled = true
        }
        if currentBoard[1][0] == 0
        {
            btn2.setTitle(" ", for: .normal)
            btn2.isEnabled = true
        }
        if currentBoard[2][0] == 0
        {
            btn3.setTitle(" ", for: .normal)
            btn3.isEnabled = true
        }
        if currentBoard[0][1] == 0
        {
            btn4.setTitle(" ", for: .normal)
            btn4.isEnabled = true
        }
        if currentBoard[1][1] == 0
        {
            btn5.setTitle(" ", for: .normal)
            btn5.isEnabled = true
        }
        if currentBoard[2][1] == 0
        {
            btn6.setTitle(" ", for: .normal)
            btn6.isEnabled = true
        }
        if currentBoard[0][2] == 0
        {
            btn7.setTitle(" ", for: .normal)
            btn7.isEnabled = true
        }
        if currentBoard[1][2] == 0
        {
            btn8.setTitle(" ", for: .normal)
            btn8.isEnabled = true
        }
        if currentBoard[2][2] == 0
        {
            btn9.setTitle(" ", for: .normal)
            btn9.isEnabled = true
        }
        
        
    }
    
    func resetGame() -> Void
    { //Function that resets the game.
        
        for i in 0...2
        {
            for j in 0...2
            {
                currentBoard[i][j] = 0 //Make all cells empty.
            }
        }
        
        var x: Int //Place an O at a random place on the board.
        var y: Int
        x = Int(arc4random_uniform(2))
        y = Int(arc4random_uniform(2))
        currentBoard[x][y] = 2
        
        changeLetters() //Refresh screen.
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    { //Funtion to capture the shaking event and activate easter egg.
        if motion==UIEventSubtype.motionShake
        {
            
            btn1.setTitleColor(UIColor.red, for: .normal)
            btn2.setTitleColor(UIColor.orange, for: .normal)
            btn3.setTitleColor(UIColor.yellow, for: .normal)
            btn4.setTitleColor(UIColor.green, for: .normal)
            btn5.setTitleColor(UIColor.blue, for: .normal)
            btn6.setTitleColor(UIColor.purple, for: .normal)
            btn7.setTitleColor(UIColor.black, for: .normal)
            btn8.setTitleColor(UIColor.brown, for: .normal)
            btn9.setTitleColor(UIColor.white, for: .normal)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    { //Function that runs the location manager for the UK easter egg
        let newLocation: CLLocation=locations[0]
        NSLog("Location Manager is Active")
        if newLocation.horizontalAccuracy >= 0
        {
            let shu:CLLocation = CLLocation(latitude: UKLatitude,longitude: UKLongitude)
            let delta:CLLocationDistance = shu.distance(from: newLocation)
            let miles: Double = (delta * 0.000621371) + 0.5 // meters to rounded miles
            if miles < 100
            {
                // Stop updating the location
                locMan.stopUpdatingLocation()
                // Congratulate the user
                NSLog("GOD SAVE THE QUEEN!") //CHEERIO, PIP-PIP, TEA AND CRUMPETS, RAIN EVERY DAY
                titleLabel.text = "iNots-n-Crosses"
                titleLabel.adjustsFontSizeToFitWidth = true
            }
            //waitView.isHidden = true
            //distanceView.isHidden = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var x: Int //Place an O at a random place on the board.
        var y: Int
        x = Int(arc4random_uniform(3))
        y = Int(arc4random_uniform(3))
        currentBoard[x][y] = 2
        
        changeLetters() //Refresh screen.
        
        locMan.delegate = self //Stuff for the location manager
        locMan.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locMan.distanceFilter = 1609; // a mile
        locMan.requestWhenInUseAuthorization()
        locMan.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

