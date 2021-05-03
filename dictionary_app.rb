require "http"

system "clear"
puts "Welcome to the Dictionary App! Press 'q' to quit!"

word = ""
puts "Please enter a word: "
loop do
  word = gets.chomp
  exit if word == 'q'

  # Definition -----------------------------------------------------------
  request_definition = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=48dd829661f515d5abc0d03197a00582e888cc7da2484d5c7")


  definition_data = request_definition.parse
  def_element = 0
  if definition_data[def_element]["text"]
    p "The definition of #{word} is: " + definition_data[def_element]["text"]
  else
    def_element = def_element + 1 until definition_data[def_element]["text"]
    p "The definition of #{word} is: " + definition_data[def_element]["text"]
  end

  # Example -----------------------------------------------------------
  request_example = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/topExample?useCanonical=false&api_key=48dd829661f515d5abc0d03197a00582e888cc7da2484d5c7")

  example_data = request_example.parse

  if example_data["text"]
    p "The top example of #{word} is: " + example_data["text"]
  end

  # Pronouciation -----------------------------------------------------------
  request_pronounciation = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/pronunciations?useCanonical=false&limit=50&api_key=48dd829661f515d5abc0d03197a00582e888cc7da2484d5c7")

  pronounce_data = request_pronounciation.parse
  pronounce_element = 0
  if pronounce_data[pronounce_element]["raw"]
    p "The pronounciation of #{word} is: " + pronounce_data[pronounce_element]["raw"]
  else
    pronounce_element = pronounce_element + 1 until pronounce_data[pronounce_element]["raw"]
    p "The pronounciation of #{word} is: " + pronounce_data[ pronounce_element]["raw"]
  end
  puts "Please enter another word or enter 'q' to quit: "
end



