# => Also you can add single image handler. 
# => You need inherit you class from BaseItem and override masks param. Look comments in folder.rb.
module ImageHandler
  class BaseItem

    INVLIAD_FOLDER_OR_IMAGE_PATH_ERROR = "%s doesn't exist"
    ALREADY_EXIST_FOLDER_OR_FILE_ERROR = "%s already exists"
    OUTPUT_FOLDER_CANNOT_BE_CREATED = "Output folder: %s can't be created"
    OUTPUT_PATH_DOESNT_SET = "Output folder doesnt't set. Please call save method before"

    PATH_TO_SAVE = " -path %s"
    
    def initialize(input_path, imagemagick_line, output_path)
      @input_path = input_path
      @imagemagick_line = imagemagick_line
      @output_path = output_path
    end

    def process(opts={})

      # => raise exception if output is not valid
      if @output_path && is_output_valid?(@output_path)
        raise Error::InvalidFolderOrImagePathError.new(ALREADY_EXIST_FOLDER_OR_FILE_ERROR % [@output_path]) 
      end

      # => if path is not set, image(s) will be saved in ~/md5_hash_folder_name
      @output_path ||= get_path_for_new_folder()
      
      # => create output folder
      system *`mkdir -p #{@output_path}`
      
      @output_folder_path = @output_path

      # => mask should be passed
      if !(opts[:masks])
        raise ::NotImplementedError.new
      end

      threads = []

      (opts[:masks] || MASKS).map do | mask |
        threads << Thread.new do 
          # => add output and input pathes
          tmp_line = @imagemagick_line + PATH_TO_SAVE % [@output_path] + " " + @input_path + mask

          # => execute mongrify process
          `#{tmp_line}`
        end
      end

      # => wait for all threads
      threads.each { | thread | thread.join }
    end

    def output_folder_path
      if !@output_folder_path
        raise Error::InvalidFolderOrImagePathError.new(OUTPUT_PATH_DOESNT_SET)
      end
      @output_folder_path
    end

    protected

      def is_input_valid?(input)
        raise Error::InvalidFolderOrImagePathError.new(INVLIAD_FOLDER_OR_IMAGE_PATH_ERROR % [input]) unless File.exist?(input)
      end

      def is_output_valid?(output)
        File.exist?(output)
      end

      def get_path_for_new_folder
        " #{File.expand_path('~')}/Desktop/#{Digest::MD5.hexdigest(Time.now.to_s)} "
      end

  end
end