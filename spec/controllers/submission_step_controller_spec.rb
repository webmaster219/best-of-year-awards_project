require 'spec_helper'

describe SubmissionStepController do
	
	describe "GET 'agree_terms'" do
    it "returns http success" do
      get 'agree_terms'
      response.should be_success
    end
  end
end
