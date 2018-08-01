class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    #if params[:set_locale]
      #redirect_to store_url(locale: params[:set_locale])
    #else
      @items = Item.all
    #end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def search
     
     if params[:nombre].present?
       @search_term = params[:nombre]
       @items = Item.where("title like ?", "%#{params[:nombre]}%",)
     elsif params[:categoria].present?
       @search_term = params[:categoria]
       @items = Item.where("category like ?", "%#{params[:categoria]}%" )
     elsif params[:skill].present?
       @search_term = params[:skill]
       @items = Item.where("skill_level like ?", "%#{params[:skill]}%")
     elsif params[:precio].present?
       @search_term = params[:precio]
        @items = Item.where("price between ? AND ?", "#{params[:precio]}".split('-')[0], "#{params[:precio]}".split('-')[1] )
     end
     
      # @items = Item.where("title like ? or category like ? or skill_level like ? or price between ? AND ?", 
      # "%#{params[:nombre]}%", "%#{params[:categoria]}%", "%#{params[:skill]}%",
      # "#{params[:precio]}".split('-')[0], "#{params[:precio]}".split('-')[1] )
     
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :description, :lecturer, :price, :image_url, :category, :skill_level)
    end
end
