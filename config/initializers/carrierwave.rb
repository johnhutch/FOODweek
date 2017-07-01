CarrierWave.configure do |config|

	if Rails.env.test?
    config.enable_processing = false
	end

  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file

			config.ignore_integrity_errors = false
			config.ignore_processing_errors = false
			config.ignore_download_errors = false
    end
  end
  
  # Use AWS storage if in production
  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
  
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => ENV['S3_KEY'], 				            # required
    :aws_secret_access_key  => ENV['S3_SECRET'],						      # required
    :region                 => ENV['S3_REGION']                   # optional, defaults to 'us-east-1'
  }
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}

	config.cache_dir = "#{Rails.root}/tmp/uploads"

  config.fog_directory    = ENV['S3_BUCKET_NAME']
  config.s3_access_policy = :public_read                          # Generate http:// urls. Defaults to :authenticated_read (https://)
  config.fog_host         = "#{ENV['S3_ASSET_URL']}/#{ENV['S3_BUCKET_NAME']}"
end
