require "neuralnet/version"

module Neuralnet
  # Your code goes here...
end


#Control a neural network

class NeuralNet
  def initialize inputs, weights
    begin
      if inputs.length != weights[0].length
       raise ArgumentError.new("The number of inputs does not match the network size.")
      end
    rescue ArgumentError => e
      puts e.message
    end
  end
end
