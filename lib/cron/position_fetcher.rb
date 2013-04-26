require 'open-uri'

class Cron::PositionFetcher
  class << self
    def fetch_and_store_positions
      open("http://mjt.fedc.biz/pai_positions.json") do |f|
        JSON.parse(f.read).each do |pai|
          pi = pai["pai_position"]
          PaiPosition.create(
            image_url: pi["image_url"],
            x: pi["x"],
            y: pi["y"],
            width: pi["width"],
            height: pi["height"],
            initial_probability: pi["initial_probability"],
            initial_pai_type: pi["initial_pai_type"]
          )
        end
      end
    end
  end
end
