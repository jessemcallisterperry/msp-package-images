class GeneratedThumbnailsController < ApplicationController
  before_action :set_generated_thumbnail, only: %i[ show edit update destroy ]

  # GET /generated_thumbnails or /generated_thumbnails.json
  def index
    @generated_thumbnails = GeneratedThumbnail.all
  end

  # GET /generated_thumbnails/1 or /generated_thumbnails/1.json
  def show
  end

  # GET /generated_thumbnails/new
  def new
    @generated_thumbnail = GeneratedThumbnail.new
  end

  # GET /generated_thumbnails/1/edit
  def edit
  end

  # POST /generated_thumbnails or /generated_thumbnails.json
  def create
    @generated_thumbnail = GeneratedThumbnail.new
    if params[:generated_thumbnail][:sketch]
      @generated_thumbnail.sketch.attach(params[:generated_thumbnail][:sketch])
    end
    if @generated_thumbnail.save
      redirect_to @generated_thumbnail
    else
      render :new
    end
  end

  # PATCH/PUT /generated_thumbnails/1 or /generated_thumbnails/1.json
  def update
    respond_to do |format|
      if @generated_thumbnail.update(generated_thumbnail_params)
        format.html { redirect_to @generated_thumbnail, notice: "Generated thumbnail was successfully updated." }
        format.json { render :show, status: :ok, location: @generated_thumbnail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @generated_thumbnail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /generated_thumbnails/1 or /generated_thumbnails/1.json
  def destroy
    @generated_thumbnail.destroy!

    respond_to do |format|
      format.html { redirect_to generated_thumbnails_path, status: :see_other, notice: "Generated thumbnail was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_generated_thumbnail
      @generated_thumbnail = GeneratedThumbnail.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def generated_thumbnail_params
      params.fetch(:generated_thumbnail, {})
    end
end
