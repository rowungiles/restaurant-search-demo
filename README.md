# Restaurant Search Demo

## Setup
The results are powered by the Zomato API. [You'll need a token](https://developers.zomato.com/api#headline2). Put that token into the "zomato" dictionary value in:
`./restaurant-search-demo/RestaurantSearchDemo/Helpers/APIDetails/APIData/APITokens.plist`

## Overview:
The app lets you search for a location name (e.g. Camden, Clapham) - it renders the returned restaurants for that location.


## Dev notes:
- No automation tests on ViewLayer due to time constraints
- The API supports paging but that's not implemented in the client
- The query to the Zomato API is hardcoded as type city, and city is London

## API Docs:
Zomato: https://developers.zomato.com/documentation
