class MyUploader < CarrierWave::Uploader::Base
    storage :fog


    def save_image(img_name)
      file = File.open(img_name)
      uploader = MyUploader.new
      uploader.store!(file)
    end
  end
