class Book < ActiveRecord::Base
	validates_presence_of :isbn #, :useable
end
