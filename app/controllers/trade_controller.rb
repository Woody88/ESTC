class TradeController < ApplicationController
  before_action :set_shift, only: [:trade_request, :send_request, :accept_shift]
  
  def trade_request
   
  end
  
  def send_request
    if @shift.update(shift_params) && @shift.trade_request!
       @user = User.select(:email).find(@shift.tr_user_id)
      flash[:notice] = 'Trade request succesfully sent to #{@user.email}'
      redirect_to calendar_path
    else 
      flash[:alert] = 'Request could not be sent!'
      redirect_to @shift
    end
    
  end
  
  
  def incoming_trade_request
    @shifts = Shift.with_pending_request_state.where(tr_user_id: current_user.id)
  end
  
  
  def accept_shift
    @user_shift = current_user.shifts.where(date: @shift.date).first
    
    if @user_shift.nil?
        @user_shift = @shift
        @user_shift.user_id = current_user.id
        @user_shift.tr_user_id = nil
        if @shift.save && @shift.accept!
            flash[:notice] = 'Shift successfully traded.' 
            redirect_to calendar_path
        else
            flash[:alert] = "Shift Could not be Traded"
             redirect_to incoming_trade_request_path
        end
    end
  end
  
  private
  
    def set_shift
      @shift = Shift.find(params[:id])
    end
    
    def shift_params
      params.require(:shift).permit(:position, :date, :start, :finish, :description, :workflow_state, :tr_user_id)
    end
end
