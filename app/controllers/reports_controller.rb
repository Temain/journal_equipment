class ReportsController < ApplicationController
  before_action :authenticate_user!

  def generate
    values = ["1","2","3"]
    report = ThinReports::Report.create layout: File.join(Rails.root, 'app', 'reports', 'test_report.tlf') do |r|
      values.each do |t|
        r.list.add_row do |row|
          row.item(:id1).value("row##{t}")
        end
      end
    end



    send_data report.generate, :filename    => 'test_report.pdf',
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
    #redirect_to controller: :import, action: :download, file_name: "test_report"
  end
end
