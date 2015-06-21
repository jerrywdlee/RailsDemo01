json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :publisher, :isbn, :genre, :useable, :summary
  json.url book_url(book, format: :json)
end
