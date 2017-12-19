class PokemonController < ApplicationController
# require 'byebug'
  def index

  end

  def show
    pokemon_res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    pokemon_body = JSON.parse(pokemon_res.body)
    # binding.pry

    giphy_res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{pokemon_body["name"]}&rating=g")
    giphy_body = JSON.parse(giphy_res.body)
    gif_url = giphy_body["data"][0]["url"]
    # binding.pry


    # name  = giphy_body["name"]


    render json: {
      "id": pokemon_body["id"],
      "name": pokemon_body["name"],

      #
      # [
      #   {
      #     "slot"=>2,
      #     "type"=>{
      #       "url"=>"https://pokeapi.co/api/v2/type/4/",
      #       "name"=>"poison"
      #     }
      #   },
      #   {
      #     "slot"=>1,
      #     "type"=>{
      #       "url"=>"https://pokeapi.co/api/v2/type/12/",
      #       "name"=>"grass"
      #       }
      #     }
      #   ]
      #
      #   type = {
      #     "slot"=>2,
      #     "type"=>{
      #       "url"=>"https://pokeapi.co/api/v2/type/4/",
      #       "name"=>"poison"
      #     }
      #   }
      #
      #   type["type"]["name"]
      #
      #   {
      #     "url"=>"https://pokeapi.co/api/v2/type/4/",
      #     "name"=>"poison"
      #   }
      #
      "types": pokemon_body["types"].map {|type| type["type"]["name"]},
      "gif": gif_url,
    }
  end

end
