require_relative './image_handler/handler_builder.rb'
require_relative './image_handler/base_item.rb'
require_relative './image_handler/folder.rb'
require_relative './image_handler/error/invalid_folder_or_image_path_error.rb'
require_relative './image_handler/error/invalid_resize_percent_error.rb'

if ARGV.size == 0
  p "How to use: " \
    "ruby main.rb '/path/to/folder'"
  exit
end

begin
  folder = ImageHandler::HandlerBuilder.new(ARGV[0]).with_resize().build()
  folder.process()
  #folder = ImageManipulator::Folder.new(ARGV[0]).resize
  #folder.save()

  printf "Your images saved in #{folder.output_folder_path}\n\n\n"
rescue ImageHandler::Error::InvalidFolderOrImagePathError => e
  p e.to_s
rescue ImageHandler::Error::InvalidResizePercentError => e
  p e
end
