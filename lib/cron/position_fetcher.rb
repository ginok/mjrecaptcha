require 'open-uri'

class Cron::PositionFetcher
  class << self
    def fetch_and_store_positions
      Rails.logger.info("start to fetch possitions")
      from = last_created_time
      Rails.logger.info("start from=#{from}")
      open("http://mjt.fedc.biz/pai_positions.json?from=#{Rack::Utils.escape(from)}") do |f|
        JSON.parse(f.read).each do |pai|
          pi = pai["pai_position"]
          if pi["initial_probability"] < 0.8
          PaiPosition.create(
            image_url: pi["image_url"],
            x: pi["x"],
            y: pi["y"],
            width: pi["width"],
            height: pi["height"],
            initial_probability: pi["initial_probability"],
            initial_pai_type: pi["initial_pai_type"],
            original_created_at: pi["created_at"]
          )
          end
        end
      end
      Rails.logger.info("finish to fetch possitions")
    rescue => e
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace)
    end

    def last_created_time
      Time.parse(PaiPosition.last.try(:original_created_at) || "2000-01-01").utc
    end
  end
end
