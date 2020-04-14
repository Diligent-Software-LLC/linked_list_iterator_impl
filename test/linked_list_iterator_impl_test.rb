require_relative 'test_helper'

# LinkedListIteratorTest.
# @class_description
#   Tests the LinkedListIterator implementation.
class LinkedListIteratorTest < Minitest::Test

  # Constants.
  CLASS        = LinkedListIterator
  ZERO         = 0
  INTEGER_DATA = 4
  NIL_DATA     = nil
  STRING_DATA  = 'hello'
  HASH_DATA    = {}
  TIME_DATA    = Time.now()
  FLOAT_DATA   = 3.14
  COMPLEX_DATA = Complex(1)

  # test_conf_doc_f_ex().
  # @description
  #   The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md, and
  #   .yardopts files exist.
  def test_conf_doc_f_ex()

    assert_path_exists('.travis.yml')
    assert_path_exists('CODE_OF_CONDUCT.md')
    assert_path_exists('Gemfile')
    assert_path_exists('LICENSE.txt')
    assert_path_exists('README.md')
    assert_path_exists('.yardopts')

  end

  # test_version_declared().
  # @description
  #   The version was declared.
  def test_version_declared()
    refute_nil(CLASS::VERSION)
  end

  # setup().
  # @description
  #   Set fixtures.
  def setup()
    @node        = Node.new(NIL_DATA, INTEGER_DATA, NIL_DATA)
  end

  # initialize(l_n = nil)

  # test_init_x1().
  # @description
  #   A data argument.
  def test_init_x1()
    x1_it = LinkedListIterator.new(@node)
    assert_operator(x1_it, 'identical_node?', @node)
  end

  # test_init_x2().
  # @description
  #   An invalid argument.
  def test_init_x2()
    assert_raises(NodeError) { LinkedListIterator.new(INTEGER_DATA) }
  end

  # test_init_x3().
  # @description
  #   No arguments.
  def test_init_x3()
    assert_raises(NodeError) { LinkedListIterator.new() }
  end

  # position()

  # test_position_x2()
  # @description
  #   The list size is 1.
  def test_position_x2()
    x2_it = LinkedListIterator.new(@node)
    assert_operator(ZERO, 'equal?', x2_it.position())
  end

  # data()

  # test_data_x2()
  # @description
  #   A valid Node, and valid data.
  def test_data_x2()
    x2_it = LinkedListIterator.new(@node)
    assert_same(@node.data(), x2_it.data())
  end

  # data=(dti = nil)

  # test_data_ass_x1().
  # @description
  #   A valid data argument.
  def test_data_ass_x1()

    x1_it      = LinkedListIterator.new(@node)
    x1_it.data = STRING_DATA
    assert_operator(STRING_DATA, 'equal?', x1_it.data())

  end

  # test_data_ass_x2().
  # @description
  #   An invalid argument.
  def test_data_ass_x2()

    assert_raises(DataError) {
      x2_it      = LinkedListIterator.new(@node)
      x2_it.data = HASH_DATA
    }

  end

  # test_data_ass_x3().
  # @description
  #   No arguments.
  def test_data_ass_x3()
    assert_raises(NodeError) { LinkedListIterator.new() }
  end

  # identical_node?(inst = nil)

  # test_in_x1a().
  # @description
  #   An identical instance.
  def test_in_x1a()
    x1_it = LinkedListIterator.new(@node)
    assert_operator(x1_it, 'identical_node?', @node)
  end

  # test_in_x1b().
  # @description
  #   A different instance.
  def test_in_x1b()

    diff  = Node.new(NIL_DATA, COMPLEX_DATA, NIL_DATA)
    x1_it = LinkedListIterator.new(@node)
    refute_operator(x1_it, 'identical_node?', diff)

  end

  # test_in_x2().
  # @description
  #   A String instance argument.
  def test_in_x2()
    x2_it = LinkedListIterator.new(@node)
    refute_operator(x2_it, 'identical_node?', STRING_DATA)
  end

  # eql_node?(inst = nil)

  # test_en_x1a().
  # @description
  #   An equal Node argument.
  def test_en_x1a()
    x1_it = LinkedListIterator.new(@node)
    assert_operator(x1_it, 'eql_node?', @node)
  end

  # test_en_x1b().
  # @description
  #   An unequal node argument.
  def test_en_x1b()

    uneq  = Node.new(NIL_DATA, TIME_DATA, NIL_DATA)
    x1_it = LinkedListIterator.new(@node)
    refute_operator(x1_it, 'eql_node?', uneq)

  end

  # test_en_x1().
  # @description
  #   Any instance excluding a Node instance.
  def test_en_x1()
    x1_it = LinkedListIterator.new(@node)
    refute_operator(x1_it, 'eql_node?', FLOAT_DATA)
  end

  # ===(inst = nil)

  # test_io_x1().
  # @description
  #   An iterator identically equals itself.
  def test_io_x1()
    x1_it = LinkedListIterator.new(@node)
    assert_operator(x1_it, '===', x1_it)
  end

  # test_io_x2().
  # @description
  #   A different iterator.
  def test_io_x2()

    x1_it1 = LinkedListIterator.new(@node)
    x1_it2 = LinkedListIterator.new(@node)
    refute_operator(x1_it1, '===', x1_it2)

  end

  # ==(inst = nil)

  # test_eo_x1a().
  # @description
  #   An equivalent iterator.
  def test_eo_x1a()

    x1_it1 = LinkedListIterator.new(@node)
    x1_it2 = LinkedListIterator.new(@node)
    assert_operator(x1_it1, '==', x1_it2)

  end

  # test_eo_x2().
  # @description
  #   An unequal iterator instance.
  def test_eo_x2()

    x2_it1 = LinkedListIterator.new(@node)
    x2_it2 = LinkedListIterator.new(Node.new(NIL_DATA, STRING_DATA, NIL_DATA))
    refute_operator(x2_it1, '==', x2_it2)

  end

  # test_eo_x3().
  # @description
  #   A data argument.
  def test_eo_x3()
    x3_it = LinkedListIterator.new(@node)
    refute_operator(x3_it, '==', INTEGER_DATA)
  end

  # next()

  # test_next_x1().
  # @description
  #   An iterator positioned at the list's size less one.
  def test_next_x1()
    x1_it = LinkedListIterator.new(@node)
    assert_raises(IndexError) { x1_it.next() }
  end

  # prev()

  # test_prev_x1().
  # @description
  #   A size one list and a zero-positioned iterator.
  def test_prev_x1()
    x1_it = LinkedListIterator.new(@node)
    assert_raises(IndexError) { x1_it.prev() }
  end

  # teardown().
  # @description
  #  Cleanup.
  def teardown()
  end

end
