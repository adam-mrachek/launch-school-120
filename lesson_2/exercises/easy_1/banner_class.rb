class Banner
  def initialize(message,width=nil)
    @message = message
    @width = width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def message_width
    if @width && @width >= @message.length
      @width
    else
      @message.length
    end
  end

  def empty_space
    (message_width - @message.length) / 2
  end

  def left_space
    "| #{' ' * empty_space}"
  end

  def right_space
    if message_width.odd?
      "#{' ' * empty_space}  |"
    else
      "#{' ' * empty_space} |"
    end
  end

  def horizontal_rule
    "+ #{'-' * message_width} +"
  end

  def empty_line
    "| #{' ' * message_width} |"
  end

  def message_line
    "#{left_space}#{@message}#{right_space}"
  end
end

banner = Banner.new("To boldly go where no one has gone before.", 30)
puts banner