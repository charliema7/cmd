class InvitationsController < ApplicationController
  def index
    @pending_users = User.invitation_not_accepted
    @accepted_users = User.invitation_accepted
  end
end
