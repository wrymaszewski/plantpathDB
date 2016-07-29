class SequenceAttachmentsController < ApplicationController
  before_action :set_sequence, only: [:show, :edit, :update, :destroy, :new, :create, :index]
  before_action :set_sequence_attachment, only: [:show, :edit, :update, :destroy]

  # GET /sequence_attachments/new
  def new
    @sequence_attachment = @sequence.sequence_attachments.new
  end

  # GET /sequence_attachments/1/edit
  def edit
  end

  # POST /sequence_attachments
  # POST /sequence_attachments.json
  def create
    @sequence_attachment = @sequence.sequence_attachments.new(sequence_attachment_params)

    respond_to do |format|
      if @sequence_attachment.save
        format.html { redirect_to @sequence, notice: 'Sequence attachment was successfully created.' }
        format.json { render :show, status: :created, location: @sequence }
      else
        format.html { render :new }
        format.json { render json: @sequence_errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sequence_attachments/1
  # PATCH/PUT /sequence_attachments/1.json
  def update
    respond_to do |format|
      if @sequence_attachment.update(sequence_attachment_params)
        format.html { redirect_to @sequence, notice: 'Sequence file was successfully uploaded.' }
      end
    end
  end

  # DELETE /sequence_attachments/1
  # DELETE /sequence_attachments/1.json
  def destroy
    @sequence_attachment.destroy
    respond_to do |format|
      format.html { redirect_to @sequence, notice: 'Sequence attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_file
    @sequence = Sequence.find(params[:sequence_id])
    @sequence_attachment = SequenceAttachment.find(params[:id])
    send_file(@sequence_attachment.file.path,
          :disposition => 'attachment',
          :url_based_filename => false,
          :filename => @sequence_attachment.file_identifier.to_s)
   end

   def view_file
    @sequence = Sequence.find(params[:sequence_id])
    @sequence_attachment = SequenceAttachment.find(params[:id])
    send_file(@sequence_attachment.file.path,
          :disposition => 'inline',
          :url_based_filename => false,
          :filename => @sequence_attachment.file_identifier.to_s)
   end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sequence_attachment
      @sequence_attachment = SequenceAttachment.find(params[:id])
    end

    def set_sequence
      @sequence = Sequence.find(params[:sequence_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sequence_attachment_params
      params.require(:sequence_attachment).permit(:sequence_id, :sequence_type, :comment, :file)
    end
end
