# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require_relative "linked_list_iterator_impl/version"

# LinkedListIterator.
# @class_description
#   A LinkedList data structure iterator implementation.
# @attr node [Node]
#   A LinkedList node.
# @attr position [Integer]
#   A list position.
class LinkedListIterator < LinkedListIteratorInt

  # initialize(llist = nil).
  # @description
  #   Initializes a LinkedListIterator.
  # @param llist [LinkedList]
  #   A list.
  # @return [LinkedListIterator]
  #   A LinkedListIterator.
  def initialize(llist = nil)
    self.node     = llist.base()
    self.position = ZERO
  end

  # position().
  # @description
  #   Gets the iterator's list position.
  # @return [Integer]
  #   The list position.
  def position()
    return @position
  end

  # data().
  # @description
  #   Gets the data at the iterator's position.
  # @return [Numeric, FalseClass, Symbol, TrueClass, String, Time, NilClass]
  #   The data at the position.
  def data()

    node = node()
    data = node.data()
    return data

  end

  # data=(data = nil).
  # @description
  #   Sets the data at the iterator's position.
  # @param data [Numeric, FalseClass, Symbol, TrueClass, String, Time, NilClass]
  #   The replacement data.
  # @return [Numeric, FalseClass, Symbol, TrueClass, String, Time, NilClass]
  #   The argument.
  def data=(data = nil)
    node      = node()
    node.data = data
  end

  # identical_node?(inst = nil).
  # @description
  #   Compares the argument and the node at the iterator's position.
  # @param inst [.]
  #   A comparison instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the argument and the node at the iterator's position
  #   are identical.
  def identical_node?(inst = nil)
    return (node() === inst)
  end

  # eql_node?(inst = nil).
  # @description
  #   Compares the argument and the node at self's position.
  # @param inst [.]
  #   A comparison instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the instances are equivalent. False otherwise.
  def eql_node?(inst = nil)
    return (node() == inst)
  end

  # ===(lliter = nil).
  # @description
  #   Identity comparison operator. Compares the argument and self.
  # @param lliter [.]
  #   A comparison instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the iterators are identical. False otherwise.
  def ===(lliter = nil)
    return equal?(lliter)
  end

  # ==(lliter = nil).
  # @description
  #   Equality operator. Compares the argument and self.
  # @param lliter [.]
  #   A comparison instance.
  # @return [TrueClass, FalseClass]
  #   True in the case the argument is an iterator, and, the iterators'
  #   positions' nodes are equal and the nodes at the remaining list positions
  #   are equal.
  def ==(lliter = nil)

    nodes_uneq = false
    case
    when !lliter.instance_of?(LinkedListIterator)
      return nodes_uneq
    when !(position() === lliter.position())
      return nodes_uneq
    else
      unless (lliter.eql_node?(node()))
        return nodes_uneq
      end
      nodes_uneq = !nodes_uneq
    end
    return nodes_uneq

  end

  # next().
  # @description
  #   Increments the iterator's list position. Sets the node attribute the
  #   node's front instance reference.
  # @return [NilClass]
  #   nil.
  def next()

    pos   = position()
    error = IndexError
    unless (pos < (count_nodes() - 1))
      raise(error, 'The position is the list\'s upper boundary.')
    else
      node          = node()
      next_node     = node.front()
      self.node     = next_node
      self.position += 1
    end
    return nil

  end

  # prev().
  # @description
  #   Decrements the iterator's list position. Sets the node attribute the
  #   node's back instance reference.
  # @return [NilClass]
  #   nil.
  def prev()

    pos   = position()
    error = IndexError.new()
    unless (pos > (count_nodes() - 1))
      raise(error, 'The position is the list\'s lower boundary.')
    else
      node          = node()
      prev_node     = node.back()
      self.node     = prev_node
      self.position -= 1
    end
    return nil

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

  # node=(node = nil).
  # @description
  #   Sets the iterator's node reference.
  # @param node [Node]
  #   The initializing linked list's node reference.
  # @return node [Node]
  #   The argument.
  def node=(node = nil)

    error = TypeError.new()
    unless (node.instance_of?(Node))
      e_message = 'Calling the constructor outside the corresponding' +
          'LinkedList\'s \'iterator\' method is illegal.'
      raise(error, e_message)
    else
      @node = node
    end

  end

  # position=(integer = nil).
  # @description
  #   Sets the iterator's position.
  # @param integer [Integer]
  #   The list position.
  # @return [Integer]
  #   The argument.
  def position=(integer = nil)

    unless (integer.instance_of?(Integer))
      e_message = "The position attribute refers an Integer instance" +
          ". #{integer} is not an Integer instance."
      raise(ArgumentError, e_message)
    else
      @position = integer
    end

  end

  # count_nodes().
  # @description
  #   Counts the list's nodes.
  # @return [Integer]
  #   The list's node quantity.
  def count_nodes()

    count = 1
    lbr   = node()
    while (!lbr.back().nil?())
      lbr = lbr.back()
    end
    while (!lbr.front().nil?())
      count += 1
      lbr   = lbr.front()
    end
    return count

  end

  # Private constants

  ZERO           = 0.freeze()
  LOWER_BOUNDARY = ZERO
  private_constant :ZERO
  private_constant :LOWER_BOUNDARY

end
