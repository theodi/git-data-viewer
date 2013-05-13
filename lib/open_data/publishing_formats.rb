require 'open_data/publishing_formats/datapackage'

module OpenData
  
  module PublishingFormats

    def detect_publishing_format
      [
        OpenData::PublishingFormats::Datapackage
      ].each do |format|
        extend format if format.supported?(self)
      end
    end

  end
  
end
