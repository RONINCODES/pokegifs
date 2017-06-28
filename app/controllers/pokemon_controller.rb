class PokemonController < ApplicationController

  def index
    res = Typhoeus.get("http://pokeapi.co/api/v2/pokemon/pikachu/", followlocation: true)
    body = JSON.parse(res.body)
     # should be "pikachu"

    render json:{
  "name": body["name"]
  }
  end

  def show
    pokeres = Typhoeus.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/", followlocation: true)
    pokebody = JSON.parse(pokeres.body)
     # should be "pikachu"
    gifres = Typhoeus.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_KEY']}&q=#{pokebody['name']}&rating=g", followlocation: true)
    gifbody = JSON.parse(gifres.body)
    render json:{
        "name": pokebody["name"],
            "id": pokebody["id"],
      "types": pokebody["types"][0]["type"]["name"],
      "gif": gifbody["data"].first["images"]["original"]["url"]
  }
  end



end
