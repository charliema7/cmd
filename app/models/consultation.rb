class Consultation < ApplicationRecord
  belongs_to :user

  after_create :broadcast_create
  after_update :broadcast_update
  after_destroy :broadcast_destroy

  def broadcast_create
    ActionCable.server.broadcast 'consultation_channel', action: "create",
                                                           html: render_consultation(self)
  end

  def broadcast_update
    ActionCable.server.broadcast 'consultation_channel', action: "update",
                                                             id: self.id,
                                                           html: render_consultation(self)
  end

  def broadcast_destroy
    ActionCable.server.broadcast 'consultation_channel', action: "destroy", 
                                                             id: self.id
  end

  private

    def render_consultation(consultation)
      ApplicationController.render(partial: 'consultations/consultation', locals: { consultation: self })
    end

end
