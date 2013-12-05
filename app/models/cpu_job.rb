class CpuJob < Job

  def process_impl
    n = 25000
    r = (1..n).inject(:*) || 1
    puts r
  end
end
