class CalendarController < ApplicationController
  before_action :authenticate_user!
  def index
    @shift = Shift.new
  end
end
