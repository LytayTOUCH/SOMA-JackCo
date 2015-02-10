class TransactionStatusController < ApplicationController
  def index
    begin
      @tran_status = TransactionStatus.new

      if params[:tran_status] and params[:tran_status][:name] and !params[:tran_status][:name].nil?
        @transaction_status = TransactionStatus.find_by_name(params[:tran_status][:name]).page(params[:page]).per(5)
      else
        @transaction_status = TransactionStatus.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

end
