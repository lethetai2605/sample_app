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
    @user = User.find(params[:id])
    lock_time = 15.days.from_now
    puts lock_time
    @user.update(lock_time: lock_time)
    ReportMailer.block_notification(@user).deliver_now
    redirect_to request.referrer
  end

  def search
    @reports = Report.where(reported_id: params[:reported_id], reporter_id: params[:reporter_id])
    render 'index'
  end

  def read_report
    @reported = Report.find(params[:id])
    @reported.update(is_read: true)
    redirect_to request.referrer
  end
  private

  def report_params
    params.require(:report).permit(:reporter_id, :reported_id, :reason)
  end
end
