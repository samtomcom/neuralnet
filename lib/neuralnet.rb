require 'neuralnet/version'
require 'matrix'

class NeuralNet
  def initialize genes
    @weights, @biases = genes
    calc_size()
  end

  # Calculate the final output of the NN
  def output inputs
    (@size.size - 1).times do |layer|
      inputs = (Matrix.row_vector(inputs) * Matrix.rows(@weights[layer])).to_a[0]
      inputs = activate(bias(inputs, layer))
    end
    return inputs
  end

  # calculate size
  def calc_size
    @size = []
    @weights.each { |layer| @size << layer.size }
    @size << @biases[-1].size
  end

  # return weights and biases
  def get_genes
    return [@weights, @biases]
  end

  # build the genes from 1d array
  def build_genes flat
    biases_number = 0
    @size.each { |i| biases_number += i }

    biases = flat.pop(biases_number - @size[0])
    weights = flat

    # biases
    size = @size.dup
    size.shift
    new_biases = []
    size.each do |s|
      section = biases.shift(s)
      new_biases << section
    end

    # weights
    size = @size.dup
    size.pop
    new_weights = []
    size.each_with_index do |s,i|
      section = weights.shift(s*@size[i+1])
      sec = []
      section.each_slice(@size[i+1]) { |split| sec << split }
      new_weights << sec
    end

    return [new_weights, new_biases]
  end

  # update genes
  def update_genes genes
    @weights, @biases = genes
    calc_size()
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
