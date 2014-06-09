class ImportController < ApplicationController
  before_action :authenticate_user!

  def index
    @dark_page = true
  end

  def upload
    if request.xhr?
      respond_to do |format|
        @results = Equipment.import session, params[:import_file]
        format.js
      end
    end
  end

  def format
    if request.xhr?
      respond_to do |format|
        Equipment.format params[:import_file]
        format.js #{ redirect_to download_path("formated") }
      end
    end
  end

  def download
    @file = open("public/#{params[:file_name]}.xls")
    send_file(@file, :filename => "#{params[:file_name]}.xls")
  end
end