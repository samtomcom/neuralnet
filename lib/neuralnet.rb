require 'neuralnet/version'
require 'matrix'

class NeuralNet
  def initialize size, weights
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

  private
  # apply an activation function
  def activate matrix
    return matrix.map! { |x| 0.5 * Math.tanh(x) + 0.5 }
  end
end
