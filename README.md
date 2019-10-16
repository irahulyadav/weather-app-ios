# Weather-App
A simple mac and iOS demo project for Weather-App based on <b>MVC clean architecture</b>.

<img src="https://github.com/irahulyadav/weather-app-ios/blob/master/Screen%20Shot%202019-10-16%20at%2009.11.00.png" width="200" style="max-width:100%;"> <img src="https://github.com/irahulyadav/weather-app-ios/blob/master/Screenshot%202019-10-16%20at%2009.30.02.png" width="400" style="max-width:100%;"> </br></br>

#### App Features
* Users can see current place weather detail.


#### App Architecture 
Based on MVC architecture pattern.
 
 #### The app includes the following main components:
* A WeatherApi api service.
* A LocationService that that provice current location of device.


#### App Groups
* <b>service</b> - contains the api classes to make api calls and find current location of device. 
* <b>model</b> - contains classes to handle response and model.
* <b>WeatherInfoVC</b> - UIViewController which deplay weather.


#### App Specs
* XCode - Version 11.0
* iOS Deployement Target - 13.0
* Mac OS - 10.15
* Swift - '5.0'
* MVC Architecture
