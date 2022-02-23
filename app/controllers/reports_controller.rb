class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      flash[:success] = 'Send report successfully'
    else
      flash[:danger] = 'Send report fail'
    end
  end

  def block
    @user = User.find(params[:block_id])
    ReportMailer.block_notification(params[:block_id]).deliver_now
  end

  def search
    @result = Report.where(reported_id: params[:reported_id], reporter_id: params[:reporter_id])
  end

  private

  def report_params
    params.require(:report).permit(:reporter_id, :reported_id, :reason)
  end
end
