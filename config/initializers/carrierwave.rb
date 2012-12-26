if Rails.env.development? or Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.asset_host = "http://172.27.3.4:3000/"
  end
end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :file
    config.asset_host = "http://dev.1trip.com"
  end
end