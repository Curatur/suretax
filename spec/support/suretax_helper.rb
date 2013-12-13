module SuretaxSpecHelper

  def suretax_key
    ENV['SURETAX_VALIDATION_KEY']
  end

  def suretax_url
    ENV['SURETAX_BASE_URL']
  end

end
