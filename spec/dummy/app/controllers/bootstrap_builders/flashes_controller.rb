class BootstrapBuilders::FlashesController < ApplicationController
  def generate_flash
    flash[:success] = "Success flash"
    render :show_flash
  end

  def show_flash
  end
end
