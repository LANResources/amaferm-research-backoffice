# encoding: utf-8

class SalesAidUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    [S3Config::SUBFOLDER, model.class.to_s.pluralize.underscore, model.id].join '/'
  end

  def extension_white_list
    %w(pdf doc docx ppt pptx xls xlsx)
  end
end
