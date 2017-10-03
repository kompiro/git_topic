# frozen_string_literal: true

module GitTopic
  module Formatter
    # Helper class for Formatter classes
    module Helper
      def truncate(str, truncate_at: 20)
        omission = '...'
        length_with_room_for_omission = truncate_at - omission.length
        if str.length > truncate_at
          "#{str[0, length_with_room_for_omission]}#{omission}"
        else
          str
        end
      end
    end
  end
end
