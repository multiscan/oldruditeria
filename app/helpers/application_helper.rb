# The methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def link_to_file(name, file, *args)
     if file[0] != ?/
        file = "#{@request.relative_url_root}/#{file}" 
     end
     link_to name, file, *args
  end
  
  def cycle(first_value, *values)
    values.unshift(first_value)
    return Cycle.new(*values)
  end

  class Cycle
    def initialize(first_value, *values)
      @values = values.unshift(first_value)
      @index = 0
    end

    def to_s
      value = @values[@index].to_s
      @index = (@index + 1) % @values.size
      return value
    end
  end
  
end
