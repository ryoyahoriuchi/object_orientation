module Color
  def color_red
    "\e[31m#{self}\e[0m"
  end
end
String.include Color