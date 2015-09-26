# == Schema Information
#
# Table name: documents
#
#  id                :integer          not null, primary key
#  project_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class Document < ActiveRecord::Base
  belongs_to :project
  has_attached_file :file

end
