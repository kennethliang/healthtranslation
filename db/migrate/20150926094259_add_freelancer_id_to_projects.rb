class AddFreelancerIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :freelancer_id, :integer
  end
end
