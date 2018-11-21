# frozen_string_literal: true

module Api
  module V1
    class AdmissionsController < ApplicationController

      def index
        json_response(Admission.all)
      end

    end
  end
end
