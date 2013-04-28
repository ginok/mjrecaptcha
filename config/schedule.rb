env :PATH, ENV['PATH']

every :hour do
  runner "Cron::PositionFetcher.fetch_and_store_positions"
end
