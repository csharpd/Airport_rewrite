module Weather

  def randomise
    rand(5)
  end

  def stormy?
    randomise <= 2
  end
end