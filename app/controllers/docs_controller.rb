class DocsController < ApplicationController
  before_action :set_doc, only: [:show, :edit, :update, :destroy, :sign, :refuse]

  # GET /docs
  # GET /docs.json

  def on_sign_docs
    @active = 2
    @osdocs = Doc.where(signer: current_user, signed: false, refused: false)
  end

  def refuse
    @doc.update!(refused: true)
    @doc.logs += "Документу №#{@doc.number} отказано в подписи #{DateTime.now}.\n Подписант: #{@doc.signer.name} \n"
    @doc.save
    redirect_to root_path, notice: "Документ будет направлен обратно инициатору!"
  end
  def sign
    @doc.update!(signed: true)
    @doc.logs += "Документ №#{@doc.number} подписан #{DateTime.now}.\n Подписант: #{@doc.signer.name} \n"
    @doc.save
    redirect_to root_path, notice: "Документ успешно подписан!"
  end

  def index
    @active = 1
    @docs = Doc.all
  end

  # GET /docs/1
  # GET /docs/1.json
  def show
  end

  # GET /docs/new
  def new
    @doc = Doc.new
  end

  # GET /docs/1/edit
  def edit
  end

  # POST /docs
  # POST /docs.json
  def create
    @doc = Doc.new(doc_params)
    @doc.initiator = User.find(session[:user_id])
    @doc.logs = "Документ создан #{DateTime.now} \n Инициатор документа: #{current_user.name} \n "
    respond_to do |format|
      if @doc.save
        format.html { redirect_to @doc, notice: 'Doc was successfully created.' }
        format.json { render :show, status: :created, location: @doc }
      else
        format.html { render :new }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /docs/1
  # PATCH/PUT /docs/1.json
  def update
    respond_to do |format|
      if @doc.update(doc_params)
        format.html { redirect_to @doc, notice: 'Doc was successfully updated.' }
        format.json { render :show, status: :ok, location: @doc }
      else
        format.html { render :edit }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docs/1
  # DELETE /docs/1.json
  def destroy
    @doc.destroy
    respond_to do |format|
      format.html { redirect_to docs_url, notice: 'Doc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc
      @doc = Doc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doc_params
      params.require(:doc).permit(:title, :text, :number, :logs, :signed, :agreed, :resolution, :done, :signer_id, :destination_id, :executor_id, :image)
    end
end
