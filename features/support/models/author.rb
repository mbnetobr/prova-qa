class AuthorModel
  attr_accessor :id, :idBook, :firstName, :lastName

  def to_hash
    {
      id: @id,
      idBook: @idBook,
      firstName: @firstName,
      lastName: @lastName
    }
  end
end
