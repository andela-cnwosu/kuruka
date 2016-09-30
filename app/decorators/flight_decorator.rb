# frozen_string_literal: true
class FlightDecorator < Draper::Decorator
  delegate_all

  def pastize(word)
    if object.departed?
      ("#{word}d" if word[-1] == 'e') || "#{word}ed"
    else
      "#{word}s"
    end
  end
end
