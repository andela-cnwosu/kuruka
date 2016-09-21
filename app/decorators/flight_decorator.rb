class FlightDecorator < Draper::Decorator
  delegate_all

  def pastize(word)
    object.departed? ? (word[-1] == "e" ? "#{word}d" : "#{word}ed") : "#{word}s"
  end
end
