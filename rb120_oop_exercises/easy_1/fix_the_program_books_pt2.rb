class Book
  attr_accessor :author, :title

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
p book.author # #=> `nil` : Further exploration: if you forget to set the values of these two,
p book.title  # #=> `nil` : you could wind up referencing `nil` values in your program
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)