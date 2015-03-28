class TradeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shift, only: [:trade_request, :send_request, :accept_shift, :decline_shift]
  
  def trade_request
   
  end
  
  def send_request
    @user_shift = User.find(params[:shift][:tr_user_id])
    if @user_shift.available?(@shift)
        if @shift.update(shift_params) && @shift.trade_request!
        flash[:notice] = 'Trade request succesfully sent to #{@user.email}'
        redirect_to calendar_path
        else 
        flash[:alert] = 'Request could not be sent!'
        redirect_to @shift
        end
       
    else
    
      flash[:alert] = 'This collegue is unable to work of you.'
      redirect_to trade_request_path
    end
  
  end
  
  def pending_request
     @shifts = current_user.shifts.with_pending_request_state
  end
  
  def incoming_trade_request
    @shifts = Shift.with_pending_request_state.where(tr_user_id: current_user.id)
  end
  
  
  def accept_shift
    
    if current_user.available?(@shift)
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
        
    else
        flash[:alert] = "#{current_user.email} are already working that day."
        redirect_to shift_trade_board_path
    end
    
  end
  
  def decline_shift
    @shift.tr_user_id = nil
    flash[:notice] = 'Request successfully declined.' if @shift.save && @shift.decline!
    redirect_to pending_request_path

  end
  
  private
  
    def set_shift
      @shift = Shift.find(params[:id])
    end
    
    def shift_params
      params.require(:shift).permit(:position, :date, :start, :finish, :description, :workflow_state, :tr_user_id)
    end
end
