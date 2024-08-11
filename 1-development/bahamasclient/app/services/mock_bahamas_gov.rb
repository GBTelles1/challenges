# Mocked Bahamas invoice register
class MockBahamasGov
  def self.mock_service(client, invoice_id)
    # This is where you would make the actual HTTP call if it were real
    uri = URI("https://bahamas.gov/register?invoice=#{invoice_id}&fiscal_id=#{client.fiscal_id}&name=#{client.name}&email=#{client.email}")
    { msg: 'Invoice created', status: 201 }
  end
end
