class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :shifts

  def available?(trade_shift)
        @shift = self.shifts.where(date: trade_shift.date).first
        if !@shift.nil?
            if @shift.overlaps?(trade_shift)
                return false
            else
                return true
            end
        else 
            return true
        end
    end
    
end
