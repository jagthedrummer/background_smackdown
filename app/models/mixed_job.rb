class MixedJob < Job

  def process_impl
    open('http://localhost:5000/?wait_time=1')
    n = 15000
    (1..n).inject(:*) || 1
    open('http://localhost:5000/?wait_time=1')
  end
end

