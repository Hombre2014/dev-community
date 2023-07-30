# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :work_experiences

  PROFILE_TITLE = [
    'Senior Ruby on Rails Developer',
    'Mid-level Ruby on Rails Developer',
    'Full Stack Ruby on Rails Developer',
    'Ruby on Rails Developer',
    'Junior Ruby on Rails Developer',
    'Senior React Developer',
    'Mid-level React Developer',
    'Front End React Developer',
    'Back End Ruby Engineer',
    'Senior Ruby Engineer'
  ].freeze

  def name
    "#{first_name} #{last_name}".strip
  end

  def address
    "#{city}, #{state}, #{country}, #{postcode}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[country city]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
