equire 'minitest/autorun'
require './wc'

class WcTest < Minitest::Test
  def test_ls
    expected = <<~TEXT
      directory  foo.txt    readme#{'     '}
      test.txt#{'   '}
    TEXT
    assert_equal expected, main('./wc_test')
  end
end
