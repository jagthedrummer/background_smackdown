class CpuJob < Job

  def process_impl
    #n = 25000
    #(1..n).inject(:*) || 1
    BCrypt::Password.create(SecureRandom.hex(200),:cost => 14)
  end

end
