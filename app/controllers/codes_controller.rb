# typed: ignore

class CodesController < ApplicationController
  before_action :render_forbidden_if_not_admin, only: %i[create destroy]

  def create
    @code = Code.new(code_params)
    @form_id = params[:code][:form_id]
    @button_id = params[:code][:button_id]
    @list_id = params[:code][:list_id]

    respond_to do |format|
      if @code.save
        format.js {}
      end
    end
  end

  def destroy
    @code = Code.find(params[:id])
    respond_to do |format|
      if @code.destroy
        format.js {}
      end
    end
  end

  private

  def code_params
    code_params = T.cast(params.require(:code), ActionController::Parameters)
    code_params.permit(:user_id, :reference_id, :reference_type, :body)
  end
end
