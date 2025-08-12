import SwiftUI
import Foundation


struct PersonData {
    let gender: Double
    let weight: Double
    let overweight: Int
}

let dataset: [PersonData] = [
    PersonData(gender: 0, weight: 48, overweight: 0),
    PersonData(gender: 0, weight: 52, overweight: 0),
    PersonData(gender: 0, weight: 55, overweight: 0),
    PersonData(gender: 0, weight: 60, overweight: 0),
    PersonData(gender: 0, weight: 63, overweight: 0),
    PersonData(gender: 0, weight: 68, overweight: 1),
    PersonData(gender: 0, weight: 72, overweight: 1),
    PersonData(gender: 0, weight: 75, overweight: 1),
    PersonData(gender: 0, weight: 80, overweight: 1),
    PersonData(gender: 0, weight: 85, overweight: 1),
    PersonData(gender: 1, weight: 60, overweight: 0),
    PersonData(gender: 1, weight: 65, overweight: 0),
    PersonData(gender: 1, weight: 70, overweight: 0),
    PersonData(gender: 1, weight: 75, overweight: 0),
    PersonData(gender: 1, weight: 78, overweight: 0),
    PersonData(gender: 1, weight: 82, overweight: 1),
    PersonData(gender: 1, weight: 85, overweight: 1),
    PersonData(gender: 1, weight: 90, overweight: 1),
    PersonData(gender: 1, weight: 95, overweight: 1),
    PersonData(gender: 1, weight: 100, overweight: 1)
]

func knnPredict(gender: Double, weight: Double, k: Int) -> Int {
    let distances = dataset.map { data -> (distance: Double, label: Int) in
        let dg = data.gender - gender
        let dw = data.weight - weight
        let dist = sqrt(dg * dg + dw * dw)
        return (dist, data.overweight)
    }
    
    let kNearest = distances.sorted { $0.distance < $1.distance }.prefix(k)
    
    let ones = kNearest.filter { $0.label == 1 }.count
    let zeros = kNearest.count - ones
    
    return ones > zeros ? 1 : 0
}

struct ContentView: View {
    @State private var gender: Double = 0
    @State private var weight: Double = 70
    @State private var prediction: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Overweight Predictor")
                .font(.largeTitle)
                .bold()

            Picker("Gender", selection: $gender) {
                Text("Female").tag(0.0)
                Text("Male").tag(1.0)
            }
            .pickerStyle(.segmented)
            .frame(width: 200)

            Stepper(value: $weight, in: 30...150, step: 1) {
                Text("Weight: \(Int(weight)) kg")
            }
            .frame(width: 200)

            Button("Predict") {
                let result = knnPredict(gender: gender, weight: weight, k: 3)
                prediction = result == 1 ? "overweight" : "normal"
            }
            .buttonStyle(.borderedProminent)

            Text(prediction)
                .font(.title)
                .bold()
                .padding(.top)
        }
        .padding()
        .frame(minWidth: 300, minHeight: 300)
    }
}

#Preview {
    ContentView()
}
