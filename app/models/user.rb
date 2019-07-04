class User < ApplicationRecord
  before_validation :set_default_user_type

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable

  has_paper_trail ignore: [:current_sign_in_at, :last_sign_in_at,
                           :current_sign_in_ip, :last_sign_in_ip,
                           :sign_in_count, :confirmation_token,
                           :invitation_token, :unlock_token,
                           :encrypted_password], versions: {
    scope: -> {order("id desc")}
  }

  has_many :login_activities, as: :user # use :user no matter what your model name
  has_many :invitations, class_name: self.to_s, as: :invited_by
  belongs_to :user_type

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
    super && !deleted_at && !disabled
  end
  
  # provide a custom message for a deleted account
  def inactive_message
    if deleted_at
      :deleted_account
    elsif disabled
      :disabled_account
    else
      super
    end
  end

  private

  def set_default_user_type
    self.user_type ||= UserType.find_by_name('Patient')
  end
end
