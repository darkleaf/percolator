class TypografFilter < HTML::Pipeline::Filter
  cattr_reader(:service_url){ 'http://www.typograf.ru/webservice/' }
  cattr_reader(:timeout){ 5 }

  def call
    return doc unless need_process?
    process html
  end

  private
  def process(html)
    payload = { text: html, chr: 'UTF-8' }
    RestClient::Request.execute method: :post, url: service_url, timeout: timeout, payload: payload
  rescue => e
    Rails.logger.error e
    doc
  end

  def need_process?
    !Rails.env.test?
  end
end
