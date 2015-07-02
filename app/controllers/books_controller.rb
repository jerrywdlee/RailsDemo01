class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
    p "----------------"
    p params[:page]
    p "----------------"
    # must be the same object selected
    @books = Book.page(params[:page])
    p @books

    respond_to do |format|
      format.html
      format.json { render json: BookDatatable.new(view_context) }
    end
  end

  def index2
   #@genres = Book.select("genre").distinct
   #@genres = Book.select("genre")
   
   @genres = Book.group(:genre).count
#to count as => {"資格"=>2, "漫画"=>2, "随筆"=>1, "社会"=>1}
   #this is like [["資格", 2]["漫画",2]["随筆",1]["社会",1]]
   @book_sum = Book.all.count
   @genre_sum = Book.distinct.count("genre")

   # data for drawing graph
   #@chart_data = Book.group(:genre).count
   # move to private method


   #if ajax is on
   ajax_action(@chart_data) if request.xhr?

    #index2 to list genre
    #@books = Book.all
    #render :text => params
  end
  
  # to search books by genre
  def genre
    #render :text => params
    @gen = params[:ggg]
    @books = Book.where("genre = ? ",@gen)
    #@gen = params[:ggg]
  end


  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # draw graph by ajax
  def ajax_action(data)
    #ajax actions
    @chart_data = Book.group(:genre).count
    if @chart_data.size > 0
      #render json: data.to_json
      #render js: "$('#graph').html('<p>aaa</p>')"
      render "draw.js.erb"
    else
      render js: "alert('No Data to Show!')"
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :publisher, :isbn, :genre, :useable, :summary)
    end
end
