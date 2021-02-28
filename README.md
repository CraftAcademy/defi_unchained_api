## DeFi Unchained Client
DeFi Unchained will become the new go-to hub for people interested in crypto. There’s a page dedicated to displaying various info about the different coins. Then there’s a news section for all logged in users, and finally, we have built a powerful algorithm that is able to determine which coins you should buy. This is of course only for paying subscribers. 

Deployed at: https://defi-unchained.netlify.app/

## Dependencies
* Rack Cors
* Rest Client
* Devise Token Auth
* Stripe Rails

## Setup
* Clone the repo and cd into folder
* Run bundle install
* Start the **rails s**

## Improvements
* More user interactivity such as user can search for specific crypto info
* Search and filter functionality for the news
* Adding language options, for example Swedish and Danish
* People will be able to buy and sell crypto currencies on the site 

### User Stories:
```
As a Crypto API
In order to serve a client with info about Market Cap History
I would like to be able to provide an endpoint for a market-cap/history index
```
```
As a Crypto API
In order to serve a client with info about top 5 cryptos
I would like to be able to provide an endpoint for a currencies/ticker index
```
```
As a crypto API
In order to give authenticated users access to news
It needs to respond with a list of news for authenticated requests
```
```
As a crypto API
In order to give special access to some users
I need an extra layer of authorization
```
```
As a crypto API
In order to provide subscribers with a daily buy signal
I need to provide a buy_signal endpoint that also validates if user is a subscriber
```