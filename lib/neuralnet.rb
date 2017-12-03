require 'neuralnet/version'
require 'matrix'

class NeuralNet
  def initialize size, weights, activate=:linear, bias=false
    @size = size
    @weights = weights
    @activate = activate
    @bias = bias
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
  # calculate bias node or not
  def bias inputs, layer
    return inputs.map! { |x| @bias ? (x+1) / (@size[layer]+1) : x / @size[layer] }
  end

  # apply an activation function
  def activate inputs
    if @activate == :binary
      return activate_binary(inputs)
    elsif @activate == :tanh
      return activate_tanh(inputs)
    # just the values
    else
      return inputs
    end
  end

  # activation via tanh()
  def activate_tanh matrix
    return matrix.map! { |x| 0.5 * Math.tanh(x) + 0.5 }
  end

  # 0 if <0; 1 otherwise
  def activate_binary matrix
    return matrix.map! { |x| x < 0 ? 0 : 1}
  end
end
