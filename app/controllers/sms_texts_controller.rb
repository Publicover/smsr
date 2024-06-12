# frozen_string_literal: true

class SmsTextsController < ApplicationController
  before_action :set_sms_text, except: [:index, :create]

  def index
    @sms_texts = policy_scope(SmsText)
    authorize @sms_texts
    serialized_response(@sms_texts)
  end

  def show
    serialized_response(@sms_text)
  end

  def create
    @sms_text = SmsText.new(sms_text_params)
    authorize @sms_text
    if @sms_text.save
      serialized_response(@sms_text, :created)
    else
      render json: @sms_text.errors, status: :unprocessable_entity
    end
  end

  def update
    if @sms_text.update(sms_text_params)
      serialized_response(@sms_text)
    else
      render json: @sms_text.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @sms_text.destroy
      serialized_response(@sms_text)
    else
      render json: @sms_text.errors, status: :unprocessable_entity
    end
  end

  private

    def set_sms_text
      @sms_text = SmsText.find(params[:id])
      authorize @sms_text
    end

    def sms_text_params
      params.require(:sms_text).permit(policy(SmsText).permitted_attributes)
    end
end
