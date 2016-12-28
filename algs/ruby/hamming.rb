#  Eric Ren
#  Recursive solution
class Hamming
  def self.compute(a,b)
    if a.class != String or b.class != String
      raise 'Arguments are not both String'
    end

    if a.empty?
      return b.length
    end
    if b.empty?
      return a.length
    end


    opts = {}
    opts['I'] = 1 + self.compute(a, b[0...-1])
    opts['D'] = 1 + self.compute(a[0...-1], b)

    opts['M'] = diff(a[-1], b[-1]) + self.compute(a[0...-1], b[0...-1])


    min_pair = opts.min_by {|_,v| v }
    # print min_pair[0] + '\t'

    return min_pair[1]
  end

  def self.diff(i,j)
    if i == j
      return 0
    else
      return 1
    end
  end

end

puts Hamming.compute('ABBBA', 'ACCCA')
