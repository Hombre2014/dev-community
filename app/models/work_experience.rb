class WorkExperience < ApplicationRecord
  EMPLOYMENT_TYPE = ['Full-time', 'Part-time', 'Contract', 'Freelance', 'Internship', 'Apprenticeship', 'Trainee', 'Self-employed'].freeze
  LOCATION_TYPE = ['Remote', 'On-site', 'Hybrid'].freeze

  belongs_to :user

  validates :company, :start_date, :location, :job_title, presence: true
  validates :employment_type, presence: true, inclusion: { in: EMPLOYMENT_TYPE, message: "%{value} is not a valid employment type" }
  validates :location_type, presence: true, inclusion: { in: LOCATION_TYPE, message: "%{value} is not a valid location type" }

  validate :work_experience_last_date
  validate :presence_of_end_date
  validate :end_date_greater_than_start_date, if: :currently_working_here?

  def work_experience_last_date
    if end_date.present? && currently_working_here
      errors.add(:end_date, "Must be blank if you are currently working in this company.")
    end
  end

  def presence_of_end_date
    if end_date.nil? && !currently_working_here
      errors.add(:end_date, "Must be present if you are not currently working in this company.")
    end
  end

  def currently_working_here?
    !currently_working_here
  end

  def end_date_greater_than_start_date
    return if end_date.nil?

    if end_date < start_date
      errors.add(:end_date, "Must be greater than start date.")
    end
  end
end
