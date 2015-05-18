# => It is easy to add another formats handler. 
# => You need to inherit your class from folder.rb and override save method and MASKS. 
module ImageHandler
  class Folder < ImageHandler::BaseItem

    MASKS = ["/*.jpg", "/*.png"]

    def initialize(input_path, imagemagick_line, output_path)
      super(input_path, imagemagick_line, output_path)
      is_input_valid?(input_path)
    end

    def process()
      super({masks: MASKS})
    end

  end
end