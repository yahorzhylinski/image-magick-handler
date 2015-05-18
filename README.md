# Imagemagick Test Task
## Classes Diagram
http://www.awesomescreenshot.com/image/157644/42b3e0d09986c3bfa9e7fd68c03f8481

## How to use :

```shell
ruby main.rb 'path/to/folder/with/images'
```

## Description :

By default all images save in ~/Desktop/md5hash_directory_name. Also you can change output directory(pass path_param to save method).

Also You can change resize percent. You need to pass your_percent(Integer value) to resize method. Look at main.rb and image_manipulator/manipulator_builder.rb

It is easy to add another formats handler. You need to inherit your class from folder.rb and override save method and MASKS. 
Also you can add single image handler. You need inherit you class from base_item.rb and override MASKS. Look comments in folder.rb.

All mogrify processes start in new thread. I think it speeds up resizing(when there are a lot of images).

You can add another options(for example filter, rotate, ...). 
You need to write new method in manipulator_builder.rb similar to resize and call them in main.rb.

## Mogrify 

Using mogrify i can set output directory path.
Also using mogrify i can set pattern for input images.

## Literature
 - http://www.imagemagick.org/Usage/resize/
 - http://stackoverflow.com/
 - http://ruby-doc.org/
 - http://stackoverflow.com/questions/8707694/batch-resize-images-into-new-folder-using-imagemagick