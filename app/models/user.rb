class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  PROFILE_TITLE = [
  'Senior Ruby on Rails Developer',
  'Mid-level Ruby on Rails Developer',
  'Full Stack Ruby on Rails Developer',
  'Ruby on Rails Developer',
  'Junior Ruby on Rails Developer',
  'Senior React Developer',
  ].freeze
end
