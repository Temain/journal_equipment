class HistoryController < ApplicationController
  before_action :authenticate_user!

  def show
    @journal_records = JournalRecord.all
  end
end
