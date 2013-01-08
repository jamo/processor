class SubmissionFilesController < ApplicationController
  # GET /submission_files
  # GET /submission_files.json
  def index
    @submission_files = SubmissionFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submission_files }
    end
  end

  # GET /submission_files/1
  # GET /submission_files/1.json
  def show
    @submission_file = SubmissionFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @submission_file }
    end
  end

  # GET /submission_files/new
  # GET /submission_files/new.json
  def new
    @submission_file = SubmissionFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @submission_file }
    end
  end

  # GET /submission_files/1/edit
  def edit
    @submission_file = SubmissionFile.find(params[:id])
  end

  # POST /submission_files
  # POST /submission_files.json
  def create
    @submission_file = SubmissionFile.new(params[:submission_file])

    respond_to do |format|
      if @submission_file.save
        format.html { redirect_to @submission_file, notice: 'Submission file was successfully created.' }
        format.json { render json: @submission_file, status: :created, location: @submission_file }
      else
        format.html { render action: "new" }
        format.json { render json: @submission_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /submission_files/1
  # PUT /submission_files/1.json
  def update
    @submission_file = SubmissionFile.find(params[:id])

    respond_to do |format|
      if @submission_file.update_attributes(params[:submission_file])
        format.html { redirect_to @submission_file, notice: 'Submission file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @submission_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submission_files/1
  # DELETE /submission_files/1.json
  def destroy
    @submission_file = SubmissionFile.find(params[:id])
    @submission_file.destroy

    respond_to do |format|
      format.html { redirect_to submission_files_url }
      format.json { head :no_content }
    end
  end
end
