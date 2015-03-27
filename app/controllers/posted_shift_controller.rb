class PostedShiftController < ApplicationController
   before_action :set_shift, only: [:cancel_shift, :pick_up_shift]
  def index
    @shifts = Shift.with_posted_state.includes(:user)
    
  end
  
  def post_shift
    @shift = Shift.find(params[:sid])
    flash[:notice] = 'Shift successfully Posted.'if @shift.post!
    redirect_to shift_trade_board_path
  end
  
  def cancel_shift
     flash[:notice] = 'Shift successfully removed from board.' if @shift.cancel!
     redirect_to shift_trade_board_path
  end
  
  def pick_up_shift
    @user_shift = current_user.shifts.where(date: @shift.date).first
    if @user_shift.nil?
        @user_shift = @shift
        @user_shift.user_id = current_user.id
        if @shift.save && @shift.sold!
            flash[:notice] = 'Shift successfully traded.' 
            redirect_to calendar_path
        else
            flash[:alert] = "Shift Could not be Traded"
             redirect_to shift_trade_board_path
        end
    end
  end
  
   private
    def set_shift
      @shift = Shift.find(params[:id])
    end
  
end
