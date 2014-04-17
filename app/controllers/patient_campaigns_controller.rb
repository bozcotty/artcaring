class PatientCampaignsController < ApplicationController
  def index
    @patient_campaigns = PatientCampaign.all
  end

  def show
    @patient_campaign = PatientCampaign.find(params[:id])
  end

  def new
    @patient_campaign = PatientCampaign.new
    # @patient_campaign = current_user.patient_campaigns.new
    authorize! :create, PatientCampaign, message: "You need to sign up to create a Patient Campaign."
    # authorize! :create, @patient_campaign, message...
  end

  def create 
    @patient_campaign = current_user.patient_campaigns.new(params[:patient_campaign])
    authorize! :create, PatientCampaign, message: "You need to sign up to create a Patient Campaign."
    if @patient_campaign.save
      flash[:notice] = "Patient Campaign was saved successfully."
      redirect_to @patient_campaign
    else
      flash[:error] = "Error saving Patient Campaign, please try again."
      render :new
    end
  end


  def edit
    @patient_campaign = PatientCampaign.find(params[:id])
    authorize! :edit, @patient_campaign, message: "You need to own the Patient Campaign to edit it."
  end

  def update
    @patient_campaign = PatientCampaign.find(params[:id])
    authorize! :update, @patient_campaign, message: "You need to own the Patient Campaign to edit it."
    if @patient_campaign.update_attributes(params[:patient_campaign])
      redirect_to @patient_campaign, notice: "Your updates were saved successfully."
    else
      flash[:error] = "Error saving Patient Campaign changes. Please try again."
      render :edit
    end
  end

end
