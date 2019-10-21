class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: true

  def self.alpha_order
    return Work.all.order(title: :asc)
  end
  
  def self.spotlight
    works = self.all
    return works.max_by { |work| work.votes.length }
    # works = self.all
    # return works.select { |work| work.votes.max }.first

    # works_array = works.select { |work| work.votes.max }
    # return works_array.first
  end

  def self.top_ten(category)
    Work.where(category: category).sort_by { |work| -work.votes.length }.first(10)
  end

  # def upvote
  #   unless session[:user_id]
  #     flash[:error] = "You must be logged in to vote!"
  #     redirect_to root_path
  #     return
  #   end
  #   # current_user = User.find_by(id: params[:user_id])
  #   work = Work.find_by(id: params[:work_id])
  #   session[:user_id] = params[:user_id] #current_user.id
  #   vote_params = Vote.create(date_voted: Date.today, work_id: work.id, user_id: session[:user_id])
  #   return vote_params
  # end
end

