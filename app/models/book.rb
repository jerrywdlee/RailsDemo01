class Book < ActiveRecord::Base
  validates_presence_of :isbn #, :useable
  paginates_per 5  # 1ページあたり5項目表示     
end
