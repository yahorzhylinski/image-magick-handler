# => used for output folder name generation
require 'digest/md5'

module ImageHandler
  class HandlerBuilder

    DEFAULT_IMAGE_MAGICK_LINE = "mogrify "

    DEFAULT_RESIZE_PERCENT = 50
    INVALID_RESIZE_PERCENT_ERROR = "Resize pecent should be Integer or nil"

    RESIZE_PATTERN = " -resize %i\%"

    def initialize(path, output_path=nil)
      @path = path
      @output_path = output_path
      @image_magick_line = DEFAULT_IMAGE_MAGICK_LINE
    end

    def with_resize(percent=DEFAULT_RESIZE_PERCENT)

      # => if percent is not Integer
      if !percent.is_a?(Integer)
        raise Error::InvalidResizePercentError.new(INVALID_RESIZE_PERCENT_ERROR)
      end

      @image_magick_line += RESIZE_PATTERN % [percent]
      self
    end

    # => You can add another options(for example filter, rotate, ...). 
    # => You need to write new method there similar to with_resize.


    def build
      Folder.new(@path, @image_magick_line, @output_path)
    end

  end
end
