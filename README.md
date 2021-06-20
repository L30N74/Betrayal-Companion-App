# Betrayal Companion App

An app to acompany the board-game &#x27;Betrayal at House on the Hill&#x27;.

## Screens

### Home Screen

<img src="https://user-images.githubusercontent.com/51761671/122687846-03851200-d219-11eb-8303-c67f92f56ae1.jpg" width=250>

The entry Screen. Here the user can start a new game or resume a currently on-going one.

When starting a new game whilst a game is currently active, a warning will ask the player if he really wants to replace the old one.

---

### Player-Count
<img src="https://user-images.githubusercontent.com/51761671/122687167-5d83d880-d215-11eb-903b-9f7077aa6b69.jpg" width=250>

Randomize will select the chosen amount of players at random.

Picking "I want to choose" will redirect to the following page:

<img src="https://user-images.githubusercontent.com/51761671/122687239-aa67af00-d215-11eb-9a51-5d84a2353a4d.jpg" width=250>

Here one can choose a character one after the other by swiping left/right and then pressing "Choose".

--- 

### Two-Player mode

Normally the game doesn't allow for two players, but my girlfriend and I came up with this mode:

#### Mode explanation 
A third character is chosen (either at random, or manually selected) and one player plays as two characters.
Then, when the haunt gets revealed, if the traitor is one of the character of the player that controls two characters, that player hands over the non-traitor character to the other player so he plays the two, as the game calls them, "heroes".

#### Feature

If a number of two players was chosen, the user is redirected to a page to toss a coin.

<img src="https://user-images.githubusercontent.com/51761671/122687413-a5572f80-d216-11eb-9e9a-d7268c6fb77e.jpg" width=250> 

Here the players either select heads or tails. The winner gets to decide if he wants to choose the thrid character himself or wants to be given a random one.

<img src="https://user-images.githubusercontent.com/51761671/122687534-3a5a2880-d217-11eb-86cf-1798e5e7f288.jpg" width=250>

---

### Main Screen

This page shows the characters of the players alongside their player's number.
When first entering this page, the starting player will be announced.

<img src="https://user-images.githubusercontent.com/51761671/122687541-4514bd80-d217-11eb-91a0-5683a0c9906f.jpg" width=250> <img src="https://user-images.githubusercontent.com/51761671/122687577-72fa0200-d217-11eb-9855-c2519b432dcf.jpg" width=250>

When pressing on one of the character's cards, a redirect to status page will occur.

---

### Status Screen

<img src="https://user-images.githubusercontent.com/51761671/122687642-d421d580-d217-11eb-8ee1-2ae98cbc4b43.jpg" width=250>

Here the player can view and change or reset the character's "traits". When any of the four traits falls on the "X", the character is declared dead, which is the represented by the text "DEAD" over the character's picture.

---

### Omen Count Screen

On this screen the amount of omen cards drawn throughout the game can be tracked. That amount is needed for haunt rolls to determine the start of the haunt.

<img src="https://user-images.githubusercontent.com/51761671/122688208-329c8300-d21b-11eb-8a52-6225a981fc55.jpg" width=250>

### Haunt-reveal Screen

<img src="https://user-images.githubusercontent.com/51761671/122687757-5ad6b280-d218-11eb-8f65-5929d4b23d3f.jpg" width=250> <img src="https://user-images.githubusercontent.com/51761671/122687760-5ca07600-d218-11eb-842c-dc6c2f6e188c.jpg" width=250>

On this screen the second phase of the game, the haunt, can be revealed, by selecting the omen card that was and the room in which the omen was drawn when the haunt roll failed.
Ticking the checkbox "Use Widow's Walk Expansion" will add the expansion's omen cards and room-tiles into the mix.
