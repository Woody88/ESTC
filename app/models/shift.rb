class Shift < ActiveRecord::Base
    belongs_to :user
    
     include Workflow
    
    workflow do
        state :new do
            event :post, :transitions_to => :posted
            event :trade_request, :transitions_to => :pending_request
        end
        
        state :posted do
            event :sold, :transitions_to => :traded
            event :cancel, :transitions_to => :new
        end
        
        state :pending_request do 
           event :accept, :transitions_to => :traded
           event :decline, :transitions_to => :new
        end
        state :traded do 
            event :post, :transitions_to => :posted
            event :trade_request, :transitions_to => :pending_request
        end
    end
    
    def calendar_start_time
        start.change(day: date.day, month: date.month, year: date.year)
    end
    
    def calendar_end_time
        finish.change(day: date.day, month: date.month, year: date.year)
    end
end
