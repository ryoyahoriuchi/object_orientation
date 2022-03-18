module Color
  def color
    "\e[31m#{self}\e[0m"
  end
end
String.include Color