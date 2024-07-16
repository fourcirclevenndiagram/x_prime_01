import SwiftUI

struct ContentView: View {
    @State private var numberA = 0
    @State private var numberB = 0
    @State private var sumPlusOne = 0
    @State private var factorization = ""

    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("a: \(numberA), b: \(numberB)")
            Text("a + b + 1 = \(sumPlusOne)")
            Text("Factors: \(factorization)")
        }
        .onReceive(timer) { _ in
            generatePrimeNumbers()
            calculateFactors()
        }
        .onAppear {
            generatePrimeNumbers()
            calculateFactors()
        }
    }

    func generatePrimeNumbers() {
        numberA = randomPrime(upTo: 99999999)
        numberB = randomPrime(upTo: 99999999)
        sumPlusOne = numberA + numberB + 1
    }

    func randomPrime(upTo upperLimit: Int) -> Int {
        while true {
            let num = Int.random(in: 2..<upperLimit)
            if isPrime(num) {
                return num
            }
        }
    }

    func calculateFactors() {
        let value = sumPlusOne
        if isPrime(value) {
            factorization = "prime"
        } else {
            factorization = factorize(value).map(String.init).joined(separator: ", ")
        }
    }

    func isPrime(_ n: Int) -> Bool {
        guard n >= 2 else { return false }
        guard n != 2 else { return true }
        guard n % 2 != 0 else { return false }
        return !stride(from: 3, through: Int(Double(n).squareRoot()), by: 2).contains { n % $0 == 0 }
    }

    func factorize(_ n: Int) -> [Int] {
        var n = n
        var factors: [Int] = []
        var divisor = 2
        while divisor * divisor <= n {
            while (n % divisor) == 0 {
                factors.append(divisor)
                n /= divisor
            }
            divisor = divisor == 2 ? 3 : divisor + 2
        }
        if n > 1 { factors.append(n) }
        return factors
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
