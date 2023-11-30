# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable, authentication_keys: [:login]

  has_many :work_experiences, dependent: :destroy
  has_many :connections, dependent: :destroy

  validates :first_name, :last_name, :profile_title, presence: true
  validates :username, presence: true, uniqueness: true

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

  attr_writer :login

  def login
    @login || username || email
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def address
    return nil if country.blank? && city.blank? && state.blank? && postcode.blank?
    "#{city}, #{state}, #{country}, #{postcode}"
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[country city]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  def my_connection(user)
    Connection.where("(user_id = ? AND connected_user_id = ?) OR (user_id = ? AND connected_user_id = ?)", user.id, id, id, user.id)
  end

  def check_if_already_connected?(user)
    self != user && !my_connection(user).present?
  end

  def mutually_connected_ids(user)
    self.connected_user_ids.intersection(user.connected_user_ids)
  end
end
