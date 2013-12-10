class MixedJob < Job

  def process_impl
    open('http://localhost:5000/?wait_time=1')
    #n = 15000
    #(1..n).inject(:*) || 1
    BCrypt::Password.create(SecureRandom.hex(200),:cost => 14)
    open('http://localhost:5000/?wait_time=1')
  end
end

