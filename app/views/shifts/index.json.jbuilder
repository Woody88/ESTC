json.array!(@shifts) do |shift|
  json.title shift.position
  json.start shift.calendar_start_time
  json.end shift.calendar_end_time
  json.description shift.description
  json.state shift.workflow_state
  json.url shift_url(shift, format: :html)
end
