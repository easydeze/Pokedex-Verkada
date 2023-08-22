# Pokedex-Verkada



# Milestone 1
For the first milestone, I started by calling the PokéAPI and testing the HTTP GET request to ensure I was able to fetch the Pokémon data using Postman. After I verified a successful connection, I then went into XCode and chose to utilize SwiftUI to first call the API with parameters that allowed me to fetch all of the Pokémon, then display it in a Grid. I chose to display the Pokémon by having three in each row to ensure visibility. Then I elected to have each Pokémon cell be a Button such that when a user clicks on the cell, it would trigger fetchPokemonDetails, which set the viewModel's selectedPokemon to be the Pokémon that was clicked on. Then the sprite would appear in the top center of the application, as per the instructions.

# Milestone 2
The second milestone was an interesting optimization problem, as I had previously called to get all of the 1,010 Pokémon at once using the API and populated the Grid using this fetch. Pagination would allow for the loading of more Pokémon only when it is necessary – only when we have reached the point when all of the Pokémon that can be shown are actually shown. Once we have reached this point, then we would need to load the next 20 Pokémon since we don't too much overhead getting the next elements. In the file "PokemonViewModel", I kept track of current number of Pokémon shown through the variable self.currentPage and add the Pokémons that have already been processed using the list self.pokemons. Through the function checkAndLoadMoreData, I determine whether we have reached the last Pokémon in the list and then call to fetch more data through the function fetchPokemons

# Milestone 3
The last milestone was also a very important optimization problem. I largely kept the logic the same, which was that I passed the viewModel's selected Pokémon, which was populated with details such as the front_default property, into the PokedexView. However, in order to cache the images such that I would only need to fetch each Pokémon's sprite image only one time, I utilized a well-document and widely used framework called SDWebImageSwiftUI. I will talk about this decision in a later section.

# Code structure
I utilized MVVM architecture to separate the graphical user interface from the logic. It allowed me to clearly tackle each part of the project in a modular and clear fashion.

# Design
Similar to the Pokédex from the show, I wanted to have the mobile app look similar to the actual device. Thus, the color palette and image assets are inspired by the series. I utilized a GIF of Pikachu as a placeholder, waiting for the user to click on their desired Pokémon.

# Technical Decisions
The decision to utilize SDWebImageSwiftUI in implementing image caching was one that I had to deliberate on for quite some time. But after reading the documentation and tutorials, the fact that this framework allowed for progressive image loading and animation, as well as utilizing caching to ensure that the same URL will never have to be requested twice made it easy. It is easily maintainable and future-proof.
