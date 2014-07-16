# encoding: utf-8

class SalesAidUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :dropbox

  def store_dir
    ['AmafermResearchBackOffice', DropboxConfig::SUBFOLDER, model.class.to_s.pluralize.underscore, model.id].join '/'
  end

  def extension_white_list
    %w(pdf doc docx ppt pptx xls xlsx)
  end
end
