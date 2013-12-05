class IoJob < Job

  require 'open-uri'
  def process_impl
    open('http://localhost:5000/')
  end
end
