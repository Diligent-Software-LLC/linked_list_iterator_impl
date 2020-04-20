# Copyright (C) 2020 Diligent Software LLC. All rights reserved. Released
# under the GNU General Public License, Version 3. Refer LICENSE.txt.

require 'linked_list_iterator_int'

# LinkedListIterator.
# @class_description
#   A LinkedList data structure iterator implementation.
# @attr node [Node]
#   A LinkedList node.
# @attr position [Integer]
#   A list position.
class LinkedListIterator < LinkedListIteratorInt
  VERSION = '2.0.0'.freeze()
end
