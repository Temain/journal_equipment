class ImportController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def upload
    Equipment.import params[:import_file]
    redirect_to :download
  end

  def download
    @file = open("public/test.xls")
    send_file(@file, :filename => "test.xls")
   # render nothing: true
  end
end
