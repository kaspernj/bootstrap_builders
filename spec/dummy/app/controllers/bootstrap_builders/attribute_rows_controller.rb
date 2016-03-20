class BootstrapBuilders::AttributeRowsController < ApplicationController
  def model_rows
    @user = User.find(params[:user_id])
  end
end
