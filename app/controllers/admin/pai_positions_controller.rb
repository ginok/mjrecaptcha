class Admin::PaiPositionsController < ApplicationController
  def index
    @pai_positions = PaiPosition.all
  end

  def identify
    @pai_position = PaiPosition.find(params[:id])
    if @pai_position.identify!
      redirect_to admin_pai_positions_path, notice: "Successfully identified!"
    else
      redirect_to admin_pai_positions_path, notice: "Fail to identify!"
    end
  end
end
