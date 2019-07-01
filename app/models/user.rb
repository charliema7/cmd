class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  has_many :login_activities, as: :user # use :user no matter what your model name
  has_many :invitations, class_name: self.to_s, as: :invited_by

  validates :first_name, :last_name, presence: true, if: :invite_accepted?

  def invite_accepted?
    invitation_accepted_at != nil
  end

  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end
  
  # ensure user account is active  
  def active_for_authentication?
    super && !deleted_at
  end
  
  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
end
