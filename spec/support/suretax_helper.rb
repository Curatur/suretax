module SuretaxSpecHelper

  def suretax_key
    ENV['SURETAX_VALIDATION_KEY']
  end

  def suretax_url
    ENV['SURETAX_BASE_URL']
  end

  def suretax_client_number
    ENV['SURETAX_CLIENT_NUMBER']
  end

  def suretax_post_path
    ENV['SURETAX_POST_PATH']
  end

end
