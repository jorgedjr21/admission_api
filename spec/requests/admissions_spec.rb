# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students', type: :request do
  let!(:admissions) { create_list(:admission, 5) }

  describe 'GET /admissions' do
    it 'must return all admissions' do
      get api_v1_admissions_path
      expect(response.body).to eq(admissions.to_json)
    end

    it 'must have status code 200' do
      get api_v1_admissions_path
      expect(response).to have_http_status(200)
    end
  end
end
