# WeatherExpo
A weather explorer iOS application Demo that fetches data from a remote location, sorts and displays a list of items in the data to the user, and allows the user to view more details for an item.

## The App
WeatherExpo fetches and displays the weather conditions for different suburbs around Australia and some other countries. 
Some sorting/filtering of the weather data are involved.

## Data
- The dummy data and data structure was derived by the file
    - http://dnu5embx6omws.cloudfront.net/venues/weather.json
- The Detail Data Models are placed Under DataModel folder

## Design and UI
WeatherExpo completely follows the prototype of the design:
https://projects.invisionapp.com/share/78EQZ5ESK#/screens/267017872

However some of the specs are not pixel accurate because I can't view the InvisionApp's specs in details.

## Features
- [x] Open, build and run the project without any further setting up with lastest version of Xcode (**12.4 (12D4e)**)
- [x] Pull to refresh the data
- [x] Inform the user when the data was last updated from the server
- [x] Information should be sortable by:
    - Alphabetically
    - Temperature
    - Last updated
- [x] Suburbs should be filterable by:
    - Country
- [x] Tapping on a suburb to present another view with further details about the weather including the weather conditions, wind, humidity, and feels like temperature

## GitRepo
https://github.com/Unibrighter/WeatherExpo