json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :notified_by_id, :created_by_id, :aasm_state, :title, :description, :closed_at
  json.url ticket_url(ticket, format: :json)
end
