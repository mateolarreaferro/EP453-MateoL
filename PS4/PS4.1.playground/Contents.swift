import UIKit
//Creation of class Weather
class Weather{
    var low: Float
    var high: Float
    var prec: Float
    var wind: Float
    //initialization
    init(low: Float, high: Float, prec: Float, wind: Float) {
  self.low = low
  self.high = high
  self.prec = prec
  self.wind = wind
    }
}
//Variables
var yesterday: Weather = Weather(low: 46.0, high: 51.2, prec: 40.0, wind: 11.0)
var today: Weather = Weather(low: 42.3, high: 47.8, prec: 36.4, wind: 16.5)
var difference: Weather =   Weather(low: yesterday.low - today.low, high: yesterday.high - today.high, prec: yesterday.prec - today.prec, wind: yesterday.wind - today.wind)
//Output (I know there's a much more elegant and simple way of doing this..I'll ask tomorrow in class)
print("The weather difference between the two days is:")
print("Low:", difference.low,"°F")
print("High:",difference.high, "°F")
print("Precipitation:",difference.prec, "%")
print ("Wind Speed:",difference.wind, "MPH")




