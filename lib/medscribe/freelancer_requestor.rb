module Medscribe
  class FreelancerRequestor

    include Singleton

    def client
      @client ||= Freelancer::Api::Client.new(Rails.application.secrets.freelancer_token)
    end

    def create_new_project(data)
      client.request('projects/0.1/projects', :get, data)
    end

    def invite_to_project(project, data)
      client.request("projects/0.1/projects/#{project.freelancer_id}/invite", :post, data)
    end

  end
end