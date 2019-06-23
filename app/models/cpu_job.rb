class CpuJob < Job
  def process_impl
    BCrypt::Password.create(SecureRandom.hex(200),:cost => 14)
  end
end
