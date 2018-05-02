class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bulletins, inverse_of: :user, dependent: :destroy
  has_many :topics, inverse_of: :user, dependent: :destroy
  has_many :replies, inverse_of: :user, dependent: :destroy
  has_many :tags, inverse_of: :user, dependent: :destroy
  has_many :bumps, inverse_of: :user, dependent: :destroy
end
