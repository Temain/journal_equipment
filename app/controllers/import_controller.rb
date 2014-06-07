class ImportController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def upload
    if request.xhr?
      respond_to do |format|
        @results = Equipment.import session, params[:import_file]
        format.js
      end
    end
  end

  def download
    @file = open("public/test.xls")
    send_file(@file, :filename => "test.xls")
  end
end
