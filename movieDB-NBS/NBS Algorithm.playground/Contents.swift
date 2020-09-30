import UIKit



// MARK: - VALID STRING

//Sebuah String dikatakan valid jika memenuhi kriteria berikut :
//1. Semua karakter dalam string muncul dalam jumlah yang sama, atau.
//2. Jika dengan menghapus satu karakter, dapat memenuhi kriteria nomor 1,
//   maka string masih bisa dikatakan valid.
//
//deskripsi fungsi :
//input parameter : string
//action 1 : print result apakah string dikategorikan valid atau tidak

func isValidString(_ string: String) -> Bool{
    
    var trim = ""
    var dict = [Character: Int]()

    
//    MARK: FANCY WAY
    
//    //trimming
//    trim = string.filter {!" ".contains($0)}
//    // reduce each character return a dict
//    dict = trim.reduce(into: [:]) { counts, letter in
//        counts[letter, default: 0] += 1
//    }
//

    
    //MARK: OLD SCHOOL
    
    // MANIPULATE STRING
    string.forEach { (i) in
        i != " " ? trim.append(i) : nil
    }
    
    
    trim.forEach { (i) in
        // char[i] = char[i] == nil ? 1 : char[i]! + 1
        
        if dict[i] == nil{
            dict[i] = 1
        }else{
            dict[i]! += 1
        }
    }

    
    
    
    
    // VALIDATION
    print(dict)
    
    let valueOnly = dict.map { (key, value) -> Int in
        return value
    }
    
    var twoNumber = 0
    var threeNumber = 0
    
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



isValidString("aabbccddeefghi")
isValidString("abcdefghhgfedecba")
isValidString("a bb c d e a e d c")







// MARK: - KOTAK AJAIB
//Kotak Ajaib adalah matriks array integer 3x3 yang terdiri dari angka dalam
//rentang 1x9, yang mana jika di jumlahkan setiap kolom, baris dan diagonalnya
//akan mendapatkan hasil yang sama: Angka Ajaib (magic constant).



// - NOTES: what kind of solution do you want? you see example solution in email, that's not 17 in diagonal
// I tried figuring out for hours and then realize that's the wrong example, whyy
// so there you go, this is best i can do


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
    
    print("HIGHEST SUM: \(highestSum)")
    
    
    //validate hightest sum
    guard highestSum <= 9 * 3, highestSum >= 3 else {fatalError("highest sum must be in range of 3 and 27")}
    
    
    // create new matrix
    // there is no rule one number per coloum or row, so there you go, best i can do, and please read the notes above this function
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

// Seorang pemain mesin dingdong ingin menjadi peringkat pertama pada
// leaderboard dan melacak peringkatnya. Game tersebut menggukana sistem
// Dense Ranking, sehingga leaderboard nya memiliki rules sebagai berikut:
// 1. Pemain dengan poin tertinggi akan menjadi peringkat pertama pada
// leaderboard.
// 2. Pemain-pemain dengan poin yang sama akan berada pada peringkat yang
// sama, dan pemain berikutnya akan berada pada peringkat setelahnya secara
// berurutan.


// sorry I ran out of time (dari senin, rabu harus selesai), the ranked problem was not solve
// thanks for your time
func getLatestRank(ranked: Array<Int>, player: Array<Int>){
    
    var dict = ranked.sorted(by: {$0 < $1}).reduce(into: [:]) { (result, i) in
    
        if result[i] == nil{
            result[i] = result.count + 1
        }else{
            result[i] = result[i] as! Int + 1
        }
    }
    
    
    player.forEach { (scors) in
        
    }
    
    print(dict)
    
}








