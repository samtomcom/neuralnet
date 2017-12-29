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
      inputs = (Matrix.row_vector(inputs) * Matrix.rows(@weights[layer])).to_a[0]
      inputs = activate(bias(inputs, layer))
    end
    return inputs
  end

  private
  # apply the bias to the sum
  def bias inputs, layer
    return inputs.each_with_index.map { |x,i| x + @biases[layer][i] }
  end

  # apply an activation function
  def activate matrix
    return matrix.map! { |x| x }
  end
end
