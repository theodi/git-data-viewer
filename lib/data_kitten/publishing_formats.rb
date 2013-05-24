require 'data_kitten/publishing_formats/datapackage'

module DataKitten
  
  module PublishingFormats

    private

    def detect_publishing_format
      [
        DataKitten::PublishingFormats::Datapackage
      ].each do |format|
        extend format if format.supported?(self)
      end
    end

  end
  
end
