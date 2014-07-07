class PaymentNotificationsController < ApplicationController

  protect_from_forgery except: [:create]


  def create
    PaymentNotification.create!(payment_notification_params)

    render nothing: true
  end


  private

    def payment_notification_params
      params.require(:payment_notification).permit(params: params, cart_id: params[:cart_id], status: params[:payment_status], transaction_id: params[:txn_id])
    end
end
