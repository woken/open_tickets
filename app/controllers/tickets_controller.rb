class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :change_status]
  before_action :can_change, only: [:edit, :update, :change_status]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @comment = Comment.new
    @comment.pictures.new
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @ticket.pictures.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.created_by = current_user

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    @comment = Comment.new
    @ticket.attributes = ticket_params_for_change
    @ticket.change_status
    @ticket.save
    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def can_change
      render text: 'tickets closed', status: 403, layout: 'application' if @ticket.aasm_state == 'closed'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      _params = params.require(:ticket).permit(
        :notified_by_id,
        :title,
        :description,
        :company_id,
        tag_ids: [],
        pictures_attributes: [:id, :content, :_destroy]
      )
      _params = _params.except(:notified_by_id, :company_id) if @ticket.present? and @ticket.persisted?
      _params
    end

    def ticket_params_for_change
      params.require(:ticket).permit(:new_state, :issue_type_id).merge(action_user: current_user)
    end
end
