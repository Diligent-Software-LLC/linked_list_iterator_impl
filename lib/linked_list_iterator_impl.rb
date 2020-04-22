# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "linked_list_iterator_impl/version"
require 'node'

# LinkedListIterator.
# @class_description
#   A LinkedList data structure iterator implementation.
# @attr node [Node]
#   A LinkedList node.
# @attr position [Integer]
#   A list position.
class LinkedListIterator < LinkedListIteratorInt

  # initialize(l_n = nil).
  # @description
  #   Initializes a LinkedListIterator instance.
  # @param l_n [LinkedList]
  #   A list.
  # @return [LinkedListIterator]
  #   A LinkedListIterator instance.
  def initialize(l_n = nil)
    self.node     = l_n
    self.position = ZERO
  end

  # element().
  # @description
  #   Gets the position's list element.
  # @return [Node]
  #   The element reference.
  def element()
    return node()
  end

  # position().
  # @description
  #   Gets position.
  # @return [Integer]
  #   The list position.
  def position()
    return @position
  end

  # data().
  # @description
  #   Gets node's data.
  # @return [DataType]
  #   The data.
  def data()

    node = node()
    data = node.d()
    return data

  end

  # data=(dti = nil).
  # @description
  #   Sets node's data.
  # @param dti [DataType]
  #   The data setting.
  # @return [DataType]
  #   The argument.
  # @raise [DataError]
  #   In the case the argument is anything other than a DataType type instance.
  def data=(dti = nil)
    node().substitute(dti)
    return dti
  end

  # ===(inst = nil).
  # @description
  #   Identity comparison operator. Compares the argument and self.
  # @param inst [.]
  #   A comparison instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the instances are identical. False otherwise.
  def ===(inst = nil)
    return equal?(inst)
  end

  # ==(inst = nil).
  # @description
  #   Equality operator. Compares the argument and self.
  # @param inst [.]
  #   A comparison instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the argument is an iterator and the iterators are
  #   attributively equal. Attributive equality refers the iterators' nodes
  #   and the iterators' sizes are 'eql?'.
  def ==(inst = nil)

    nodes_uneq = false
    case
    when !inst.instance_of?(LinkedListIterator)
      return nodes_uneq
    when !(position().eql?(inst.position()) && node().eql?(inst.node_ref()))
      return nodes_uneq
    else
      nodes_uneq = !nodes_uneq
    end
    return nodes_uneq

  end

  # prev().
  # @description
  #   Decrements position. Sets node the back reference.
  # @return [NilClass]
  #   nil.
  def prev()

    error = IndexError
    unless (node().back_attached())
      raise(error, 'The position is zero.')
    else

      n_a           = node().adapt()
      self.node     = n_a.back()
      self.position -= ONE

    end
    return nil

  end

  # next().
  # @description
  #   Increments position. Sets node the node's front reference.
  # @return [NilClass]
  #   nil.
  def next()

    error = IndexError
    unless (node().front_attached())
      raise(error, 'The position is the list\'s size less one.')
    else

      n_a           = node().adapt()
      self.node     = n_a.front()
      self.position += ONE

    end
    return nil

  end

  protected

  # node_ref().
  # @description
  #   Gets node's reference.
  # @return [Node]
  #   node's reference.
  def node_ref()
    return node()
  end

  private

  # node().
  # @description
  #   Gets the iterator's node reference.
  # @return [Node]
  #   The list's node reference at the iterator's position.
  def node()
    return @node
  end

  # node=(n = nil).
  # @description
  #   Sets node.
  # @param n [Node]
  #   The initializing node reference.
  # @return [Node]
  #   The argument.
  def node=(n = nil)

    error = NodeError.new()
    unless (n.instance_of?(Node))

      e_message = 'Calling the constructor outside the corresponding' +
          'LinkedList\'s \'iterator()\' method is illegal.'
      raise(error, e_message)

    else
      @node = n
    end

  end

  # position=(int = nil).
  # @description
  #   Sets position.
  # @param int [Integer]
  #   The list position. Any number zero through list size less one.
  # @return [Integer]
  #   The argument.
  def position=(int = nil)
    @position = int
  end

  # Private constants

  ZERO           = 0
  ONE            = 1
  LOWER_BOUNDARY = ZERO
  private_constant :ZERO
  private_constant :ONE
  private_constant :LOWER_BOUNDARY

end
