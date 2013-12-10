class CpuJob < Job

  def process_impl
    n = 25000
    (1..n).inject(:*) || 1
  end

end
