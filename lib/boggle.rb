require 'pry'
require 'set'

class Boggle
  attr_reader :dictionary, :results
  def initialize(letters)
    @letters = letters.join.downcase
    @positions = Hash.new { |letter, pos| letter[pos] = [] }
    @side = @letters.length / 4
    @letters.each_char.with_index do |x, y|
      @positions[x] << [y / @side, y % @side]
    end
    @results = []
    @visited ||= Set.new
  end

  def dictionary
    words = []
    File.open('/usr/share/dict/words', 'r').each_line do |word|
      words << word.downcase.chomp
    end
    words
  end

  def solve
    @results = []
    dictionary.each do |word|
      if has_word?(word)
        @results << word
      end
    end
    self
  end

  def has_word?(word)
    @positions[word[0]].each do |position|
      if search(word, position)
        return true
      end
    end
    false
  end

  def search(word, position, index = 1, visited = @visited.clear)
    if index == word.length
      return true
    end
    visited << position
    @positions[word[index]].each do |moving|
      #check neighbors
      neighbors = position - moving
      neighbors.each do |neighbor|
        if !visited.include?(moving) #only move on if you haven't been here before
          if search(word, moving, index + 1, visited) #recursive call moving through next neighbors
            return true
          end
        end
      end
    end
    visited.delete(position) 
    false
  end
  
end
