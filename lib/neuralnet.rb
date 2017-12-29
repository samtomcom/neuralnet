require 'neuralnet/version'
require 'matrix'

class NeuralNet
  def initialize genes
    @weights, @biases = genes

    # determine size of network
    @size = []
    @weights.each { |layer| @size << layer.size }
    @size << @biases[-1].size
  end

  # do MATRIX(inputs)*MATRIX(weights), optional bias, activation function
  def output inputs
    (0...(@size.size - 1)).each do |layer|
      puts "#{inputs}, #{layer}"
      inputs = (Matrix.row_vector(inputs) * Matrix.rows(@weights[layer])).to_a[0]
      puts "#{inputs}, #{layer}"
      inputs = bias(inputs, layer)
      puts "#{inputs}, #{layer}"
    end
    return inputs
  end

  private
  def bias inputs, layer
    return inputs.map! { |x| ( x ) / @size[layer] }
  end

  #apply an activation function
  def activate matrix
    return matrix.map! { |x| 0.5 * Math.tanh(x) + 0.5 }
  end
end
