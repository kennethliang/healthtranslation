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

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
