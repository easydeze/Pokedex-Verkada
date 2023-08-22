import SwiftUI
import SDWebImageSwiftUI

struct PokedexView: View {
    @ObservedObject var viewModel: PokemonViewModel
    
    // Define the grid layout
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        VStack {
            // Title
            Text("Pokédex")
                .font(.headline)
        }
        VStack {
            HStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                    .offset(x: -90.0, y: 20.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.845, brightness: 0.482))
                    .offset(x: -85.0, y: 5.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow)
                    .offset(x: -80.0, y: 4.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.green)
                    .offset(x: -75.0, y: 4.0)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            }
            // Selected Pokemon Image
            if let selectedPokemon = viewModel.selectedPokemon {
                WebImage(url: URL(string: selectedPokemon.sprites.front_default ?? ""))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.bottom, 20)
            } else {
                WebImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/25.gif" ?? ""))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding([.leading, .bottom], 25.0)
            }
            
           let gridItemLayout = [GridItem(.fixed(100)), GridItem(.fixed(100)), GridItem(.fixed(100))]

            // Pokemon Grid
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(viewModel.pokemons, id: \.name) { pokemonItem in
                        Button(action: {
                            viewModel.fetchPokemonDetails(for: pokemonItem)
                        }) {
                            VStack {
                                Image("pokeball")
                                Text(pokemonItem.name.capitalized)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            .padding(.all, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                        .onAppear {
                            viewModel.checkAndLoadMoreData(currentItem: pokemonItem)
                        }
                    }
                }

                .padding(.horizontal, 15)
            }
        }
        .background(Color.red)
        .onAppear {
            viewModel.fetchPokemons()
        }
    }
}
