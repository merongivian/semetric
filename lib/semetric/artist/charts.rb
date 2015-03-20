module Semetric
  module Artist
    module Charts
      class << self
        def fans(type = 'total')
          codes = { last_day:    'bb789492225c4c4da2e15f617acc9982',
                    last_week:   'a5e7dbdfcd984dc28c350c26a2e703c0',
                    high_flyers: 'c6db7136d639444d9ab54a3c66e0b813',
                    total:       '6aacf495049d4de99c809b0ad8120c39'
                  }
          data_by_code(codes, type)
        end

        def views(type = 'total')
          codes = { last_day:    '1574c43703344292a753fecf0f793c2e',
                    last_week:   'b0de4888427d46ac8f599f2f6d51e293',
                    high_flyers: '33e77c5fcb06412193995c9a4bb054f4',
                    total:       '3040cc0f02ed4dd1a2da9ea95c9a8272'
                  }
          data_by_code(codes, type)
        end

        def comments(type = 'total')
          codes = { last_day:  'd21e3cd170924bcd8874ec15d84b64f1',
                    last_week: '75f972a32f3547e197668d545f4cda1d',
                    total:     '7908e358427f4efe9f5aac6df69bfcbd'
                  }
          data_by_code(codes, type)
        end

        def plays(type = 'total')
          codes = { last_day:    'd527eeba4bdc42178b49d977b375936f',
                    last_week:   '627b42c981d4413b83191efd8183a982',
                    high_flyers: 'b857276b34cf488f9a934765c3281af7',
                    total:       '7a614a370a2848b29c156e27dde582c8'
                  }
          data_by_code(codes, type)
        end

        private

        def data_by_code(codes, type)
          key = type.gsub(/\s/, '_').to_sym
          path = "/chart/#{codes[key]}"
          data(path)
        end

        def data(path)
          request = GetRequest.new(path, Artist::API_KEY)
          request.response('data').map do |artist_hash|
            artist_hash["artist"]["name"]
          end
        end
      end
    end
  end
end
