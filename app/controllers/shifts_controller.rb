class ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shift, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @shifts =current_user.shifts
    respond_with(@shifts)
  end

  def show
    respond_with(@shift)
  end

  def new
    @date_example = Date.today
    @shift = Shift.new
    respond_with(@shift)
  end

  def edit
  end

  def create
    @shift = Shift.new(shift_params)
    @shift.original_owner = @shift.user_id = current_user.id
    @shift.save
    respond_with(@shift)
  end

  def update
    @shift.update(shift_params)
    respond_with(@shift)
  end

  def destroy
    @shift.destroy
    respond_with(@shift)
  end

  private
    def set_shift
      @shift = Shift.find(params[:id])
    end

    def shift_params
      params.require(:shift).permit(:position, :date, :start, :finish, :description, :workflow_state, :shift_type)
    end
end
