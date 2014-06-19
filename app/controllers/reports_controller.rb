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
    @spare = Spare.find_by_name(params[:spare])
    if @spare
      report = ThinReports::Report.create layout: File.join(Rails.root, 'app', 'reports', 'report_by_spare.tlf') do |r|
        r.start_new_page do |page|
          page.values title: "Список оборудования с замененной деталью #{ @spare.name }"

          @spare.repairs.each_with_index do |repair, index|
            page.list(:list).add_row do |row|
              row.values number: "#{index + 1}.",
                         equipment: repair.journal_record.equipment.full_name,
                         department: repair.journal_record.equipment.department.name,
                         inventory_number: repair.journal_record.equipment.inventory_number,
                         date: repair.journal_record.action_date.strftime('%d.%m.%Y')
            end

          end
        end
      end

      send_data report.generate, :filename    => 'report_by_spare.pdf',
                :type        => 'application/pdf',
                :disposition => 'attachment'
    end
  end

end
