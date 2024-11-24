class ExpertsController < ApplicationController
  before_action :set_expert, only: %i[show edit update destroy]

  def index
    @experts = Expert.apply_filters(params)
  end

  # GET /experts/1 or /experts/1.json
  def show
  end


    def new
      # Yeni bir Expert nesnesi oluşturuyoruz
      @expert = Expert.new
  
      # JSON dosyasını okuyoruz ve veriyi @countries değişkenine yüklüyoruz
      file = File.read(Rails.root.join('public', 'countries.json'))
      @countries = JSON.parse(file)
    end
 
  
  

  # GET /experts/1/edit
  def edit
  end

  # POST /experts or /experts.json
  def create
    # Ülke kodu ve telefon numarasını birleştir
    full_phone_number = "#{params[:expert][:country_code]}#{params[:expert][:telefon_number]}"

    # Yeni expert oluşturma
    @expert = Expert.new(expert_params)
    @expert.telefon_number = full_phone_number  # Birleştirilen telefon numarasını atıyoruz

    respond_to do |format|
      if @expert.save
        format.html { redirect_to @expert, notice: "Expert was successfully created." }
        format.json { render :show, status: :created, location: @expert }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experts/1 or /experts/1.json
  def update
    respond_to do |format|
      if @expert.update(expert_params)
        format.html { redirect_to @expert, notice: "Expert was successfully updated." }
        format.json { render :show, status: :ok, location: @expert }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experts/1 or /experts/1.json
  def destroy
    @expert.destroy!

    respond_to do |format|
      format.html { redirect_to experts_path, status: :see_other, notice: "Expert was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expert
    @expert = Expert.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expert_params
    params.require(:expert).permit(
      :first_name, :last_name, :academic_title, :location, :salutation, 
      :salary, :travel_willingness, :natinality, :image, :other, :biography, 
      :email, :communicationlanguage, :pdf_file, category_ids: []
    )
  end
end
