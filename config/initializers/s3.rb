CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAI543OEVTQNLAWDBA",
      :aws_secret_access_key  => "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",
      :region                 => 'us-west-1' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "rinchan-assets"
end
