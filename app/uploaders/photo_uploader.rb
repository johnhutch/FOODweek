class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :web do
    version :thumb    { process :resize_to_fit => [32, 32] }
    version :preview  { process :resize_to_fit => [128, 128] }
    version :full     { process :resize_to_fit => [1024, 768] }
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
