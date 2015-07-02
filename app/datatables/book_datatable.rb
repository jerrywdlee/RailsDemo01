class BookDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Book.title Book.isbn Book.genre Book.id)
    # this is equal to:
    # @sortable_columns ||= ['Book.title','Book.isbn','Book.genre']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Book.title Book.isbn Book.genre)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.title,
        record.isbn,
        record.genre,
        record.id
      ]
    end
  end

  def get_raw_records
    # insert query here
    Book.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
