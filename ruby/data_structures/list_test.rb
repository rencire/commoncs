require 'minitest/autorun'
begin
  require_relative 'list'
rescue LoadError => e
  puts "\n\n#{e.backtrace.first} #{e.message}"
  puts DATA.read
  exit 1
end

class ListTest < Minitest::Test
  def test_search
    l = List.new
    l.push(1).push(3).push(5)

    assert_equal nil, l.search(7)
    assert_equal 1, l.search(1).item
  end

  def test_push
  end

  def test_unshift
  end

  def test_remove
    l = List.new
    l.push(1).push(3).push(5)
    l.remove(1)

    assert_equal 3, l.head.item
  end

  def test_to_s
    l = List.new
    l.push(1).push(2).push(3)
    l.to_s

    l.push(8)
    l.unshift(128)
    l.to_s

    l2 = List.new
    l2.to_s

    l3 = List.new
    l3.push(1)
    l3.to_s
  end
end

__END__

