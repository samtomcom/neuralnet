require 'neuralnet/version'
require 'matrix'

class NeuralNet
  def initialize size, weights
    @size = size
    @weights = weights
  end

  def output inputs
    (0...(@size.size - 1)).each do |layer|
      puts layer
      inputs = activate( (Matrix.row_vector(inputs) * Matrix.rows(@weights[layer])).to_a[0], layer )
    end

    return inputs
  end

  private
  def activate matrix, layer
    return matrix.map! { |x| 0.5 * Math.tanh(x / @size[layer]) + 0.5 }
  end
end
