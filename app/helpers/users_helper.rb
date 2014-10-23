module UsersHelper

  def print_status(user, before = '-')
    status = nil

    # If user is invited but not yet accepted, status = 'invitation sent [time ago]'
    if user.invitation_sent_at && user.invitation_accepted_at.blank?
      status = "invitation-sent"
    # If user has accepted invitation but hasn't signed in, status = 'invitation accepted'
    elsif user.invitation_accepted_at && user.last_sign_in_at.blank?
      status = "invitation-accepted"
    end

    content_tag(:span, :class => status) do
      before + " " + status.gsub('-', ' ') if status
    end
  end
end
