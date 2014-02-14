# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  storage :dropbox

  def store_dir
    ['AmafermResearchBackOffice', DropboxConfig::SUBFOLDER, model.class.to_s.pluralize.underscore, model.id].join '/'
  end

  def extension_white_list
    %w(pdf doc docx)
  end
end
