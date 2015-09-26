# == Schema Information
#
# Table name: projects
#
#  id               :integer          not null, primary key
#  name             :string
#  project_type     :string
#  from_language_id :integer
#  to_language_id   :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :documents
  belongs_to :from_language, class_name: 'Language'
  belongs_to :to_language, class_name: 'Language'

  enum status: [:pending, :created, :posted, :failed_to_post, :employee_invited, :failed_to_invite, :processing, :finished, :failed]
  enum project_type: [:transcription, :translation, :transcription_and_translation]

  validates :name, :project_type, :from_language_id, :to_language_id, :user_id, presence: true, unless: :pending?

  before_save :handle_status_change

  def to_s
    name
  end

  def self.check_status

  end

  private

  def handle_status_change
    if created?
      send_to_freelancer
    end
  end

  def send_to_freelancer
    response = Medscribe::FreelancerRequestor.instance.create_new_project(project_data)
    if response.success?
      self.status = :posted
      self.freelancer_id = response.payload['id']
      invite_employee
    else
      self.status = :failed_to_post
    end
  end

  def invite_employee
    response = Medscribe::FreelancerRequestor.instance.invite_to_project(self, employee_data)
    if response.success?
      self.status = :employee_invited
    else
      self.status = :failed_to_invite
    end
  end

  def employee_data
    {
        freelancer_id: Employee.first.freelancer_id
    }
  end

  def project_data
    {
        title: name,
        description: 'Another Medscribe project.',
        # owner_id: 8222390, # Don't need owner_id
        currency: {
            id: 1
        },
        budget: {
            minimum: 100,
            maximum: 100
        },
        jobs: [
            {
                id: 10 # Translation and language
            }
        ]
    }
  end

end
