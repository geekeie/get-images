class ConversionsController < ApplicationController
  def png_to_jpg
    # Logic for handling PNG to JPG conversion
    if params[:image].present?
      uploaded_file = params[:image]
      output_file = "#{Rails.root.join('tmp')}#{SecureRandom.uuid}.jpg"

      # Simulate PNG to JPG Conversion (using RMagick or MiniMagick)
      begin
        image = MiniMagick::Image.read(uploaded_file.tempfile)
        image.format 'jpg'
        image.write(output_file)

        send_data File.read(output_file), filename: 'converted_image.jpg', type: 'image/jpeg'
        File.delete(output_file)
      rescue StandardError => e
        flash[:error] = "Conversion failed: #{e.message}"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:error] = 'No image file provided.'
      redirect_back(fallback_location: root_path)
    end
  end
end