class ReportsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :xml, :pdf

  def report_by_department
    #@list = Equipment.search_by_department(params[:department_id].first, params[:start_date], params[:end_date])
    #respond_with @list

    @departments = Department.all
    respond_with @departments
    #report = ThinReports::Report.create layout: File.join(Rails.root, 'app', 'reports', 'report_by_department.tlf') do |r|
    #  @equipment.each_with_index do |eq, index|
    #    r.list(:list).add_row do |row|
    #      row.values number: "#{index + 1}.",
    #                 equipment: eq.full_name,
    #                 inventory_number: eq.inventory_number
    #    end
    #  end
    #end
    #
    #dep = Department.find(params[:department_id]).first.name
    #report.page.values department: dep,
    #                   start_date: params[:start_date],
    #                   end_date: params[:end_date]
    #
    #send_data report.generate, :filename    => 'report_by_department.pdf',
    #                           :type        => 'application/pdf',
    #                           :disposition => 'attachment'
    #redirect_to controller: :import, action: :download, file_name: "test_report"
  end

end
