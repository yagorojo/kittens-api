class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save 
      flash[:notice] = "#{@kitten.name} added!"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity, notice: "Damn you dumb!"
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:notice] = "#{@kitten.name} edited!"
      redirect_to @kitten
    else
      render :edit, status: :unprocessable_entity, notice: "Damn you dumb!"
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    redirect_to root_path, status: :see_other, notice: "Kitten deleted!"
  end

  private
    def kitten_params
      params.require(:kitten).permit(
        :name,
        :age,
        :cuteness,
        :softness
      )
    end
end
