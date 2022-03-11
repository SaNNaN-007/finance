class Stock < ApplicationRecord

    def self.new_lookup(ticker_symbol) 

        client = IEX::Api::Client.new(publishable_token: 'Tpk_8990d57967f74ceab992ae5e6cee6ec3',
                                      secret_token: 'Tsk_3ab5792685834fd081ce4fdcd7ffb6ca',
                                      endpoint: 'https://sandbox.iexapis.com/v1')
        begin
            new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
        rescue => exception
            return nil
        end
    end

end
