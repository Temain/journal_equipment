class ReportsController < ApplicationController
  before_action :authenticate_user!

  def report_by_department
    @equipment = Equipment.search_by_department(params[:department_id].first, params[:start_date], params[:end_date])
    count = @equipment.count
    report = ThinReports::Report.create layout: File.join(Rails.root, 'app', 'reports', 'report_by_department.tlf') do |r|
      r.start_new_page do |page|
        page.values department: Department.find(params[:department_id]).first.name,
                 start_date: params[:start_date],
                 end_date: params[:end_date]

        @equipment.each_with_index do |eq, index|
          puts eq.inventory_number
          page.list(:list).add_row do |row|
            row.values number: "#{index + 1}.",
                       equipment: eq.full_name,
                       inventory_number: eq.inventory_number,
                       action_date: eq.journal_records.where(journalable_type: 'Repair').last.action_date.strftime('%d.%m.%Y')
          end
        end
      end

    end

    send_data report.generate, :filename    => 'report_by_department.pdf',
                               :type        => 'application/pdf',
                               :disposition => 'attachment'
  end

  def report_by_spare
  end

end
