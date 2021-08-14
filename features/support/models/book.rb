class BookModel
  attr_accessor :id, :title, :description, :pageCount, :excerpt, :publishDate

  def to_hash
    {
      id: @id,
      title: @title,
      description: @description,
      pageCount: @pageCount,
      excerpt: @excerpt,
      publishDate: @publishDate
    }
  end
end
