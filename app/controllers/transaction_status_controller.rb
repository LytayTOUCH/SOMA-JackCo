class TransactionStatusController < ApplicationController
  def index
    begin
      @transaction_status = TransactionStatus.new

      if params[:transaction_status] and params[:transaction_status][:name] and !params[:transaction_status][:name].nil?
        @transaction_statuses = TransactionStatus.find_by_transaction_name(params[:transaction_status][:name]).page(params[:page]).per(5)
      else
        @transaction_statuses = TransactionStatus.page(params[:page]).per(5)
      end
    rescue Exception => e
      puts e
    end
  end

end
