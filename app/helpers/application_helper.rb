# frozen_string_literal: true

module ApplicationHelper
  def get_connection_status(current_user, user)
    current_user.connections.find_by(connected_user_id: user.id).status
  end
end
