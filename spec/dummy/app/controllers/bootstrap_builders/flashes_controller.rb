class BootstrapBuilders::FlashesController < ApplicationController
  def generate_flash
    flash[:success] = "Success flash"
    if params[:class]
      render :show_flash_with_custom_class
    else
      render :show_flash
    end
  end

  def show_flash; end

  def show_flash_with_custom_class; end
end
