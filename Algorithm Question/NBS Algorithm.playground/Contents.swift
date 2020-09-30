
import UIKit


// MARK: - VALID STRING

func isValidString(_ string: String) -> Bool{
    
    var trim = ""
    var dict = [Character: Int]()
    var twoNumber = 0
    var threeNumber = 0
    
    //trimming
    trim = string.filter {!" ".contains($0)}
    
    // reduce each character return a dict
    dict = trim.reduce(into: [:]) { counts, letter in
        counts[letter, default: 0] += 1
    }
    
    let valueOnly = dict.map { (key, value) -> Int in
        return value
    }
    
    
    for i in valueOnly{
        switch i {
        case 2:
            twoNumber += 1
        case 3:
            threeNumber += 1
        default:
            return false
        }
    }
    
    if threeNumber > 1{
        return false
    }
    
    
    return true
    
}



print(isValidString("aabbccddeefghi"))
print(isValidString("abcdefghhgfedecba"))
print(isValidString("a bb c dd e a e d cc"))







// MARK: - KOTAK AJAIB

func makeMagicSquaere(_ matrix: [[Int]]) {
    
    //validate matrix
    guard matrix.count == 3 else {fatalError("You should enter only 3 arrays")}
    
    //local properties
    var highestSum: Int = 0
    var firtDiagonal: Int = 0
    var secondDiagonal: Int = 0
    
    
    // calculate the highest number
    
    //rows
    matrix.forEach { (array) in
        let sum = array.reduce(0, +)
        highestSum = sum > highestSum ? sum : highestSum
    }
    
    //coloums
    for i in 0...2{
        var sum = 0
        matrix.forEach { (array) in
            sum += array[i]
        }
        highestSum = sum > highestSum ? sum : highestSum
    }
    
    
    //diagonals
    for i in 0...matrix.count - 1{
        for j in 0...matrix.count - 1{
            
            if i == j{
                firtDiagonal += matrix[i][j]
            }
            
            if i == matrix.count - 1 - j {
                secondDiagonal += matrix[i][j]
            }
            
        }
    }
    
    highestSum = firtDiagonal > highestSum ? firtDiagonal : highestSum
    highestSum = secondDiagonal > highestSum ? secondDiagonal : highestSum
    
    //validate hightest sum
    guard highestSum <= 9 * 3, highestSum >= 3 else {fatalError("highest sum must be in range of 3 and 27")}
    
    
    // create new matrix
    let thirdSum = highestSum / 3
    let modSum = highestSum % 3
    let newMatrix = [
        [thirdSum + (modSum / 2) + (modSum % 2), thirdSum + modSum, thirdSum - (modSum / 2)],
        [thirdSum, thirdSum, thirdSum + modSum],
        [thirdSum + (modSum / 2) + (modSum % 2), thirdSum, thirdSum + (modSum / 2)]
    ]
    
    print("NEW MATRIX : \(newMatrix)" )
    
}

makeMagicSquaere([
    [3,1,4],
    [4,2,7],
    [2,5,6]
])
makeMagicSquaere([
    [3,1,4],
    [2,5,6],
    [3,8,9]
])



// MARK: - RANKED

func getLatestRank(ranked: Array<Int>, player: Array<Int>){
    
    //get rid of duplication
    var currentRanked = ranked.reduce([Int]()) { (result, value) -> [Int] in
        var mutableResult = result
        mutableResult.contains(value) ? nil : mutableResult.append(value)
        return mutableResult
    }
    
    
    for score in player{
        
        currentRanked.contains(score) ? nil : currentRanked.append(score)
        
        currentRanked.sort(by: {$0 > $1})
        
        print("poin \(score) berada di peringkat \(currentRanked.firstIndex(of: score)! + 1)")
    }
}

getLatestRank(ranked: [200, 150, 150, 90], player: [80, 90, 210])

