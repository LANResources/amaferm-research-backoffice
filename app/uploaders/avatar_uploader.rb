# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :dropbox

  def store_dir
    ['AmafermResearchBackOffice', DropboxConfig::SUBFOLDER, model.class.to_s.pluralize.underscore, model.id].join '/'
  end

  def default_url
    url_string = case version_name.try(:to_sym)
    when :small
      "trvfih3c3sybsst"
    when :thumb
      "grdkk49dep2ppmg"
    when :medium
      "mynwp7gjfia62cu"
    when :tiny
      "kfr8kdsct5h848y"
    else
      "eoje2v7ua3vsv46"
    end
    "https://www.dropbox.com/s/#{url_string}/missing.png?dl=1"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  version :small do
    resize_to_limit 150, 150
  end

  version :thumb do
    resize_to_limit 100, 100
  end

  version :medium do
    resize_to_limit 200, 200
  end

  version :tiny do
    resize_to_limit 42, 42
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
