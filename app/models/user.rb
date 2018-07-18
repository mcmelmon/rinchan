class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bulletins, inverse_of: :user, dependent: :destroy
  has_many :topics, inverse_of: :user, dependent: :destroy
  has_many :objections, inverse_of: :user, dependent: :destroy
  has_many :replies, inverse_of: :user, dependent: :destroy
  has_many :tags, inverse_of: :user, dependent: :destroy
  has_many :bumps, inverse_of: :user, dependent: :destroy
  has_many :thanks, inverse_of: :user, dependent: :destroy
  has_many :demurrals, inverse_of: :user, dependent: :destroy

  validates_uniqueness_of :email
  validate :only_one_guest

  scope :civilians, -> { where(editor: false) }
  scope :editors, -> { where(editor: true) }

  def self.guest
    User.find_by(name: 'guest')
  end

  def active_for_authentication?
    super and self.is_active?
  end

  private
    def only_one_guest
      if name == 'guest' && User.find_by(name: 'guest').present?
        errors.add(:name, 'that name is not available')
      end
    end
end
