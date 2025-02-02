class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      head :not_found
      return
    end
  end
  
  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Work added successfully"

      redirect_to work_path(@work.id)
    else
      flash.now[:warning] = "A problem occurred: Could not create #{@work.category}"#
      render new_work_path
    end
  end

  def edit
    id = params[:id].to_i
    @work = Work.find_by(id: id)

    # if @work == nil
    #   redirect_to work_path
    # end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render new_work_path
    end
  end

  def destroy
    the_correct_work = Work.find_by( id: params[:id] )

    if the_correct_work.nil?
      flash.now[:warning] = "Could not delete work."
      redirect_to works_path
    else
      the_correct_work.destroy
      flash[:success] = "Successfully destroyed #{the_correct_work.category} #{the_correct_work.id}"
      redirect_to root_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
