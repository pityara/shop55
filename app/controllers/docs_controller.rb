class DocsController < ApplicationController
  before_action :set_doc, only: [:show, :edit, :update, :destroy, :sign, :refuse, :match, :on_agree]
  before_action :set_on_match_docs
  before_action :is_signer, only: [:sign, :refuse]
  before_action :is_matcher, only: :match
  # GET /docs
  # GET /docs.json

  def on_agree
    @doc.update(agreed: false)
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

  def get_users
  end

  def my_docs
    @active = 3
    @my_docs = Doc.where(initiator: current_user)
  end

  def on_sign_docs
    @active = 2
    @osdocs = Doc.where(signer: current_user, signed: false, refused: false, agreed: true)
  end

  def on_match_docs
    @active = 4
  end

  def refuse
    @doc.update!(refused: true)
    @doc.logs += "Документу №#{@doc.number} отказано в подписи #{DateTime.now}.<br> Подписант: #{@doc.signer.name_with_initial} <br>"
    @doc.save
    redirect_to root_path, notice: "Документ будет направлен обратно инициатору!"
  end

  def match
    Match.find_by(doc_id: @doc.id, user_id: current_user.id).update(match: true)
    @doc.logs += "Документ №#{@doc.number} согласован с #{current_user.name_with_initial} #{DateTime.now}.<br>"
    @doc.save
    unless Match.where(doc_id: @doc.id, match: false).any?
      @doc.update(agreed: true)
      redirect_to root_path, notice: "Документ согласован, и отправлен на подпись"
    else
      redirect_to root_path, notice: "Документ согласован с вами, и ожидает согласование с другими людьми"
    end
  end

  def sign
    @doc.update!(signed: true, refused: false)
    @doc.logs += "Документ №#{@doc.number} подписан #{DateTime.now}.<br> Подписант: #{@doc.signer.name_with_initial} <br>"
    @doc.save
    redirect_to root_path, notice: "Документ успешно подписан!"
  end

  def index
    @active = 1
    @docs = Doc.all.order(:number)
  end

  # GET /docs/1
  # GET /docs/1.json
  def show
  end

  # GET /docs/new
  def new
    $matcherid = 0
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
    @doc.destination = User.first
    @doc.executor = User.first
    @doc.logs = "<br>Документ создан #{DateTime.now} <br> Инициатор документа: #{current_user.name_with_initial} <br> "
    respond_to do |format|
      if @doc.save
        if @doc.matchers.any?
          format.html { redirect_to @doc, notice: 'Документ успешно создан и отправлен на согласование, вы можете отслеживать его состояние во вкладке "Мои документы".' }
        else
          format.html { redirect_to @doc, notice: 'Документ успешно создан и отправлен на подпись, вы можете отслеживать его состояние во вкладке "Мои документы".' }
        end
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
    @doc.refused = false
    @doc.logs += "Документ отредактирован #{DateTime.now}. <br> Документ повторно отправлен на подпись #{@doc.signer.name_with_initial}<br>"
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
      format.html { redirect_to docs_url, notice: 'Документ был удалён' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def is_signer
      if current_user == @doc.signer
        true
      else
        false
        redirect_to root_path, notice: "Вы не имеете прав подписывать или отказывать в подписи этого документа"
        end
    end
    def set_doc
      @doc = Doc.find(params[:id])
    end

    def set_on_match_docs
      matches = Match.where(user_id: current_user, match: false)
      ids = []
      matches.each do |match|
        ids << match.doc_id
      end
        @omdocs = Doc.find(ids)
    end

    def is_matcher
      if Match.where(user_id: current_user.id, doc_id: @doc.id, match: false).any?
        true
      else
        false
        redirect_to root_path, notice: "Вы уже согласовывали этот документ или вас нет в списке согласующих!"
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def doc_params
      params.require(:doc).permit(:title, :text, :number, :logs, :signed, :agreed, :resolution, :done, :signer_id, :destination_id, :executor_id, :image, :matcher_ids => [])
    end
end
