require 'neuralnet/version'
require 'matrix'

class NeuralNet
  def initialize size, weights, bias
    @bias = bias
    @size = size
    @weights = weights
  end

  # do MATRIX(inputs)*MATRIX(weights), optional bias, activation function
  def output inputs
    (0...(@size.size - 1)).each do |layer|
      inputs = (Matrix.row_vector(inputs) * Matrix.rows(@weights[layer])).to_a[0]
      inputs = activate(bias(inputs, layer))
    end
    return inputs
  end

  # convert the weights into a linear (1d) array for general purpose manipulation
  def linear_weights_out
    linear = []
    @weights.each { |layer| layer.each { |node| node.each { |val| linear << val } } }
    return linear
  end

  # convert linear array into the weights as a 3d array
  def linear_weights_in
  end

  private
  def bias inputs, layer
    return inputs.map! { |x| @bias ? (x+1) / (@size[layer]+1) : x / @size[layer] }
  end

  #apply an activation function
  def activate matrix
    return matrix.map! { |x| 0.5 * Math.tanh(x) + 0.5 }
  end
end
