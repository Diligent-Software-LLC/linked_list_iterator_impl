require_relative 'test_helper'

# LinkedListIteratorTest.
# @class_description
#   Tests the LinkedListIterator class.
class LinkedListIteratorTest < Minitest::Test

  # Constants.
  CLASS          = LinkedListIterator
  ZERO           = 0
  INTEGER_DATA   = 4
  NIL_DATA       = nil
  STRING_DATA    = 'hello'
  HASH_DATA      = {}
  TIME_DATA      = Time.now()
  FLOAT_DATA     = 3.14
  COMPLEX_DATA   = Complex(1)
  MOCK_FRAMEWORK = Minitest::Mock

  # test_conf_doc_f_ex().
  # @description
  #  The .travis.yml, CODE_OF_CONDUCT.md, Gemfile, LICENSE.txt, README.md, and
  #  .yardopts files exist.
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
    @position_ll = MOCK_FRAMEWORK.new()
    @data_ll     = MOCK_FRAMEWORK.new()
    @data_ass_ll = MOCK_FRAMEWORK.new()
    @next_ll     = MOCK_FRAMEWORK.new()
    @prev_ll     = MOCK_FRAMEWORK.new()
    @init_ll     = MOCK_FRAMEWORK.new()
    @in_ll       = MOCK_FRAMEWORK.new()
    @x1_in_node  = Node.new(NIL_DATA, TIME_DATA, NIL_DATA)
    @x1_en_node  = Node.new(NIL_DATA, FLOAT_DATA, NIL_DATA)
    @en_ll       = MOCK_FRAMEWORK.new()
    @io_ll       = MOCK_FRAMEWORK.new()
    @eo_ll       = MOCK_FRAMEWORK.new()

  end

  # initialize(llist = nil)

  # test_init_x1().
  # @description
  #   No arguments.
  def test_init_x1()

    # expected1 = NodeError
    expected1 = TypeError
    assert_raises(expected1) {

      base_node = nil
      @init_ll.expect(:base, base_node)
      LinkedListIterator.new(@init_ll)

    }

  end

  # test_init_x2().
  # @description
  #   A LinkedList argument.
  def test_init_x2()

    base_node = @node
    @init_ll.expect(:base, base_node)
    @init_ll.expect(:iterator, LinkedListIterator.new(@init_ll))
    it2 = @init_ll.iterator()
    assert_same(CLASS, it2.class())
    assert_operator(it2.position(), 'equal?', ZERO)
    @init_ll.expect(:base, base_node)
    assert_operator(@node, 'equal?', @init_ll.base())

  end

  # test_init_x3().
  # @description
  #   An invalid argument.
  def test_init_x3()

    expected1 = TypeError
    assert_raises(expected1) {

      base_node = @x3_a1
      @init_ll.expect(:base, base_node)
      LinkedListIterator.new(@init_ll)

    }

  end

  # position()

  # test_position_x2()
  # @description
  #   The list size is 1.
  def test_position_x2()

    base_node = @node
    @position_ll.expect(:base, base_node)
    @position_ll.expect(:iterator, LinkedListIterator.new(@position_ll))
    lli = @position_ll.iterator()
    assert_operator(ZERO, 'equal?', lli.position())

  end

  # data()

  # test_data_x()
  # @description
  #   A size one, position zero iterator.
  def test_data_x()

    base_node = @node
    @data_ll.expect(:base, base_node)
    @data_ll.expect(:iterator, LinkedListIterator.new(@data_ll))
    lli = @data_ll.iterator()
    @data_ll.expect(:[], INTEGER_DATA, [ZERO])
    expected1 = lli.data()
    expected2 = INTEGER_DATA
    assert_operator(expected1, 'equal?', expected2)

  end

  # data=(data = nil)

  # test_data_ass_x1().
  # @description
  #   A valid data argument, and the list size is one or greater.
  def test_data_ass_x1()

    @data_ass_ll.expect(:[]=, ZERO, [ZERO])
    @data_ass_ll.expect(:base, @node)
    lli       = LinkedListIterator.new(@data_ass_ll)
    expected1 = STRING_DATA
    lli.data  = STRING_DATA
    @data_ass_ll.expect(:[], STRING_DATA, [ZERO])
    expected2 = lli.data()
    assert_same(expected1, expected2)

  end

  # test_data_ass_x2().
  # @description
  #   An invalid data argument, and the list size is one or greater.
  def test_data_ass_x2()

    expected1 = ArgumentError
    @data_ass_ll.expect(:base, @node)
    lli           = LinkedListIterator.new(@data_ass_ll)
    list_position = lli.position()
    ll_args       = [list_position, HASH_DATA]
    @data_ass_ll.expect(:[]=, ll_args, ll_args)
    assert_raises(expected1) {
      lli.data = HASH_DATA
    }

  end

  # identical_node?(inst = nil)

  # test_in_x1b().
  # @description
  #   An unidentical instance.
  def test_in_x1b()

    base_node = @node
    @in_ll.expect(:base, base_node)
    lli    = LinkedListIterator.new(@in_ll)
    in_ll1 = Minitest::Mock.new()
    in_ll1.expect(:base, Node.new(nil, nil, nil))
    refute_operator(lli, 'identical_node?', in_ll1.base())

  end

  # test_in_x2().
  # @description
  #   An invalid argument.
  def test_in_x2()

    @in_ll.expect(:base, @node)
    lli = LinkedListIterator.new(@in_ll)
    refute_operator(lli, 'identical_node?', NIL_DATA)

  end

  # eql_node?(inst = nil)

  # test_en_x1b().
  # @description
  #   A node argument.
  def test_en_x1b()

    base_node = @node
    @en_ll.expect(:base, base_node)
    lli        = LinkedListIterator.new(@en_ll)
    x1_en_node = Node.new(NIL_DATA, FLOAT_DATA, NIL_DATA)
    refute_operator(lli, 'eql_node?', x1_en_node)

  end

  # test_en_x1().
  # @description
  #   Any instance excluding a Node instance.
  def test_en_x2()

    base_node = @node
    @en_ll.expect(:base, base_node)
    lli = LinkedListIterator.new(@en_ll)
    refute_operator(lli, 'eql_node?', FLOAT_DATA)

  end

  # ===(lliter = nil)

  # test_io_x1().
  # @description
  #   An iterator identically equals itself.
  def test_io_x1()

    base_node = @node
    @io_ll.expect(:base, base_node)
    lli = LinkedListIterator.new(@io_ll)
    assert_operator(lli, '===', lli)

  end

  # test_io_x2().
  # @description
  #   A different iterator.
  def test_io_x2()

    base_node = @node
    @io_ll.expect(:base, base_node)
    io_lli1 = LinkedListIterator.new(@io_ll)
    @io_ll.expect(:base, base_node)
    io_lli2 = LinkedListIterator.new(@io_ll)
    refute_operator(io_lli1, '===', io_lli2)

  end

  # ==(lliter = nil)

  # test_eo_x1a().
  # @description
  #   An equivalent iterator.
  def test_eo_x1a()

    base_node = @node
    @eo_ll.expect(:base, base_node)
    @eo_ll.expect(:base, base_node)
    eo_lli1 = LinkedListIterator.new(@eo_ll)
    eo_lli2 = LinkedListIterator.new(@eo_ll)
    assert_same(eo_lli1.position(), eo_lli2.position())
    assert_operator(eo_lli1, '==', eo_lli2)
    assert_operator(eo_lli2, '==', eo_lli1)

  end

  # test_eo_x1b().
  # @description
  #   Iterator positions are the same. The nodes are unequivalent.
  def test_eo_x1b()

    base_node = @node
    @eo_ll.expect(:base, base_node)
    eo_lli1 = LinkedListIterator.new(@eo_ll)
    node2   = Node.new(NIL_DATA, FLOAT_DATA, NIL_DATA)
    @eo_ll.expect(:base, node2)
    eo_lli2 = LinkedListIterator.new(@eo_ll)
    assert_same(eo_lli1.position(), eo_lli2.position())
    refute_operator(eo_lli1, '==', eo_lli2)
    refute_operator(eo_lli2, '==', eo_lli1)

  end

  # test_eo_x2().
  # @description
  #   Any instance excluding a LinkedListIterator instance.
  def test_eo_x2()

    base_node = @node
    @eo_ll.expect(:base, base_node)
    eo_lli = LinkedListIterator.new(@eo_ll)
    refute_operator(eo_lli, '==', FLOAT_DATA)

  end

  # next()

  # test_next_x1().
  # @description
  #   An iterator positioned at the list's size less one.
  def test_next_x1()

    base_node = @node
    @next_ll.expect(:base, base_node)
    next_lli = LinkedListIterator.new(@next_ll)
    assert_raises(IndexError) {
      next_lli.next()
    }

  end

  # prev()

  # test_prev_x1().
  # @description
  #   A size one list and a zero-positioned iterator.
  def test_prev_x1()

    base_node = @node
    @prev_ll.expect(:base, base_node)
    prev_lli = LinkedListIterator.new(@prev_ll)
    assert_raises(IndexError) {
      prev_lli.prev()
    }

  end

  # node=(node = nil)

  # test_node_ass_x2()
  # @description
  #   Assigning an invalid Node.
  def test_node_ass_x2()

    base_node = NIL_DATA
    @init_ll.expect(:base, base_node)
    assert_raises(TypeError) {
      LinkedListIterator.new(@init_ll)
    }

  end

  # teardown().
  # @description
  #  Cleanup.
  def teardown()
  end

end
