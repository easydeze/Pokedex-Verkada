# Pokedex-Verkada

# Milestone 1
For the first milestone, I started by calling the PokéAPI and testing the HTTP GET request to ensure I was able to fetch the Pokémon data using Postman. After I verified a successful connection, I then went into XCode and chose to utilize SwiftUI to first call the API with parameters that allowed me to fetch all of the Pokémon, then display it in a Grid. I chose to display the Pokémon by having three in each row to ensure visibility. Then I elected to have each Pokémon cell be a Button such that when a user clicks on the cell, it would trigger fetchPokemonDetails, which set the viewModel's selectedPokemon to be the Pokémon that was clicked on. Then the sprite would appear in the top center of the application, as per the instructions.

# Milestone 2
The second milestone was an interesting optimization problem, as I had previously called to get all of the 1,010 Pokémon at once using the API and populated the Grid using this fetch. Pagination would allow for the loading of more Pokémon only when it is necessary – only when we have reached the point when all of the Pokémon that can be shown are actually shown. Once we have reached this point, then we would need to load the next 20 Pokémon since we don't too much overhead getting the next elements. In the file "PokemonViewModel", I kept track of current number of Pokémon shown through the variable self.currentPage and add the Pokémons that have already been processed using the list self.pokemons. Through the function checkAndLoadMoreData, I determine whether we have reached the last Pokémon in the list and then call to fetch more data through the function fetchPokemons

# Milestone 3

# Code structure

# Design

# Technical Decisions
