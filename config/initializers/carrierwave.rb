if Rails.env.development? or Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.asset_host = "http://192.168.0.100:3000"
  end
end